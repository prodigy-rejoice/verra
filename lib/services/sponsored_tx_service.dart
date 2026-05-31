import 'package:logger/logger.dart';
import '../app/app.logger.dart';

class SponsoredTxService {
  final Logger _logger = getLogger('SponsoredTxService');

  Future<String> sponsorAndSubmit({
    required String senderAddress,
    required String transactionBytes,
  }) async {
    _logger.i('Sponsoring transaction for $senderAddress');
    throw UnimplementedError();
  }

  Future<bool> isSponsorAvailable() async {
    _logger.i('Checking sponsor wallet availability');
    throw UnimplementedError();
  }
}
