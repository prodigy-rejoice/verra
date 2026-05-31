import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.logger.dart';

class OnboardingViewModel extends BaseViewModel {
  final Logger _logger = getLogger('OnboardingViewModel');

  void init() {
    _logger.i('Onboarding initialized');
  }
}
