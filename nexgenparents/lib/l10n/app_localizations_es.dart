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
  String get xboxGuideTitle => 'Control Parental en Xbox';

  @override
  String get xboxGuideDescription =>
      'Configura filtros de contenido, restricciones de compra y privacidad en Xbox Series X/S y Xbox One mediante la cuenta familiar de Microsoft.';

  @override
  String get xboxGuideStep1 =>
      'Presiona el botón Xbox en el control y ve a "Perfil y sistema" → "Configuración".';

  @override
  String get xboxGuideStep2 => 'Selecciona "Cuenta" → "Familia".';

  @override
  String get xboxGuideStep3 =>
      'Elige la cuenta del niño y selecciona "Configuración de privacidad y seguridad en línea".';

  @override
  String get xboxGuideStep4 =>
      'Configura restricciones de contenido, comunicación con otros jugadores y compras.';

  @override
  String get xboxGuideStep5 =>
      'Confirma los cambios. La configuración se aplica automáticamente al perfil del niño.';

  @override
  String get xboxTimeGuideTitle => 'Límites de Tiempo de Uso en Xbox';

  @override
  String get xboxTimeGuideDescription =>
      'Establece horarios y límites de tiempo de juego diario en Xbox para cada miembro de la familia desde la app Microsoft Family Safety.';

  @override
  String get xboxTimeGuideStep1 =>
      'Descarga e instala la app "Microsoft Family Safety" en tu smartphone. Inicia sesión con tu cuenta Microsoft.';

  @override
  String get xboxTimeGuideStep2 =>
      'Selecciona el perfil del niño en la app y accede a "Tiempo de pantalla".';

  @override
  String get xboxTimeGuideStep3 =>
      'Activa los límites de tiempo y configura cuántas horas puede usar Xbox cada día de la semana.';

  @override
  String get xboxTimeGuideStep4 =>
      'Establece las franjas horarias en las que la consola está disponible (por ejemplo, solo de 17:00 a 20:00).';

  @override
  String get xboxTimeGuideStep5 =>
      'Guarda la configuración. El niño recibirá avisos antes de que se acabe su tiempo y necesitará tu aprobación para pedir más tiempo.';

  @override
  String get nintendoGuideTitle => 'Control Parental en Nintendo Switch';

  @override
  String get nintendoGuideDescription =>
      'Configura el control parental directamente en la consola Nintendo Switch para restringir contenido y establecer límites de edad.';

  @override
  String get nintendoGuideStep1 =>
      'Accede a "Configuración de la consola" desde el menú principal de Nintendo Switch.';

  @override
  String get nintendoGuideStep2 =>
      'Desplázate hacia abajo y selecciona "Control parental".';

  @override
  String get nintendoGuideStep3 =>
      'Elige "Usar smartphone" para vincular la app, o "Configurar ahora" si prefieres hacerlo desde la consola.';

  @override
  String get nintendoGuideStep4 =>
      'Selecciona el nivel de restricción de contenido según la edad del niño.';

  @override
  String get nintendoGuideStep5 =>
      'Establece un PIN de 4 dígitos para proteger la configuración. Guarda y confirma.';

  @override
  String get nintendoAppGuideTitle =>
      'Configurar la App de Control Parental (Nintendo)';

  @override
  String get nintendoAppGuideDescription =>
      'Aprende a vincular y configurar la app "Nintendo Switch Parental Controls" en tu smartphone para gestionar remotamente los límites de juego.';

  @override
  String get nintendoAppGuideStep1 =>
      'Descarga la app "Nintendo Switch Parental Controls" en tu smartphone (disponible en Android e iOS).';

  @override
  String get nintendoAppGuideStep2 =>
      'Abre la app y acepta los términos de uso. Inicia sesión con tu cuenta Nintendo o crea una nueva.';

  @override
  String get nintendoAppGuideStep3 =>
      'En la consola, ve a "Configuración" → "Control parental" → "Usar smartphone" y escanea el código QR con la app.';

  @override
  String get nintendoAppGuideStep4 =>
      'Asigna un nombre al niño y selecciona su grupo de edad para aplicar restricciones automáticas.';

  @override
  String get nintendoAppGuideStep5 =>
      'Configura el límite de tiempo de juego diario. Puedes establecer límites distintos para días de semana y fin de semana.';

  @override
  String get nintendoAppGuideStep6 =>
      'Activa la restricción de juego después de la hora límite y personaliza el mensaje que verá el niño al alcanzarlo.';

  @override
  String get nintendoAppGuideStep7 =>
      'Revisa el resumen mensual de actividad: juegos usados, tiempo total y tendencias por día.';

  @override
  String get nintendoAppGuideStep8 =>
      'Desde la app puedes añadir tiempo extra puntualmente o suspender los límites temporalmente sin tocar la consola.';

  @override
  String get steamGuideTitle => 'Control Parental en Steam';

  @override
  String get steamGuideDescription =>
      'Configura el Modo Familiar de Steam para controlar qué juegos pueden acceder tus hijos.';

  @override
  String get steamGuideStep1 =>
      'Abre Steam en el PC y haz clic en "Steam" (arriba izquierda) → "Configuración".';

  @override
  String get steamGuideStep2 => 'Selecciona "Familia" en el menú lateral.';

  @override
  String get steamGuideStep3 =>
      'Activa "Vista Familiar" y establece un PIN de seguridad.';

  @override
  String get steamGuideStep4 =>
      'Selecciona manualmente qué juegos de tu biblioteca serán visibles en el modo familiar.';

  @override
  String get steamGuideStep5 =>
      'Los niños solo podrán acceder a los juegos aprobados. Para salir del modo, necesitarán el PIN.';

  @override
  String get iosGuideTitle => 'Activar Control Parental en iOS (iPhone/iPad)';

  @override
  String get iosGuideDescription =>
      'Configura Tiempo de uso, contenido y privacidad en iPhone/iPad para proteger a menores.';

  @override
  String get iosGuideStep1 =>
      'Abre Ajustes en el iPhone/iPad y entra en "Tiempo de uso".';

  @override
  String get iosGuideStep2 =>
      'Pulsa "Activar Tiempo de uso" y selecciona "Este es el iPhone de mi hijo".';

  @override
  String get iosGuideStep3 =>
      'Define un código de Tiempo de uso distinto al desbloqueo del móvil.';

  @override
  String get iosGuideStep4 =>
      'Configura "Tiempo de inactividad", "Límites de apps" y "Restricciones de contenido y privacidad".';
}
