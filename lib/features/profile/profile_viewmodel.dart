import 'dart:ui';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../core/constants/app_strings.dart';
import '../../core/exceptions/verra_exception.dart';
import '../../models/player_profile.dart';
import '../../repositories/player_repository.dart';

class ProfileViewModel extends BaseViewModel {
  final PlayerRepository _playerRepository = locator<PlayerRepository>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('ProfileViewModel');

  static const String _walletAddressKey = 'verra_wallet_address';

  PlayerProfile? _profile;
  PlayerProfile? get profile => _profile;

  VoidCallback? _onPlayPressedOverride;

  Future<void> init({VoidCallback? onPlayPressedOverride}) async {
    _onPlayPressedOverride = onPlayPressedOverride;
    await _loadProfile();
  }

  Future<void> _loadProfile() async {
    setBusy(true);
    _logger.i('Loading profile');
    try {
      final walletAddress = await _readSavedWalletAddress();
      if (walletAddress == null) {
        setError(AppStrings.sessionExpired);
        return;
      }
      _profile = await _playerRepository.getProfile(walletAddress);
      _logger.d('Profile loaded — rep ${_profile?.repScore}');
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

  Future<void> refresh() => _loadProfile();

  Future<void> onPlayPressed() async {
    if (_onPlayPressedOverride != null) {
      _onPlayPressedOverride!();
      return;
    }
    await _navigationService.navigateTo(Routes.challengeLobbyView);
  }

  Future<String?> _readSavedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletAddressKey);
  }
}
