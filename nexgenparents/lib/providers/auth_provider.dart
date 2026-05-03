import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Constructor: escucha cambios en el estado de autenticación
  AuthProvider() {
    _authService.authStateChanges.listen((User? firebaseUser) {
      if (firebaseUser != null) {
        _loadUserData();
      } else {
        _currentUser = null;
        notifyListeners();
      }
    });
  }

  // Cargar datos completos del usuario actual
  Future<void> _loadUserData() async {
    try {
      _currentUser = await _authService.getCurrentUserModel();
      notifyListeners();
    } catch (e) {
      print('Error al cargar datos del usuario: $e');
    }
  }

  // Registrar nuevo usuario
  Future<bool> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );

      if (result['success']) {
        _currentUser = result['user'];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['messageKey'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Iniciar sesión
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.signIn(
        email: email,
        password: password,
      );

      if (result['success']) {
        _currentUser = result['user'];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['messageKey'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error inesperado: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.signInWithGoogle();

      if (result['success']) {
        if (result['user'] != null) {
          _currentUser = result['user'];
        }
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['messageKey'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error inesperado: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _currentUser = null;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // Recuperar contraseña
  Future<bool> resetPassword({required String email}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.resetPassword(email: email);

      _isLoading = false;
      if (result['success']) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['messageKey'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Verificar si el usuario actual es moderador
  bool get isModerator {
    return _currentUser?.isModerator ?? false;
  }

  // Verificar si el usuario actual es admin
  bool get isAdmin {
    return _currentUser?.isAdmin ?? false;
  }
}
