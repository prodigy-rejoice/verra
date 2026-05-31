class VerraException implements Exception {
  const VerraException(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() => 'VerraException($code): $message';
}

class SuiException extends VerraException {
  const SuiException(super.message, {super.code, super.cause});
}

class AuthException extends VerraException {
  const AuthException(super.message, {super.code, super.cause});
}

class MatchmakingException extends VerraException {
  const MatchmakingException(super.message, {super.code, super.cause});
}

class NetworkException extends VerraException {
  const NetworkException(super.message, {super.code, super.cause});
}
