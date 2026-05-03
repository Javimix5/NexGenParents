import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
// Importar condicionalmente la función para obtener GoogleSignIn
import '_google_sign_in_mobile.dart' if (dart.library.html) '_google_sign_in_stub.dart' as google_sign_in_service;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const int _maxPermissionDeniedRetries = 3;
  static const Duration _permissionDeniedRetryDelay = Duration(milliseconds: 350);

  // Stream para escuchar cambios en el estado de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obtener usuario actual de Firebase Auth
  User? get currentUser => _auth.currentUser;

  UserModel _buildUserModelFromAuth(
    User user, {
    String? displayName,
    DateTime? createdAt,
  }) {
    final now = DateTime.now();

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: displayName ?? user.displayName ?? '',
      role: 'user',
      termsProposed: 0,
      termsApproved: 0,
      createdAt: createdAt ?? now,
      lastLogin: now,
      photoUrl: user.photoURL,
    );
  }

  Future<UserModel?> _ensureUserDocument(
    User user, {
    String? displayName,
  }) async {
    return _runWithFreshTokenRetry(
      user,
      () async {
        final docRef = _firestore.collection('users').doc(user.uid);
        final doc = await docRef.get();

        if (doc.exists) {
          await docRef.update({
            'lastLogin': Timestamp.now(),
            if (displayName != null && displayName.trim().isNotEmpty)
              'displayName': displayName.trim(),
            if (user.email != null) 'email': user.email,
          });

          final refreshedDoc = await docRef.get();
          return UserModel.fromFirestore(refreshedDoc);
        }

        final recoveredUser = _buildUserModelFromAuth(
          user,
          displayName: displayName,
          createdAt: user.metadata.creationTime,
        );

        await docRef.set(recoveredUser.toMap());
        final createdDoc = await docRef.get();
        return UserModel.fromFirestore(createdDoc);
      },
    );
  }

  Future<T> _runWithFreshTokenRetry<T>(
    User user,
    Future<T> Function() operation,
  ) async {
    var attempts = 0;

    while (true) {
      try {
        return await operation();
      } on FirebaseException catch (e) {
        final shouldRetry =
            e.code == 'permission-denied' && attempts < _maxPermissionDeniedRetries;

        if (!shouldRetry) {
      print('Firestore operation failed after retries: ${e.code} - ${e.message}');
          rethrow;
        }

        attempts++;
        await user.getIdToken(true);
        await Future.delayed(_permissionDeniedRetryDelay * attempts);
      }
    }
  }

  // Obtener UserModel completo del usuario actual
  Future<UserModel?> getCurrentUserModel() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      return await _ensureUserDocument(user);
    } catch (e) {
      print('Error al obtener UserModel: $e');
      return null;
    }
  }

  // Registro de nuevo usuario (padres/madres)
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      if (!_isValidEmail(email)) {
        return {
          'success': false,
          'messageKey': 'errorInvalidEmail',
        };
      }

      if (!_isStrongPassword(password)) {
        return {
          'success': false,
          'messageKey': 'errorWeakPassword',
        };
      }

      // Crear usuario en Firebase Auth
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorCreatingUser',
        };
      }

      // Actualizar displayName en Firebase Auth
      await user.updateDisplayName(displayName);

      final UserModel? newUser = await _ensureUserDocument(
        user,
        displayName: displayName,
      );

      if (newUser == null) {
        return {
          'success': false,
          'messageKey': 'errorCreatingProfile',
        };
      }

      return {
        'success': true,
        'messageKey': 'successUserRegistered',
        'user': newUser,
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        try {
          final existingCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          final existingUser = existingCredential.user;
          if (existingUser != null) {
            if ((existingUser.displayName ?? '').isEmpty &&
                displayName.trim().isNotEmpty) {
              await existingUser.updateDisplayName(displayName.trim());
            }

            final recoveredUser = await _ensureUserDocument(
              existingUser,
              displayName: displayName,
            );

            if (recoveredUser != null) {
              return {
                'success': true,
                'messageKey': 'successUserRegistered', // Or a more specific one
                'user': recoveredUser,
              };
            }
          }
        } on FirebaseAuthException catch (recoveryError) {
          if (recoveryError.code == 'wrong-password' ||
              recoveryError.code == 'invalid-credential') {
            return {
              'success': false,
              'messageKey': 'errorEmailInUseRecovery',
            };
          }
        } catch (_) {}
      }

      String messageKey = 'errorGeneric';

      switch (e.code) {
        case 'email-already-in-use':
          messageKey = 'errorEmailInUse';
          break;
        case 'weak-password':
          messageKey = 'errorWeakPassword';
          break;
        case 'invalid-email':
          messageKey = 'errorInvalidEmail';
          break;
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return {
          'success': false,
          'messageKey': 'errorPermissionDenied',
        };
      }

      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.message ?? e.code,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

  // Login de usuario existente
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (!_isValidEmail(email)) {
        return {
          'success': false,
          'messageKey': 'errorInvalidEmail',
        };
      }

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorLogin',
        };
      }

      final UserModel? userModel = await _ensureUserDocument(user);
      if (userModel == null) {
        return {
          'success': false,
          'messageKey': 'errorLoadingProfile',
        };
      }

      return {
        'success': true,
        'messageKey': 'successLogin',
        'user': userModel,
      };
    } on FirebaseAuthException catch (e) {
      String messageKey = 'errorLogin';

      switch (e.code) {
        case 'user-not-found':
          messageKey = 'errorUserNotFound';
          break;
        case 'invalid-email':
          messageKey = 'errorInvalidEmail';
          break;
        case 'user-disabled':
          messageKey = 'errorUserDisabled';
          break;
        case 'wrong-password':
        case 'invalid-credential':
          messageKey = 'errorWrongPassword';
          break;
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return {
          'success': false,
          'messageKey': 'errorPermissionDenied',
        };
      }

      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.message ?? e.code,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider()
          ..addScope('email')
          ..addScope('profile');

        try {
          userCredential = await _auth.signInWithPopup(googleProvider);
        } on FirebaseAuthException catch (e) {
          // Fallback para navegadores que bloquean popups o cancelan el contexto.
          if (e.code == 'popup-blocked' ||
              e.code == 'cancelled-popup-request' ||
              e.code == 'web-context-cancelled') {
            await _auth.signInWithRedirect(googleProvider);
            // No se puede devolver un resultado aquí, la app se recargará.
            // Por simplicidad, devolvemos un estado de "redirigiendo".
            return {'success': true, 'redirecting': true};
          }
          rethrow;
        }
      } else {
        final googleUser = google_sign_in_service.getGoogleSignIn();
        if (googleUser == null) {
          return {
            'success': false,
            'messageKey': 'errorGeneric',
            'errorDetails': 'Google Sign-In not available',
          };
        }

        final dynamic googleUserAccount = await googleUser.signIn();
        if (googleUserAccount == null) {
          // El usuario canceló, no es un error, simplemente no hacemos nada.
          return {'success': false, 'cancelled': true};
        }

        final dynamic googleAuth =
            await googleUserAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken ?? googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      final user = userCredential.user;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorGeneric',
          'errorDetails': 'Google UserCredential was null',
        };
      }

      final UserModel? userModel = await _ensureUserDocument(
        user,
        displayName: user.displayName,
      );

      if (userModel == null) {
        return {
          'success': false,
          'messageKey': 'errorLoadingProfile',
        };
      }

      return {
        'success': true,
        'messageKey': 'successLoginGoogle',
        'user': userModel,
      };
    } on FirebaseAuthException catch (e) {
      var messageKey = 'errorLogin';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          messageKey = 'errorDifferentCredential';
          break;
        case 'invalid-credential':
          messageKey = 'errorInvalidCredential';
          break;
        case 'popup-closed-by-user':
          messageKey = 'errorPopupClosed';
          break;
        case 'popup-blocked':
          messageKey = 'errorPopupBlocked';
          break;
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return {
          'success': false,
          'messageKey': 'errorPermissionDenied',
        };
      }

      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.message ?? e.code,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      final googleSignIn = google_sign_in_service.getGoogleSignIn();
      if (googleSignIn != null) {
        await googleSignIn.signOut();
      }
      await _auth.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
      rethrow;
    }
  }

  // Recuperar contraseña
  Future<Map<String, dynamic>> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {
        'success': true,
        'messageKey': 'successPasswordReset',
      };
    } on FirebaseAuthException catch (e) {
      String messageKey = 'errorGeneric';

      if (e.code == 'user-not-found') {
        messageKey = 'errorUserNotFound';
      } else if (e.code == 'invalid-email') {
        messageKey = 'errorInvalidEmail';
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

  // Verificar si el usuario está autenticado
  bool isAuthenticated() {
    return currentUser != null;
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
        .hasMatch(value.trim());
  }

  bool _isStrongPassword(String value) {
    if (value.length < 8) return false;
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);

    return hasUpperCase && hasLowerCase && hasNumber;
  }

  // Cambiar contraseña
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = currentUser;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorNoAuthUser',
        };
      }

      // Reautenticar usuario
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Cambiar contraseña
      await user.updatePassword(newPassword);

      return {
        'success': true,
        'messageKey': 'successPasswordUpdated',
      };
    } on FirebaseAuthException catch (e) {
      String messageKey = 'errorChangePassword';

      switch (e.code) {
        case 'wrong-password':
          messageKey = 'errorWrongCurrentPassword';
          break;
        case 'weak-password':
          messageKey = 'errorWeakNewPassword';
          break;
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

// Cambiar email
  Future<Map<String, dynamic>> changeEmail({
    required String currentPassword,
    required String newEmail,
  }) async {
    try {
      final user = currentUser;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorNoAuthUser',
        };
      }

      // Reautenticar usuario
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Cambiar email
      await user.verifyBeforeUpdateEmail(newEmail);

      return {
        'success': true,
        'messageKey': 'successEmailUpdated',
      };
    } on FirebaseAuthException catch (e) {
      String messageKey = 'errorChangeEmail';

      switch (e.code) {
        case 'email-already-in-use':
          messageKey = 'errorEmailAlreadyInUse';
          break;
        case 'invalid-email':
          messageKey = 'errorInvalidNewEmail';
          break;
        case 'wrong-password':
          messageKey = 'errorWrongCurrentPassword';
          break;
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> reauthenticateForSensitiveAction(
    String password,
  ) async {
    try {
      final user = currentUser;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorNoAuthUser',
        };
      }

      if (user.email == null || user.email!.trim().isEmpty) {
        return {
          'success': false,
          'messageKey': 'errorNoPasswordAccount',
        };
      }

      // Reautenticar antes de eliminar
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      return {
        'success': true,
        'messageKey': 'successReauth',
      };
    } on FirebaseAuthException catch (e) {
      String messageKey = 'errorReauth';

      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        messageKey = 'errorWrongCurrentPassword';
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> deleteCurrentAuthUser() async {
    try {
      final user = currentUser;
      if (user == null) {
        return {
          'success': false,
          'messageKey': 'errorNoAuthUser',
        };
      }

      // Eliminar cuenta de Firebase Auth
      await user.delete();

      return {
        'success': true,
        'messageKey': 'successAccountDeleted',
      };
    } on FirebaseAuthException catch (e) {
      String messageKey = 'errorDeleteAccount';

      if (e.code == 'wrong-password') {
        messageKey = 'errorWrongCurrentPassword';
      }

      return {
        'success': false,
        'messageKey': messageKey,
      };
    } catch (e) {
      return {
        'success': false,
        'messageKey': 'errorGeneric',
        'errorDetails': e.toString(),
      };
    }
  }

// Eliminar cuenta (atajo con reautenticación + borrado Auth)
  Future<Map<String, dynamic>> deleteAccount(String password) async {
    final reauthResult = await reauthenticateForSensitiveAction(password);
    if (!(reauthResult['success'] ?? false)) {
      return reauthResult;
    }

    return deleteCurrentAuthUser();
  }
}
