import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.logger.dart';

class MatchResultViewModel extends BaseViewModel {
  final Logger _logger = getLogger('MatchResultViewModel');

  void init() {
    _logger.i('Match Result initialized');
  }
}
