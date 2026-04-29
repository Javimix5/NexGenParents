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
  String get guideTypeEnable => 'Habilitar guía';

  @override
  String get guideTypeDisable => 'Deshabilitar guía';

  @override
  String get guideTypeApp => 'Guía de aplicaciones';

  @override
  String get guideTypeTime => 'Guía de tiempo';

  @override
  String get guideTypeDefault => 'Guía por defecto';

  @override
  String get psEnableGuideTitle => 'Cómo habilitar la guía parental';

  @override
  String get psEnableGuideDescription =>
      'Sigue estos pasos para habilitar la guía parental en tu dispositivo.';

  @override
  String get psEnableGuideStep1 => 'Abre la aplicación de configuración.';

  @override
  String get psEnableGuideStep2 => 'Selecciona \'Controles parentales\'.';

  @override
  String get psEnableGuideStep3 => 'Activa la opción de guía parental.';

  @override
  String get psEnableGuideStep4 =>
      'Configura las restricciones según tus necesidades.';

  @override
  String get psEnableGuideStep5 => 'Guarda los cambios.';

  @override
  String get psEnableGuideStep6 => 'Verifica que la guía esté activa.';

  @override
  String get psDisableGuideTitle => 'Cómo deshabilitar la guía parental';

  @override
  String get psDisableGuideDescription =>
      'Sigue estos pasos para deshabilitar la guía parental en tu dispositivo.';

  @override
  String get psDisableGuideStep1 => 'Abre la aplicación de configuración.';

  @override
  String get psDisableGuideStep2 => 'Selecciona \'Controles parentales\'.';

  @override
  String get psDisableGuideStep3 => 'Desactiva la opción de guía parental.';

  @override
  String get psDisableGuideStep4 => 'Guarda los cambios.';

  @override
  String get psDisableGuideStep5 => 'Verifica que la guía esté desactivada.';

  @override
  String get nintendoAppGuideStep2 => 'Paso 2: Abre la aplicación de Nintendo.';

  @override
  String get nintendoAppGuideStep3 =>
      'Paso 3: Ve a la sección de controles parentales.';

  @override
  String get nintendoAppGuideStep4 =>
      'Paso 4: Configura las restricciones según sea necesario.';

  @override
  String get nintendoAppGuideStep5 => 'Paso 5: Guarda la configuración.';

  @override
  String get nintendoAppGuideStep6 => 'Paso 6: Vincula tu cuenta.';

  @override
  String get nintendoAppGuideStep7 => 'Paso 7: Confirma la configuración.';

  @override
  String get nintendoAppGuideStep8 =>
      'Paso 8: Prueba los controles parentales.';

  @override
  String get steamGuideTitle => 'Guía parental de Steam';

  @override
  String get steamGuideDescription =>
      'Aprende a configurar los controles parentales en Steam.';

  @override
  String get steamGuideStep1 => 'Paso 1: Abre la configuración de Steam.';

  @override
  String get steamGuideStep2 => 'Paso 2: Ve a la sección Familia.';

  @override
  String get steamGuideStep3 => 'Paso 3: Habilita la Vista Familiar.';

  @override
  String get steamGuideStep4 => 'Paso 4: Configura un PIN.';

  @override
  String get steamGuideStep5 =>
      'Paso 5: Restringe el contenido según sea necesario.';

  @override
  String get iosGuideTitle => 'Guía parental de iOS';

  @override
  String get iosGuideDescription =>
      'Aprende a configurar los controles parentales en dispositivos iOS.';

  @override
  String get iosGuideStep1 => 'Paso 1: Abre Configuración.';

  @override
  String get iosGuideStep2 => 'Paso 2: Ve a Tiempo en Pantalla.';

  @override
  String get iosGuideStep3 => 'Paso 3: Habilita las restricciones.';

  @override
  String get iosGuideStep4 => 'Paso 4: Configura un código de acceso.';

  @override
  String get xboxGuideTitle => 'Guía parental de Xbox';

  @override
  String get xboxGuideDescription =>
      'Aprende a configurar los controles parentales en Xbox.';

  @override
  String get xboxGuideStep1 => 'Paso 1: Abre la configuración de Xbox.';

  @override
  String get xboxGuideStep2 => 'Paso 2: Ve a la sección Familia.';

  @override
  String get xboxGuideStep3 => 'Paso 3: Habilita los controles parentales.';

  @override
  String get xboxGuideStep4 => 'Paso 4: Configura las restricciones.';

  @override
  String get xboxGuideStep5 => 'Paso 5: Guarda la configuración.';

  @override
  String get xboxTimeGuideTitle => 'Guía de tiempo de Xbox';

  @override
  String get xboxTimeGuideDescription =>
      'Aprende a configurar límites de tiempo en Xbox.';

  @override
  String get xboxTimeGuideStep1 => 'Paso 1: Abre la configuración de Xbox.';

  @override
  String get xboxTimeGuideStep2 => 'Paso 2: Ve a la sección Familia.';

  @override
  String get xboxTimeGuideStep3 => 'Paso 3: Habilita los límites de tiempo.';

  @override
  String get xboxTimeGuideStep4 => 'Paso 4: Configura los horarios.';

  @override
  String get xboxTimeGuideStep5 => 'Paso 5: Guarda la configuración.';

  @override
  String get nintendoGuideTitle => 'Guía parental de Nintendo';

  @override
  String get nintendoGuideDescription =>
      'Aprende a configurar los controles parentales en Nintendo.';

  @override
  String get nintendoGuideStep1 => 'Paso 1: Abre la configuración de Nintendo.';

  @override
  String get nintendoGuideStep2 =>
      'Paso 2: Ve a la sección de controles parentales.';

  @override
  String get nintendoGuideStep3 => 'Paso 3: Configura las restricciones.';

  @override
  String get nintendoGuideStep4 => 'Paso 4: Guarda la configuración.';

  @override
  String get nintendoGuideStep5 => 'Paso 5: Prueba los controles parentales.';
}
