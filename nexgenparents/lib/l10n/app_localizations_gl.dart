// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class AppLocalizationsGl extends AppLocalizations {
  AppLocalizationsGl([String locale = 'gl']) : super(locale);

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
      'Aprende a interpretar PEGI e ESRB para elixir xogos axeitados para cada idade.';

  @override
  String get ageRatingsMeaningTitle =>
      'Que significan as clasificacións por idade?';

  @override
  String get pegiSystemEuropa => 'Sistema PEGI (Europa)';

  @override
  String get esrbSystemUsa => 'Sistema ESRB (EE. UU.)';

  @override
  String get esrbApiNote =>
      'Este é o sistema que adoita aparecer na API de videoxogos que utilizamos.';

  @override
  String get pegiContentDescriptorsTitle => 'Descritores de Contido PEGI';

  @override
  String get pegiContentDescriptorsSubtitle =>
      'Ademais da idade, as clasificacións inclúen iconas que indican o tipo de contido:';

  @override
  String get contentDescriptorViolence => 'Violencia';

  @override
  String get contentDescriptorFear => 'Medo';

  @override
  String get contentDescriptorOnline => 'En liña';

  @override
  String get contentDescriptorDiscrimination => 'Discriminación';

  @override
  String get contentDescriptorDrugs => 'Drogas';

  @override
  String get contentDescriptorSex => 'Sexo';

  @override
  String get contentDescriptorBadLanguage => 'Linguaxe soez';

  @override
  String get contentDescriptorGambling => 'Xogo/Apostas';

  @override
  String get errorInvalidEmail => 'O correo electrónico non é válido';

  @override
  String get errorWeakPassword =>
      'O contrasinal debe ter polo menos 8 caracteres, unha maiúscula, unha minúscula e un número';

  @override
  String get errorUserNotFound => 'Non existe un usuario con este correo';

  @override
  String get errorWrongPassword => 'O contrasinal é incorrecto';

  @override
  String get errorUserDisabled => 'Esta conta foi deshabilitada';

  @override
  String get errorEmailInUse => 'Este correo xa está rexistrado';

  @override
  String get errorEmailInUseRecovery =>
      'Este correo xa está rexistrado. Se borraches só o perfil na base de datos, inicia sesión co teu contrasinal anterior para restauralo.';

  @override
  String get errorDifferentCredential =>
      'Este correo xa está rexistrado con outro método de acceso';

  @override
  String get errorInvalidCredential => 'As credenciais non son válidas';

  @override
  String get errorPopupClosed =>
      'Pechaches a xanela de Google antes de completar o acceso';

  @override
  String get errorPopupBlocked =>
      'O navegador bloqueou a xanela emerxente de Google. Téntao de novo';

  @override
  String get errorPermissionDenied =>
      'Non hai permisos para acceder ao perfil en Firestore. Revisa e desprega firestore.rules.';

  @override
  String errorGeneric(String error) {
    return 'Erro inesperado: $error';
  }

  @override
  String get errorCreatingUser => 'Erro ao crear o usuario';

  @override
  String get errorCreatingProfile => 'Non se puido crear o perfil do usuario';

  @override
  String get errorLogin => 'Erro ao iniciar sesión';

  @override
  String get errorLoadingProfile => 'Non se puido cargar o perfil do usuario';

  @override
  String get successUserRegistered => 'Usuario rexistrado correctamente';

  @override
  String get successLogin => 'Sesión iniciada correctamente';

  @override
  String get successLoginGoogle => 'Sesión iniciada correctamente con Google';

  @override
  String get successPasswordReset =>
      'Correo de recuperación enviado. Revisa a túa bandexa de entrada';

  @override
  String get guideTypeEnable => 'Habilitar guía';

  @override
  String get guideTypeDisable => 'Deshabilitar guía';

  @override
  String get guideTypeApp => 'Guía de aplicacións';

  @override
  String get guideTypeTime => 'Guía de tempo';

  @override
  String get guideTypeDefault => 'Guía por defecto';

  @override
  String get psEnableGuideTitle => 'Como habilitar a guía parental';

  @override
  String get psEnableGuideDescription =>
      'Sigue estes pasos para habilitar a guía parental no teu dispositivo.';

  @override
  String get psEnableGuideStep1 => 'Abre a aplicación de configuración.';

  @override
  String get psEnableGuideStep2 => 'Selecciona \'Controis parentais\'.';

  @override
  String get psEnableGuideStep3 => 'Activa a opción de guía parental.';

  @override
  String get psEnableGuideStep4 =>
      'Configura as restricións segundo as túas necesidades.';

  @override
  String get psEnableGuideStep5 => 'Garda os cambios.';

  @override
  String get psEnableGuideStep6 => 'Verifica que a guía estea activa.';

  @override
  String get psDisableGuideTitle => 'Como deshabilitar a guía parental';

  @override
  String get psDisableGuideDescription =>
      'Sigue estes pasos para deshabilitar a guía parental no teu dispositivo.';

  @override
  String get psDisableGuideStep1 => 'Abre a aplicación de configuración.';

  @override
  String get psDisableGuideStep2 => 'Selecciona \'Controis parentais\'.';

  @override
  String get psDisableGuideStep3 => 'Desactiva a opción de guía parental.';

  @override
  String get psDisableGuideStep4 => 'Garda os cambios.';

  @override
  String get psDisableGuideStep5 => 'Verifica que a guía estea desactivada.';

  @override
  String get nintendoAppGuideStep2 => 'Paso 2: Abre a aplicación de Nintendo.';

  @override
  String get nintendoAppGuideStep3 =>
      'Paso 3: Vai á sección de controis parentais.';

  @override
  String get nintendoAppGuideStep4 =>
      'Paso 4: Configura as restricións segundo sexa necesario.';

  @override
  String get nintendoAppGuideStep5 => 'Paso 5: Garda a configuración.';

  @override
  String get nintendoAppGuideStep6 => 'Paso 6: Vincula a túa conta.';

  @override
  String get nintendoAppGuideStep7 => 'Paso 7: Confirma a configuración.';

  @override
  String get nintendoAppGuideStep8 => 'Paso 8: Proba os controis parentais.';

  @override
  String get steamGuideTitle => 'Guía parental de Steam';

  @override
  String get steamGuideDescription =>
      'Aprende a configurar os controis parentais en Steam.';

  @override
  String get steamGuideStep1 => 'Paso 1: Abre a configuración de Steam.';

  @override
  String get steamGuideStep2 => 'Paso 2: Vai á sección Familia.';

  @override
  String get steamGuideStep3 => 'Paso 3: Habilita a Vista Familiar.';

  @override
  String get steamGuideStep4 => 'Paso 4: Configura un PIN.';

  @override
  String get steamGuideStep5 =>
      'Paso 5: Restringe o contido segundo sexa necesario.';

  @override
  String get iosGuideTitle => 'Guía parental de iOS';

  @override
  String get iosGuideDescription =>
      'Aprende a configurar os controis parentais en dispositivos iOS.';

  @override
  String get iosGuideStep1 => 'Paso 1: Abre Configuración.';

  @override
  String get iosGuideStep2 => 'Paso 2: Vai a Tempo de Pantalla.';

  @override
  String get iosGuideStep3 => 'Paso 3: Habilita as restricións.';

  @override
  String get iosGuideStep4 => 'Paso 4: Configura un código de acceso.';

  @override
  String get xboxGuideTitle => 'Guía parental de Xbox';

  @override
  String get xboxGuideDescription =>
      'Aprende a configurar os controis parentais en Xbox.';

  @override
  String get xboxGuideStep1 => 'Paso 1: Abre a configuración de Xbox.';

  @override
  String get xboxGuideStep2 => 'Paso 2: Vai á sección Familia.';

  @override
  String get xboxGuideStep3 => 'Paso 3: Habilita os controis parentais.';

  @override
  String get xboxGuideStep4 => 'Paso 4: Configura as restricións.';

  @override
  String get xboxGuideStep5 => 'Paso 5: Garda a configuración.';

  @override
  String get xboxTimeGuideTitle => 'Guía de tempo de Xbox';

  @override
  String get xboxTimeGuideDescription =>
      'Aprende a configurar límites de tempo en Xbox.';

  @override
  String get xboxTimeGuideStep1 => 'Paso 1: Abre a configuración de Xbox.';

  @override
  String get xboxTimeGuideStep2 => 'Paso 2: Vai á sección Familia.';

  @override
  String get xboxTimeGuideStep3 => 'Paso 3: Habilita os límites de tempo.';

  @override
  String get xboxTimeGuideStep4 => 'Paso 4: Configura os horarios.';

  @override
  String get xboxTimeGuideStep5 => 'Paso 5: Garda a configuración.';

  @override
  String get nintendoGuideTitle => 'Guía parental de Nintendo';

  @override
  String get nintendoGuideDescription =>
      'Aprende a configurar os controis parentais en Nintendo.';

  @override
  String get nintendoGuideStep1 => 'Paso 1: Abre a configuración de Nintendo.';

  @override
  String get nintendoGuideStep2 =>
      'Paso 2: Vai á sección de controis parentais.';

  @override
  String get nintendoGuideStep3 => 'Paso 3: Configura as restricións.';

  @override
  String get nintendoGuideStep4 => 'Paso 4: Garda a configuración.';

  @override
  String get nintendoGuideStep5 => 'Paso 5: Proba os controis parentais.';
}
