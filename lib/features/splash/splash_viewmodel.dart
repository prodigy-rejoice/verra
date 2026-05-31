import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('SplashViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';
  static const Duration _minimumSplashDuration = Duration(seconds: 2);

  Future<void> init() async {
    _logger.i('Splash initialized');
    final stopwatch = Stopwatch()..start();
    final savedAddress = await _readSavedWalletAddress();
    final elapsed = stopwatch.elapsed;
    if (elapsed < _minimumSplashDuration) {
      await Future<void>.delayed(_minimumSplashDuration - elapsed);
    }
    await _routeFromSession(savedAddress);
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

  Future<void> _routeFromSession(String? walletAddress) async {
    final destination = walletAddress == null || walletAddress.isEmpty
        ? Routes.authView
        : Routes.homeView;
    _logger.i('Routing to $destination');
    await _navigationService.replaceWith(destination);
  }
}
