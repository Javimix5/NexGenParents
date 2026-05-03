import '../l10n/app_localizations.dart';

class AuthValidators {
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static String? validateEmail(String? value, AppLocalizations? l10n) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return l10n?.profileEmailRequired ?? 'Por favor, introduce tu correo';
    }
    if (!_emailRegex.hasMatch(email)) {
      return l10n?.errorInvalidEmail ?? 'Introduce un correo válido';
    }
    return null;
  }

  static String? validateDisplayName(String? value, AppLocalizations? l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return l10n?.profileNameRequired ?? 'Por favor, introduce tu nombre';
    }
    if (name.length < 3) {
      return l10n?.errorNameLength ?? 'El nombre debe tener al menos 3 caracteres';
    }
    return null;
  }

  static String? validatePassword(String? value, AppLocalizations? l10n) {
    final password = value ?? '';
    if (password.isEmpty) {
      return l10n?.profileErrorPasswordRequired ?? 'Por favor, introduce una contraseña';
    }
    if (password.length < 8) {
      return l10n?.errorPasswordLength8 ?? 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return l10n?.errorPasswordUppercase ?? 'Incluye al menos una letra mayúscula';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return l10n?.errorPasswordLowercase ?? 'Incluye al menos una letra minúscula';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return l10n?.errorPasswordNumber ?? 'Incluye al menos un número';
    }
    return null;
  }

  static String? validatePasswordConfirmation(
    String? value,
    String originalPassword,
    AppLocalizations? l10n,
  ) {
    if ((value ?? '').isEmpty) {
      return l10n?.errorConfirmPasswordRequired ?? 'Por favor, confirma tu contraseña';
    }
    if (value != originalPassword) {
      return l10n?.profileErrorPasswordMismatch ?? 'Las contraseñas no coinciden';
    }
    return null;
  }
}
