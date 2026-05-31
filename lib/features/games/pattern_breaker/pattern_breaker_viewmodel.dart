import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.logger.dart';

class PatternBreakerViewModel extends BaseViewModel {
  final Logger _logger = getLogger('PatternBreakerViewModel');

  void init() {
    _logger.i('Pattern Breaker initialized');
  }
}
