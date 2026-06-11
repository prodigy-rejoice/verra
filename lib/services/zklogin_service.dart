import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:sui_dart/sui_account.dart';

import '../app/app.logger.dart';
import '../core/exceptions/verra_exception.dart';

class ZkLoginService {
  final Logger _logger = getLogger('ZkLoginService');
  final Dio _dio = Dio();
  GoogleSignIn? _googleSignIn;
  String? _currentWalletAddress;
  String? _currentJwt;
  String? _currentNonce;
  Map<String, dynamic>? _zkProof;
  SuiAccount? _ephemeralKeypair;

  static const String _proverUrl = 'https://prover-dev.mystenlabs.com/v1';
  static const int _saltBytes = 16;
  static const int _proverSuccessStatus = 200;
  static const int _nonceSuccessStatus = 200;

  Future<void> initialize() async {
    _googleSignIn = GoogleSignIn(
      clientId: dotenv.env['GOOGLE_IOS_CLIENT_ID'],
      serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
      scopes: const ['openid', 'email'],
    );
  }

  Future<String?> signInWithGoogle() async {
    _logger.i('Starting zkLogin flow');
    _ephemeralKeypair = SuiAccount.ed25519Account();
    final ephemeralPublicKey =
        base64Url.encode(_ephemeralKeypair!.getPublicKey());
    final bundle = await _fetchZkLoginNonce(ephemeralPublicKey);
    _currentNonce = bundle.nonce;

    _googleSignIn = GoogleSignIn(
      clientId: dotenv.env['GOOGLE_IOS_CLIENT_ID'],
      serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
      scopes: const ['openid', 'email'],
      hostedDomain: '',
    );

    final account = await _googleSignIn!.signIn();
    if (account == null) {
      _logger.w('Google sign in cancelled');
      return null;
    }
    final idToken = await _extractIdToken(account);
    _currentJwt = idToken;
    _logger.d('Got Google JWT');

    _zkProof = await _getZkProof(
      jwt: idToken,
      extendedEphemeralPublicKey: bundle.extendedEphemeralPublicKey,
      maxEpoch: bundle.maxEpoch,
      randomness: bundle.randomness,
      salt: _generateSalt(idToken),
    );

    _currentWalletAddress = _deriveAddressFromJwt(idToken);
    _logger.i('Wallet address derived');
    return _currentWalletAddress;
  }

  Future<_NonceBundle> _fetchZkLoginNonce(String ephemeralPublicKey) async {
    final url = dotenv.env['ZKLOGIN_NONCE_URL'];
    if (url == null || url.isEmpty) {
      throw const VerraException('ZKLOGIN_NONCE_URL is not configured');
    }
    _logger.i('Fetching zkLogin nonce from service');
    final response = await _dio.post<dynamic>(
      url,
      options: Options(
        headers: const {'Content-Type': 'application/json'},
        validateStatus: (_) => true,
      ),
      data: jsonEncode({'ephemeralPublicKey': ephemeralPublicKey}),
    );
    if (response.statusCode != _nonceSuccessStatus) {
      _logger.e('Nonce service returned ${response.statusCode}: ${response.data}');
      throw VerraException('Nonce service error: ${response.data}');
    }
    final data = response.data as Map<String, dynamic>;
    return _NonceBundle(
      nonce: data['nonce'] as String,
      randomness: data['randomness'] as String,
      extendedEphemeralPublicKey: data['extendedEphemeralPublicKey'] as String,
      maxEpoch: int.parse(data['maxEpoch'].toString()),
    );
  }

  Future<String> _extractIdToken(GoogleSignInAccount account) async {
    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null) {
      _logger.e('No ID token from Google');
      throw const VerraException('Failed to get Google ID token');
    }
    return idToken;
  }

  String _deriveAddressFromJwt(String jwt) {
    final decodedJwt = JwtDecoder.decode(jwt);
    final sub = decodedJwt['sub'] as String;
    final iss = decodedJwt['iss'] as String;
    final aud = decodedJwt['aud'];
    final audience = aud is List ? aud.first as String : aud as String;
    return _deriveWalletAddress(sub, iss, audience);
  }

  Future<Map<String, dynamic>> _getZkProof({
    required String jwt,
    required String extendedEphemeralPublicKey,
    required int maxEpoch,
    required String randomness,
    required String salt,
  }) async {
    _logger.i('Requesting ZK proof from prover');
    try {
      final response = await _dio.post<dynamic>(
        _proverUrl,
        options: Options(
          headers: const {'Content-Type': 'application/json'},
          validateStatus: (_) => true,
        ),
        data: jsonEncode({
          'jwt': jwt,
          'extendedEphemeralPublicKey': extendedEphemeralPublicKey,
          'maxEpoch': maxEpoch,
          'jwtRandomness': randomness,
          'salt': salt,
          'keyClaimName': 'sub',
        }),
      );
      if (response.statusCode != _proverSuccessStatus) {
        _logger.e('Prover returned ${response.statusCode}: ${response.data}');
        throw VerraException('Prover error: ${response.data}');
      }
      _logger.d('ZK proof received');
      return response.data as Map<String, dynamic>;
    } catch (e, stack) {
      _logger.e('Failed to get ZK proof', error: e, stackTrace: stack);
      rethrow;
    }
  }

  String _generateSalt(String jwt) {
    final decodedJwt = JwtDecoder.decode(jwt);
    final sub = decodedJwt['sub'] as String;
    final bytes = utf8.encode(sub);
    final hash = sha256.convert(bytes);
    final saltBytes = hash.bytes.sublist(0, _saltBytes);
    final bigInt = saltBytes.fold<BigInt>(
      BigInt.zero,
      (acc, byte) => (acc << 8) | BigInt.from(byte),
    );
    return bigInt.toString();
  }

  String _deriveWalletAddress(String sub, String iss, String aud) {
    final input = '$iss$sub$aud';
    final bytes = utf8.encode(input);
    final hash = sha256.convert(bytes);
    return '0x${hash.toString()}';
  }

  Future<void> signOut() async {
    await _googleSignIn?.signOut();
    _currentWalletAddress = null;
    _currentJwt = null;
    _currentNonce = null;
    _zkProof = null;
    _ephemeralKeypair = null;
  }

  bool get isSignedIn => _currentWalletAddress != null;
  String? get currentWalletAddress => _currentWalletAddress;
  String? get currentJwt => _currentJwt;
  String? get currentNonce => _currentNonce;
  Map<String, dynamic>? get zkProof => _zkProof;
  SuiAccount? get ephemeralKeypair => _ephemeralKeypair;
}

class _NonceBundle {
  const _NonceBundle({
    required this.nonce,
    required this.randomness,
    required this.extendedEphemeralPublicKey,
    required this.maxEpoch,
  });

  final String nonce;
  final String randomness;
  final String extendedEphemeralPublicKey;
  final int maxEpoch;
}
