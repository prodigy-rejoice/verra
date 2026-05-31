import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.logger.dart';

class CryptoTriviaViewModel extends BaseViewModel {
  final Logger _logger = getLogger('CryptoTriviaViewModel');

  void init() {
    _logger.i('Crypto Trivia initialized');
  }
}
