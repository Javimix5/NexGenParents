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
  String get xboxGuideTitle => 'Control Parental en Xbox';

  @override
  String get xboxGuideDescription =>
      'Configura filtros de contido, restricións de compra e privacidade en Xbox Series X/S e Xbox One mediante a conta familiar de Microsoft.';

  @override
  String get xboxGuideStep1 =>
      'Preme o botón Xbox no control e vai a "Perfil e sistema" → "Configuración".';

  @override
  String get xboxGuideStep2 => 'Selecciona "Conta" → "Familia".';

  @override
  String get xboxGuideStep3 =>
      'Elixe a conta do neno e selecciona "Configuración de privacidade e seguridade en liña".';

  @override
  String get xboxGuideStep4 =>
      'Configura restricións de contido, comunicación con outros xogadores e compras.';

  @override
  String get xboxGuideStep5 =>
      'Confirma os cambios. A configuración aplícase automaticamente ao perfil do neno.';

  @override
  String get xboxTimeGuideTitle => 'Límites de Tempo de Uso en Xbox';

  @override
  String get xboxTimeGuideDescription =>
      'Establece horarios e límites de tempo de xogo diario en Xbox para cada membro da familia desde a app Microsoft Family Safety.';

  @override
  String get xboxTimeGuideStep1 =>
      'Descarga e instala a app "Microsoft Family Safety" no teu smartphone. Inicia sesión coa túa conta Microsoft.';

  @override
  String get xboxTimeGuideStep2 =>
      'Selecciona o perfil do neno na app e accede a "Tempo de pantalla".';

  @override
  String get xboxTimeGuideStep3 =>
      'Activa os límites de tempo e configura cantas horas pode usar Xbox cada día da semana.';

  @override
  String get xboxTimeGuideStep4 =>
      'Establece as franxas horarias nas que a consola está dispoñible (por exemplo, só de 17:00 a 20:00).';

  @override
  String get xboxTimeGuideStep5 =>
      'Garda a configuración. O neno recibirá avisos antes de que se acabe o seu tempo e necesitará a túa aprobación para pedir máis tempo.';

  @override
  String get nintendoGuideTitle => 'Control Parental en Nintendo Switch';

  @override
  String get nintendoGuideDescription =>
      'Configura o control parental directamente na consola Nintendo Switch para restrinxir contido e establecer límites de idade.';

  @override
  String get nintendoGuideStep1 =>
      'Accede a "Configuración da consola" desde o menú principal de Nintendo Switch.';

  @override
  String get nintendoGuideStep2 =>
      'Desprázate cara abaixo e selecciona "Control parental".';

  @override
  String get nintendoGuideStep3 =>
      'Elixe "Usar smartphone" para vincular a app, ou "Configurar agora" se prefires facelo desde a consola.';

  @override
  String get nintendoGuideStep4 =>
      'Selecciona o nivel de restrición de contido segundo a idade do neno.';

  @override
  String get nintendoGuideStep5 =>
      'Establece un PIN de 4 díxitos para protexer a configuración. Garda e confirma.';

  @override
  String get nintendoAppGuideTitle =>
      'Configurar a App de Control Parental (Nintendo)';

  @override
  String get nintendoAppGuideDescription =>
      'Aprende a vincular e configurar a app "Nintendo Switch Parental Controls" no teu smartphone para xestionar remotamente os límites de xogo.';

  @override
  String get nintendoAppGuideStep1 =>
      'Descarga a app "Nintendo Switch Parental Controls" no teu smartphone (dispoñible en Android e iOS).';

  @override
  String get nintendoAppGuideStep2 =>
      'Abre a app e acepta os termos de uso. Inicia sesión coa túa conta Nintendo ou crea unha nova.';

  @override
  String get nintendoAppGuideStep3 =>
      'Na consola, vai a "Configuración" → "Control parental" → "Usar smartphone" e escanea o código QR coa app.';

  @override
  String get nintendoAppGuideStep4 =>
      'Asigna un nome ao neno e selecciona o seu grupo de idade para aplicar restricións automáticas.';

  @override
  String get nintendoAppGuideStep5 =>
      'Configura o límite de tempo de xogo diario. Podes establecer límites distintos para días de semana e fin de semana.';

  @override
  String get nintendoAppGuideStep6 =>
      'Activa a restrición de xogo despois da hora límite e personaliza a mensaxe que verá o neno ao alcanzalo.';

  @override
  String get nintendoAppGuideStep7 =>
      'Revisa o resumo mensual de actividade: xogos usados, tempo total e tendencias por día.';

  @override
  String get nintendoAppGuideStep8 =>
      'Desde a app podes engadir tempo extra puntualmente ou suspender os límites temporalmente sen tocar a consola.';

  @override
  String get steamGuideTitle => 'Control Parental en Steam';

  @override
  String get steamGuideDescription =>
      'Configura o Modo Familiar de Steam para controlar que xogos poden acceder os teus fillos.';

  @override
  String get steamGuideStep1 =>
      'Abre Steam no PC e fai clic en "Steam" (arriba esquerda) → "Configuración".';

  @override
  String get steamGuideStep2 => 'Selecciona "Familia" no menú lateral.';

  @override
  String get steamGuideStep3 =>
      'Activa "Vista Familiar" e establece un PIN de seguridade.';

  @override
  String get steamGuideStep4 =>
      'Selecciona manualmente que xogos da túa biblioteca serán visibles no modo familiar.';

  @override
  String get steamGuideStep5 =>
      'Os nenos só poderán acceder aos xogos aprobados. Para saír do modo, necesitarán o PIN.';

  @override
  String get iosGuideTitle => 'Activar Control Parental en iOS (iPhone/iPad)';

  @override
  String get iosGuideDescription =>
      'Configura Tempo de uso, contido e privacidade en iPhone/iPad para protexer a menores.';

  @override
  String get iosGuideStep1 =>
      'Abre Axustes no iPhone/iPad e entra en "Tempo de uso".';

  @override
  String get iosGuideStep2 =>
      'Preme "Activar Tempo de uso" e selecciona "Este é o iPhone do meu fillo".';

  @override
  String get iosGuideStep3 =>
      'Define un código de Tempo de uso distinto ao desbloqueo do móbil.';

  @override
  String get iosGuideStep4 =>
      'Configura "Tempo de inactividade", "Límites de apps" e "Restricións de contido e privacidade".';
}
