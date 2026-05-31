import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../core/constants/app_strings.dart';
import '../../core/exceptions/verra_exception.dart';
import '../../models/leaderboard_entry.dart';
import '../../repositories/leaderboard_repository.dart';

class LeaderboardViewModel extends BaseViewModel {
  final LeaderboardRepository _leaderboardRepository =
      locator<LeaderboardRepository>();
  final Logger _logger = getLogger('LeaderboardViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';
  static const int _topPlayersLimit = 50;

  List<LeaderboardEntry> _entries = const [];
  List<LeaderboardEntry> get entries => _entries;

  LeaderboardEntry? _currentPlayerEntry;
  LeaderboardEntry? get currentPlayerEntry => _currentPlayerEntry;

  String? _currentWalletAddress;
  String? get currentWalletAddress => _currentWalletAddress;

  bool get isEmpty => !isBusy && !hasError && _entries.isEmpty;

  Future<void> init() async {
    _logger.i('Leaderboard initialized');
    await _load();
  }

  Future<void> refresh() => _load();

  Future<void> _load() async {
    setBusy(true);
    try {
      _currentWalletAddress = await _readSavedWalletAddress();
      _entries = await _leaderboardRepository.getTopPlayers(
        limit: _topPlayersLimit,
      );
      _currentPlayerEntry = _findCurrentPlayer(_entries, _currentWalletAddress);
      _logger.d('Loaded ${_entries.length} entries');
      notifyListeners();
    } on VerraException catch (e) {
      _logger.w('Leaderboard load failed: ${e.message}');
      setError(e.message);
    } catch (e, stack) {
      _logger.e('Leaderboard load error', error: e, stackTrace: stack);
      setError(AppStrings.somethingWentWrong);
    } finally {
      setBusy(false);
    }
  }

  LeaderboardEntry? _findCurrentPlayer(
    List<LeaderboardEntry> entries,
    String? walletAddress,
  ) {
    if (walletAddress == null) return null;
    for (final entry in entries) {
      if (entry.walletAddress == walletAddress) return entry;
    }
    return null;
  }

  Future<String?> _readSavedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletAddressKey);
  }
}
