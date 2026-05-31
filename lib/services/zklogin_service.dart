import 'package:logger/logger.dart';
import '../app/app.logger.dart';

class ZkLoginService {
  final Logger _logger = getLogger('ZkLoginService');

  static const String _testWalletAddress = '0xVERRA_TEST_WALLET';

  Future<String> signInWithGoogle() async {
    _logger.i('Initiating Google zkLogin flow');
    // TEST STUB — replace with real Google OAuth + zkLogin proof generation.
    await Future<void>.delayed(const Duration(seconds: 2));
    _logger.d('Returning test wallet $_testWalletAddress');
    return _testWalletAddress;
  }

  Future<void> signOut() async {
    _logger.i('Signing out current zkLogin session');
    throw UnimplementedError();
  }

  Future<String?> getCurrentWalletAddress() async {
    _logger.i('Reading cached wallet address');
    throw UnimplementedError();
  }

  Future<bool> isSessionValid() async {
    _logger.i('Validating zkLogin session');
    throw UnimplementedError();
  }
}
