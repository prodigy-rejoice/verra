import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../core/constants/app_strings.dart';
import '../../core/exceptions/verra_exception.dart';
import '../../core/utils/nickname_generator.dart';
import '../../repositories/player_repository.dart';
import '../../services/zklogin_service.dart';

class AuthViewModel extends BaseViewModel {
  final ZkLoginService _zkLoginService = locator<ZkLoginService>();
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final Logger _logger = getLogger('AuthViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';
  static const String _displayNameKey = 'verra_display_name';

  bool _isSigningIn = false;
  bool get isSigningIn => _isSigningIn;

  void init() {
    _logger.i('Auth initialized');
  }

  Future<void> signInWithGoogle() async {
    if (_isSigningIn) return;
    _setSigningIn(true);
    _logger.i('Signing in with Google');
    try {
      final walletAddress = await _zkLoginService.signInWithGoogle();
      await _persistWalletAddress(walletAddress);
      _logger.d('Sign-in succeeded — wallet $walletAddress');
      await _ensureProfile(walletAddress);
      await _navigationService.replaceWith(Routes.homeView);
    } on VerraException catch (e) {
      _logger.w('Sign-in failed: ${e.message}');
      _showError(e.message);
    } catch (e, stack) {
      _logger.e('Sign-in error', error: e, stackTrace: stack);
      _showError(AppStrings.somethingWentWrong);
    } finally {
      _setSigningIn(false);
    }
  }

  Future<void> _ensureProfile(String walletAddress) async {
    try {
      final exists = await _playerRepository.hasProfile(walletAddress);
      if (!exists) {
        _logger.i('No profile found — creating on-chain profile');
        await _playerRepository.createProfile();
        _logger.d('On-chain profile created');
      }
    } catch (e, stack) {
      _logger.e('Profile creation failed', error: e, stackTrace: stack);
      _snackbarService.showSnackbar(
        message: 'Profile setup failed. It will be retried on next login.',
      );
    }
  }

  Future<void> _persistWalletAddress(String walletAddress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_walletAddressKey, walletAddress);
    if (!prefs.containsKey(_displayNameKey)) {
      final nickname = NicknameGenerator.fromAddress(walletAddress);
      await prefs.setString(_displayNameKey, nickname);
      _logger.d('Assigned nickname $nickname');
    }
  }

  void _setSigningIn(bool value) {
    _isSigningIn = value;
    notifyListeners();
  }

  void _showError(String message) {
    _snackbarService.showSnackbar(message: message);
  }
}
