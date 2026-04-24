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
}
