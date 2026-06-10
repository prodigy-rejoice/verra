import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';

class PlayModeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PlayModeViewModel');

  Future<void> navigateToPractice() async {
    _logger.i('Navigating to practice lobby');
    await _navigationService.navigateTo(Routes.practiceLobbyView);
  }

  Future<void> navigateToPlayOnline() async {
    _logger.i('Navigating to challenge lobby');
    await _navigationService.navigateTo(Routes.challengeLobbyView);
  }
}