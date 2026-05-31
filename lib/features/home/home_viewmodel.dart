import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../core/constants/app_strings.dart';
import '../../core/exceptions/verra_exception.dart';
import '../../core/extensions/string_extensions.dart';
import '../../models/player_profile.dart';
import '../../repositories/player_repository.dart';

enum HomeTab { play, leaderboard, profile }

class HomeViewModel extends BaseViewModel {
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('HomeViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';

  HomeTab _activeTab = HomeTab.play;
  HomeTab get activeTab => _activeTab;

  PlayerProfile? _profile;
  PlayerProfile? get profile => _profile;

  String? _walletAddress;
  String? get walletAddress => _walletAddress;

  String get displayName {
    final name = _profile?.displayName;
    if (name != null && name.isNotEmpty) return name;
    return _walletAddress?.shortAddress ?? '';
  }

  void setActiveTab(HomeTab tab) {
    if (_activeTab == tab) return;
    _activeTab = tab;
    notifyListeners();
  }

  void switchToPlayTab() => setActiveTab(HomeTab.play);

  Future<void> init() async {
    _logger.i('Home initialized');
    await _loadProfile();
  }

  Future<void> _loadProfile() async {
    setBusy(true);
    try {
      _walletAddress = await _readSavedWalletAddress();
      if (_walletAddress == null) {
        setError(AppStrings.sessionExpired);
        return;
      }
      _profile = await _playerRepository.getProfile(_walletAddress!);
      _logger.d('Profile loaded — rep ${_profile?.repScore}');
      notifyListeners();
    } on VerraException catch (e) {
      _logger.w('Home profile load failed: ${e.message}');
      setError(e.message);
    } catch (e, stack) {
      _logger.e('Home profile load error', error: e, stackTrace: stack);
      setError(AppStrings.somethingWentWrong);
    } finally {
      setBusy(false);
    }
  }

  Future<void> refresh() => _loadProfile();

  Future<void> findMatch() async {
    _logger.i('Navigating to challenge lobby');
    await _navigationService.navigateTo(Routes.challengeLobbyView);
  }

  Future<String?> _readSavedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletAddressKey);
  }
}
