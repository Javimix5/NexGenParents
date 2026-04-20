import 'package:google_sign_in/google_sign_in.dart';

class _GoogleSignInCompat {
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  Future<_GoogleUserAccountCompat?> signIn() async {
    await _ensureInitialized();

    try {
      final account = await GoogleSignIn.instance.authenticate(
        scopeHint: const ['email', 'profile'],
      );
      return _GoogleUserAccountCompat(account);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted ||
          e.code == GoogleSignInExceptionCode.uiUnavailable) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (!_initialized) return;
    await GoogleSignIn.instance.signOut();
  }
}

class _GoogleUserAccountCompat {
  _GoogleUserAccountCompat(this._account);

  final GoogleSignInAccount _account;

  Future<_GoogleAuthCompat> get authentication async {
    return _GoogleAuthCompat(_account.authentication.idToken);
  }
}

class _GoogleAuthCompat {
  _GoogleAuthCompat(this.idToken);

  final String? idToken;

  // Firebase Auth puede crear credencial usando solo idToken en este flujo.
  String? get accessToken => null;
}

dynamic getGoogleSignIn() => _GoogleSignInCompat();
