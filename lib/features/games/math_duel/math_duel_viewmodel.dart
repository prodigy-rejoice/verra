import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.logger.dart';

class MathDuelViewModel extends BaseViewModel {
  final Logger _logger = getLogger('MathDuelViewModel');

  void init() {
    _logger.i('Math Duel initialized');
  }
}
