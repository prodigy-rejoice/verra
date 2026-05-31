import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../repositories/player_repository.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final Logger _logger = getLogger('SplashViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';
  static const Duration _minimumSplashDuration = Duration(seconds: 2);

  Future<void> init() async {
    _logger.i('Splash initialized');
    final stopwatch = Stopwatch()..start();
    final destination = await _resolveDestination();
    final elapsed = stopwatch.elapsed;
    if (elapsed < _minimumSplashDuration) {
      await Future<void>.delayed(_minimumSplashDuration - elapsed);
    }
    _logger.i('Routing to $destination');
    await _navigationService.replaceWith(destination);
  }

  Future<String> _resolveDestination() async {
    try {
      final address = await _readSavedWalletAddress();
      if (address == null || address.isEmpty) return Routes.authView;
      final exists = await _playerRepository.hasProfile(address);
      _logger.d('Profile exists: $exists');
      return exists ? Routes.homeView : Routes.authView;
    } catch (e, stack) {
      _logger.e('Splash routing error', error: e, stackTrace: stack);
      return Routes.authView;
    }
  }

  Future<String?> _readSavedWalletAddress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final address = prefs.getString(_walletAddressKey);
      _logger.d('Saved wallet address: ${address ?? 'none'}');
      return address;
    } catch (e, stack) {
      _logger.e('Failed to read saved wallet', error: e, stackTrace: stack);
      return null;
    }
  }
}
