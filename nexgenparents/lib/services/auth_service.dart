import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GoogleSignIn? _googleSignIn;

  static const int _maxPermissionDeniedRetries = 3;
  static const Duration _permissionDeniedRetryDelay = Duration(milliseconds: 350);

  GoogleSignIn get _googleSignInMobile {
    return _googleSignIn ??= GoogleSignIn();
  }

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
      debugPrint('Firestore operation failed after retries: ${e.code} - ${e.message}');
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
          'message': 'El correo electrónico no es válido',
        };
      }

      if (!_isStrongPassword(password)) {
        return {
          'success': false,
          'message':
              'La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número',
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
          'message': 'Error al crear el usuario',
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
          'message': 'No se pudo crear el perfil del usuario',
        };
      }

      return {
        'success': true,
        'message': 'Usuario registrado correctamente',
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
                'message':
                    'La cuenta ya existía en autenticación y se ha restaurado el perfil.',
                'user': recoveredUser,
              };
            }
          }
        } on FirebaseAuthException catch (recoveryError) {
          if (recoveryError.code == 'wrong-password' ||
              recoveryError.code == 'invalid-credential') {
            return {
              'success': false,
              'message':
                  'Este correo ya está registrado. Si borraste solo el perfil en la base de datos, inicia sesión con tu contraseña anterior para restaurarlo.',
            };
          }
        } catch (_) {}
      }

      String message = 'Error al registrar usuario';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Este correo ya está registrado';
          break;
        case 'weak-password':
          message =
              'La contraseña es demasiado débil (mínimo 8 caracteres, con mayúscula, minúscula y número)';
          break;
        case 'invalid-email':
          message = 'El correo electrónico no es válido';
          break;
      }

      return {
        'success': false,
        'message': message,
      };
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return {
          'success': false,
          'message':
              'No hay permisos para acceder al perfil en Firestore. Revisa y despliega firestore.rules.',
        };
      }

      return {
        'success': false,
        'message': 'Error de Firestore: ${e.message ?? e.code}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
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
          'message': 'El correo electrónico no es válido',
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
          'message': 'Error al iniciar sesión',
        };
      }

      final UserModel? userModel = await _ensureUserDocument(user);
      if (userModel == null) {
        return {
          'success': false,
          'message': 'No se pudo cargar el perfil del usuario',
        };
      }

      return {
        'success': true,
        'message': 'Sesión iniciada correctamente',
        'user': userModel,
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error al iniciar sesión';

      switch (e.code) {
        case 'user-not-found':
          message = 'No existe un usuario con este correo';
          break;
        case 'wrong-password':
          message = 'Contraseña incorrecta';
          break;
        case 'invalid-email':
          message = 'El correo electrónico no es válido';
          break;
        case 'user-disabled':
          message = 'Esta cuenta ha sido deshabilitada';
          break;
      }

      return {
        'success': false,
        'message': message,
      };
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return {
          'success': false,
          'message':
              'No hay permisos para acceder al perfil en Firestore. Revisa y despliega firestore.rules.',
        };
      }

      return {
        'success': false,
        'message': 'Error de Firestore: ${e.message ?? e.code}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser =
            await _googleSignInMobile.signIn();

        if (googleUser == null) {
          return {
            'success': false,
            'message': 'Inicio de sesión cancelado por el usuario',
          };
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      final user = userCredential.user;
      if (user == null) {
        return {
          'success': false,
          'message': 'No se pudo autenticar la cuenta de Google',
        };
      }

      final UserModel? userModel = await _ensureUserDocument(
        user,
        displayName: user.displayName,
      );

      if (userModel == null) {
        return {
          'success': false,
          'message': 'No se pudo cargar el perfil del usuario',
        };
      }

      return {
        'success': true,
        'message': 'Sesión iniciada correctamente con Google',
        'user': userModel,
      };
    } on FirebaseAuthException catch (e) {
      var message = 'Error al iniciar sesión con Google';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          message = 'Este correo ya está registrado con otro método de acceso';
          break;
        case 'invalid-credential':
          message = 'Las credenciales de Google no son válidas';
          break;
        case 'popup-closed-by-user':
          message =
              'Has cerrado la ventana de Google antes de completar el acceso';
          break;
      }

      return {
        'success': false,
        'message': message,
      };
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return {
          'success': false,
          'message':
              'No hay permisos para acceder al perfil en Firestore. Revisa y despliega firestore.rules.',
        };
      }

      return {
        'success': false,
        'message': 'Error de Firestore: ${e.message ?? e.code}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
      };
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      if (!kIsWeb) {
        await _googleSignIn?.signOut();
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
        'message':
            'Correo de recuperación enviado. Revisa tu bandeja de entrada',
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error al enviar correo de recuperación';

      if (e.code == 'user-not-found') {
        message = 'No existe un usuario con este correo';
      } else if (e.code == 'invalid-email') {
        message = 'El correo electrónico no es válido';
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
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
          'message': 'No hay usuario autenticado',
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
        'message': 'Contraseña actualizada correctamente',
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error al cambiar contraseña';

      switch (e.code) {
        case 'wrong-password':
          message = 'La contraseña actual es incorrecta';
          break;
        case 'weak-password':
          message = 'La nueva contraseña es demasiado débil';
          break;
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
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
          'message': 'No hay usuario autenticado',
        };
      }

      // Reautenticar usuario
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Cambiar email
      await user.updateEmail(newEmail);

      return {
        'success': true,
        'message': 'Email actualizado correctamente. Verifica tu nuevo correo.',
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error al cambiar email';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Este email ya está en uso';
          break;
        case 'invalid-email':
          message = 'El email no es válido';
          break;
        case 'wrong-password':
          message = 'La contraseña es incorrecta';
          break;
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
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
          'message': 'No hay usuario autenticado',
        };
      }

      if (user.email == null || user.email!.trim().isEmpty) {
        return {
          'success': false,
          'message':
              'Tu cuenta no usa contraseña. Inicia sesión de nuevo con tu proveedor para continuar.',
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
        'message': 'Reautenticación correcta',
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error de reautenticación';

      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'La contraseña es incorrecta';
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> deleteCurrentAuthUser() async {
    try {
      final user = currentUser;
      if (user == null) {
        return {
          'success': false,
          'message': 'No hay usuario autenticado',
        };
      }

      // Eliminar cuenta de Firebase Auth
      await user.delete();

      return {
        'success': true,
        'message': 'Cuenta eliminada correctamente',
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error al eliminar cuenta';

      if (e.code == 'wrong-password') {
        message = 'La contraseña es incorrecta';
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
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
