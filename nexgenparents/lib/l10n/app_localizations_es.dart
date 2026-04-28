// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'NexGen Parents';

  @override
  String loading(String appName) {
    return 'Cargando $appName...';
  }

  @override
  String get classificationSystemsTitle => 'Sistemas de Clasificación';

  @override
  String get pegiInfoSubtitle =>
      'Aprende a interpretar PEGI y ESRB para elegir juegos adecuados para cada edad.';

  @override
  String get ageRatingsMeaningTitle =>
      '¿Qué significan las clasificaciones por edad?';

  @override
  String get pegiSystemEuropa => 'Sistema PEGI (Europa)';

  @override
  String get esrbSystemUsa => 'Sistema ESRB (EE. UU.)';

  @override
  String get esrbApiNote =>
      'Este es el sistema que suele aparecer en la API de videojuegos que utilizamos.';

  @override
  String get pegiContentDescriptorsTitle => 'Descriptores de Contenido PEGI';

  @override
  String get pegiContentDescriptorsSubtitle =>
      'Además de la edad, las clasificaciones incluyen iconos que indican el tipo de contenido:';

  @override
  String get contentDescriptorViolence => 'Violencia';

  @override
  String get contentDescriptorFear => 'Miedo';

  @override
  String get contentDescriptorOnline => 'Online';

  @override
  String get contentDescriptorDiscrimination => 'Discriminación';

  @override
  String get contentDescriptorDrugs => 'Drogas';

  @override
  String get contentDescriptorSex => 'Sexo';

  @override
  String get contentDescriptorBadLanguage => 'Lenguaje soez';

  @override
  String get contentDescriptorGambling => 'Juego/Apuestas';

  @override
  String get errorInvalidEmail => 'El correo electrónico no es válido';

  @override
  String get errorWeakPassword =>
      'La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número';

  @override
  String get errorUserNotFound => 'No existe un usuario con este correo';

  @override
  String get errorWrongPassword => 'La contraseña es incorrecta';

  @override
  String get errorUserDisabled => 'Esta cuenta ha sido deshabilitada';

  @override
  String get errorEmailInUse => 'Este correo ya está registrado';

  @override
  String get errorEmailInUseRecovery =>
      'Este correo ya está registrado. Si borraste solo el perfil en la base de datos, inicia sesión con tu contraseña anterior para restaurarlo.';

  @override
  String get errorDifferentCredential =>
      'Este correo ya está registrado con otro método de acceso';

  @override
  String get errorInvalidCredential => 'Las credenciales no son válidas';

  @override
  String get errorPopupClosed =>
      'Has cerrado la ventana de Google antes de completar el acceso';

  @override
  String get errorPopupBlocked =>
      'El navegador bloqueó la ventana emergente de Google. Inténtalo de nuevo';

  @override
  String get errorPermissionDenied =>
      'No hay permisos para acceder al perfil en Firestore. Revisa y despliega firestore.rules.';

  @override
  String errorGeneric(String error) {
    return 'Error inesperado: $error';
  }

  @override
  String get errorCreatingUser => 'Error al crear el usuario';

  @override
  String get errorCreatingProfile => 'No se pudo crear el perfil del usuario';

  @override
  String get errorLogin => 'Error al iniciar sesión';

  @override
  String get errorLoadingProfile => 'No se pudo cargar el perfil del usuario';

  @override
  String get successUserRegistered => 'Usuario registrado correctamente';

  @override
  String get successLogin => 'Sesión iniciada correctamente';

  @override
  String get successLoginGoogle => 'Sesión iniciada correctamente con Google';

  @override
  String get successPasswordReset =>
      'Correo de recuperación enviado. Revisa tu bandeja de entrada';

  @override
  String get profileTooltip => 'Perfil de usuario';

  @override
  String get navBarHome => 'Inicio';

  @override
  String get navBarSearch => 'Buscar';

  @override
  String get navBarGuides => 'Guías';
}
