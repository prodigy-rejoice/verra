import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.logger.dart';

class WordStakeViewModel extends BaseViewModel {
  final Logger _logger = getLogger('WordStakeViewModel');

  void init() {
    _logger.i('Word Stake initialized');
  }
}
