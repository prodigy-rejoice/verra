import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.logger.dart';

class ChainReflexViewModel extends BaseViewModel {
  final Logger _logger = getLogger('ChainReflexViewModel');

  void init() {
    _logger.i('Chain Reflex initialized');
  }
}
