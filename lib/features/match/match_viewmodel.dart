import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.logger.dart';

class MatchViewModel extends BaseViewModel {
  final Logger _logger = getLogger('MatchViewModel');

  void init() {
    _logger.i('Match initialized');
  }
}
