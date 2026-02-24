import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream para escuchar cambios en el estado de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obtener usuario actual de Firebase Auth
  User? get currentUser => _auth.currentUser;

  // Obtener UserModel completo del usuario actual
  Future<UserModel?> getCurrentUserModel() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return null;

      return UserModel.fromFirestore(doc);
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
      // Crear usuario en Firebase Auth
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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

      // Crear documento del usuario en Firestore
      final UserModel newUser = UserModel(
        id: user.uid,
        email: email,
        displayName: displayName,
        role: 'user', // Por defecto todos son usuarios normales
        termsProposed: 0,
        termsApproved: 0,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

      // Actualizar displayName en Firebase Auth
      await user.updateDisplayName(displayName);

      return {
        'success': true,
        'message': 'Usuario registrado correctamente',
        'user': newUser,
      };
    } on FirebaseAuthException catch (e) {
      String message = 'Error al registrar usuario';
      
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Este correo ya está registrado';
          break;
        case 'weak-password':
          message = 'La contraseña es demasiado débil (mínimo 6 caracteres)';
          break;
        case 'invalid-email':
          message = 'El correo electrónico no es válido';
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

  // Login de usuario existente
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
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

      // Actualizar última fecha de login
      await _firestore.collection('users').doc(user.uid).update({
        'lastLogin': Timestamp.now(),
      });

      // Obtener datos completos del usuario
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final UserModel userModel = UserModel.fromFirestore(userDoc);

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
        'message': 'Correo de recuperación enviado. Revisa tu bandeja de entrada',
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

// Eliminar cuenta (autenticación)
Future<Map<String, dynamic>> deleteAccount(String password) async {
  try {
    final user = currentUser;
    if (user == null) {
      return {
        'success': false,
        'message': 'No hay usuario autenticado',
      };
    }

    // Reautenticar antes de eliminar
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    
    await user.reauthenticateWithCredential(credential);
    
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
}