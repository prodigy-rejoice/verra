import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../core/constants/app_strings.dart';
import '../../core/enums/challenge_type.dart';
import '../../core/exceptions/verra_exception.dart';
import '../../models/player_profile.dart';
import '../../repositories/player_repository.dart';

class ChallengeLobbyViewModel extends BaseViewModel {
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final Logger _logger = getLogger('ChallengeLobbyViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';
  static const List<int> stakePresets = [50, 100, 200, 500];

  PlayerProfile? _profile;
  PlayerProfile? get profile => _profile;

  ChallengeType? _selectedChallengeType;
  ChallengeType? get selectedChallengeType => _selectedChallengeType;

  int? _selectedStake;
  int? get selectedStake => _selectedStake;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  int get maxStake => _profile?.maxStake ?? 0;

  bool get canProceed {
    if (_isSearching) return false;
    final type = _selectedChallengeType;
    final stake = _selectedStake;
    if (type == null || stake == null) return false;
    return stake <= maxStake;
  }

  Future<void> init() async {
    _logger.i('Challenge lobby initialized');
    await _loadProfile();
  }

  Future<void> _loadProfile() async {
    setBusy(true);
    try {
      final walletAddress = await _readSavedWalletAddress();
      if (walletAddress == null) {
        setError(AppStrings.sessionExpired);
        return;
      }
      _profile = await _playerRepository.getProfile(walletAddress);
      _logger.d('Profile loaded — max stake $maxStake');
      notifyListeners();
    } on VerraException catch (e) {
      _logger.w('Profile load failed: ${e.message}');
      setError(e.message);
    } catch (e, stack) {
      _logger.e('Profile load error', error: e, stackTrace: stack);
      setError(AppStrings.somethingWentWrong);
    } finally {
      setBusy(false);
    }
  }

  void selectChallengeType(ChallengeType type) {
    if (_isSearching) return;
    _selectedChallengeType = type;
    notifyListeners();
  }

  void selectStake(int stake) {
    if (_isSearching) return;
    _selectedStake = stake;
    notifyListeners();
  }

  bool isStakeAffordable(int stake) => stake <= maxStake;

  Future<void> findMatch() async {
    if (!canProceed) return;
    _logger.i(
      'Find match — type=${_selectedChallengeType?.key} stake=$_selectedStake',
    );
    _isSearching = true;
    notifyListeners();
  }

  void cancelSearch() {
    if (!_isSearching) return;
    _logger.i('Cancelled matchmaking search');
    _isSearching = false;
    notifyListeners();
  }

  Future<String?> _readSavedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletAddressKey);
  }
}
