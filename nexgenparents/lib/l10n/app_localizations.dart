import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_gl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('gl')
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'NexGen Parents'**
  String get appName;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando {appName}...'**
  String loading(String appName);

  /// No description provided for @classificationSystemsTitle.
  ///
  /// In es, this message translates to:
  /// **'Sistemas de Clasificación'**
  String get classificationSystemsTitle;

  /// No description provided for @pegiInfoSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Aprende a interpretar PEGI y ESRB para elegir juegos adecuados para cada edad.'**
  String get pegiInfoSubtitle;

  /// No description provided for @ageRatingsMeaningTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Qué significan las clasificaciones por edad?'**
  String get ageRatingsMeaningTitle;

  /// No description provided for @pegiSystemEuropa.
  ///
  /// In es, this message translates to:
  /// **'Sistema PEGI (Europa)'**
  String get pegiSystemEuropa;

  /// No description provided for @esrbSystemUsa.
  ///
  /// In es, this message translates to:
  /// **'Sistema ESRB (EE. UU.)'**
  String get esrbSystemUsa;

  /// No description provided for @esrbApiNote.
  ///
  /// In es, this message translates to:
  /// **'Este es el sistema que suele aparecer en la API de videojuegos que utilizamos.'**
  String get esrbApiNote;

  /// No description provided for @pegiContentDescriptorsTitle.
  ///
  /// In es, this message translates to:
  /// **'Descriptores de Contenido PEGI'**
  String get pegiContentDescriptorsTitle;

  /// No description provided for @pegiContentDescriptorsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Además de la edad, las clasificaciones incluyen iconos que indican el tipo de contenido:'**
  String get pegiContentDescriptorsSubtitle;

  /// No description provided for @contentDescriptorViolence.
  ///
  /// In es, this message translates to:
  /// **'Violencia'**
  String get contentDescriptorViolence;

  /// No description provided for @contentDescriptorFear.
  ///
  /// In es, this message translates to:
  /// **'Miedo'**
  String get contentDescriptorFear;

  /// No description provided for @contentDescriptorOnline.
  ///
  /// In es, this message translates to:
  /// **'Online'**
  String get contentDescriptorOnline;

  /// No description provided for @contentDescriptorDiscrimination.
  ///
  /// In es, this message translates to:
  /// **'Discriminación'**
  String get contentDescriptorDiscrimination;

  /// No description provided for @contentDescriptorDrugs.
  ///
  /// In es, this message translates to:
  /// **'Drogas'**
  String get contentDescriptorDrugs;

  /// No description provided for @contentDescriptorSex.
  ///
  /// In es, this message translates to:
  /// **'Sexo'**
  String get contentDescriptorSex;

  /// No description provided for @contentDescriptorBadLanguage.
  ///
  /// In es, this message translates to:
  /// **'Lenguaje soez'**
  String get contentDescriptorBadLanguage;

  /// No description provided for @contentDescriptorGambling.
  ///
  /// In es, this message translates to:
  /// **'Juego/Apuestas'**
  String get contentDescriptorGambling;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In es, this message translates to:
  /// **'El correo electrónico no es válido'**
  String get errorInvalidEmail;

  /// No description provided for @errorWeakPassword.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número'**
  String get errorWeakPassword;

  /// No description provided for @errorUserNotFound.
  ///
  /// In es, this message translates to:
  /// **'No existe un usuario con este correo'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In es, this message translates to:
  /// **'La contraseña es incorrecta'**
  String get errorWrongPassword;

  /// No description provided for @errorUserDisabled.
  ///
  /// In es, this message translates to:
  /// **'Esta cuenta ha sido deshabilitada'**
  String get errorUserDisabled;

  /// No description provided for @errorEmailInUse.
  ///
  /// In es, this message translates to:
  /// **'Este correo ya está registrado'**
  String get errorEmailInUse;

  /// No description provided for @errorEmailInUseRecovery.
  ///
  /// In es, this message translates to:
  /// **'Este correo ya está registrado. Si borraste solo el perfil en la base de datos, inicia sesión con tu contraseña anterior para restaurarlo.'**
  String get errorEmailInUseRecovery;

  /// No description provided for @errorDifferentCredential.
  ///
  /// In es, this message translates to:
  /// **'Este correo ya está registrado con otro método de acceso'**
  String get errorDifferentCredential;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In es, this message translates to:
  /// **'Las credenciales no son válidas'**
  String get errorInvalidCredential;

  /// No description provided for @errorPopupClosed.
  ///
  /// In es, this message translates to:
  /// **'Has cerrado la ventana de Google antes de completar el acceso'**
  String get errorPopupClosed;

  /// No description provided for @errorPopupBlocked.
  ///
  /// In es, this message translates to:
  /// **'El navegador bloqueó la ventana emergente de Google. Inténtalo de nuevo'**
  String get errorPopupBlocked;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In es, this message translates to:
  /// **'No hay permisos para acceder al perfil en Firestore. Revisa y despliega firestore.rules.'**
  String get errorPermissionDenied;

  /// No description provided for @errorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Error inesperado: {error}'**
  String errorGeneric(String error);

  /// No description provided for @errorCreatingUser.
  ///
  /// In es, this message translates to:
  /// **'Error al crear el usuario'**
  String get errorCreatingUser;

  /// No description provided for @errorCreatingProfile.
  ///
  /// In es, this message translates to:
  /// **'No se pudo crear el perfil del usuario'**
  String get errorCreatingProfile;

  /// No description provided for @errorLogin.
  ///
  /// In es, this message translates to:
  /// **'Error al iniciar sesión'**
  String get errorLogin;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el perfil del usuario'**
  String get errorLoadingProfile;

  /// No description provided for @successUserRegistered.
  ///
  /// In es, this message translates to:
  /// **'Usuario registrado correctamente'**
  String get successUserRegistered;

  /// No description provided for @successLogin.
  ///
  /// In es, this message translates to:
  /// **'Sesión iniciada correctamente'**
  String get successLogin;

  /// No description provided for @successLoginGoogle.
  ///
  /// In es, this message translates to:
  /// **'Sesión iniciada correctamente con Google'**
  String get successLoginGoogle;

  /// No description provided for @successPasswordReset.
  ///
  /// In es, this message translates to:
  /// **'Correo de recuperación enviado. Revisa tu bandeja de entrada'**
  String get successPasswordReset;

  /// No description provided for @guideTypeEnable.
  ///
  /// In es, this message translates to:
  /// **'Habilitar guía'**
  String get guideTypeEnable;

  /// No description provided for @guideTypeDisable.
  ///
  /// In es, this message translates to:
  /// **'Deshabilitar guía'**
  String get guideTypeDisable;

  /// No description provided for @guideTypeApp.
  ///
  /// In es, this message translates to:
  /// **'Guía de aplicaciones'**
  String get guideTypeApp;

  /// No description provided for @guideTypeTime.
  ///
  /// In es, this message translates to:
  /// **'Guía de tiempo'**
  String get guideTypeTime;

  /// No description provided for @guideTypeDefault.
  ///
  /// In es, this message translates to:
  /// **'Guía por defecto'**
  String get guideTypeDefault;

  /// No description provided for @psEnableGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Cómo habilitar la guía parental'**
  String get psEnableGuideTitle;

  /// No description provided for @psEnableGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Sigue estos pasos para habilitar la guía parental en tu dispositivo.'**
  String get psEnableGuideDescription;

  /// No description provided for @psEnableGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Abre la aplicación de configuración.'**
  String get psEnableGuideStep1;

  /// No description provided for @psEnableGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Selecciona \'Controles parentales\'.'**
  String get psEnableGuideStep2;

  /// No description provided for @psEnableGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Activa la opción de guía parental.'**
  String get psEnableGuideStep3;

  /// No description provided for @psEnableGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Configura las restricciones según tus necesidades.'**
  String get psEnableGuideStep4;

  /// No description provided for @psEnableGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Guarda los cambios.'**
  String get psEnableGuideStep5;

  /// No description provided for @psEnableGuideStep6.
  ///
  /// In es, this message translates to:
  /// **'Verifica que la guía esté activa.'**
  String get psEnableGuideStep6;

  /// No description provided for @psDisableGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Cómo deshabilitar la guía parental'**
  String get psDisableGuideTitle;

  /// No description provided for @psDisableGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Sigue estos pasos para deshabilitar la guía parental en tu dispositivo.'**
  String get psDisableGuideDescription;

  /// No description provided for @psDisableGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Abre la aplicación de configuración.'**
  String get psDisableGuideStep1;

  /// No description provided for @psDisableGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Selecciona \'Controles parentales\'.'**
  String get psDisableGuideStep2;

  /// No description provided for @psDisableGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Desactiva la opción de guía parental.'**
  String get psDisableGuideStep3;

  /// No description provided for @psDisableGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Guarda los cambios.'**
  String get psDisableGuideStep4;

  /// No description provided for @psDisableGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Verifica que la guía esté desactivada.'**
  String get psDisableGuideStep5;

  /// No description provided for @nintendoAppGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Paso 2: Abre la aplicación de Nintendo.'**
  String get nintendoAppGuideStep2;

  /// No description provided for @nintendoAppGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Paso 3: Ve a la sección de controles parentales.'**
  String get nintendoAppGuideStep3;

  /// No description provided for @nintendoAppGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Paso 4: Configura las restricciones según sea necesario.'**
  String get nintendoAppGuideStep4;

  /// No description provided for @nintendoAppGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Paso 5: Guarda la configuración.'**
  String get nintendoAppGuideStep5;

  /// No description provided for @nintendoAppGuideStep6.
  ///
  /// In es, this message translates to:
  /// **'Paso 6: Vincula tu cuenta.'**
  String get nintendoAppGuideStep6;

  /// No description provided for @nintendoAppGuideStep7.
  ///
  /// In es, this message translates to:
  /// **'Paso 7: Confirma la configuración.'**
  String get nintendoAppGuideStep7;

  /// No description provided for @nintendoAppGuideStep8.
  ///
  /// In es, this message translates to:
  /// **'Paso 8: Prueba los controles parentales.'**
  String get nintendoAppGuideStep8;

  /// No description provided for @steamGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Guía parental de Steam'**
  String get steamGuideTitle;

  /// No description provided for @steamGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Aprende a configurar los controles parentales en Steam.'**
  String get steamGuideDescription;

  /// No description provided for @steamGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Paso 1: Abre la configuración de Steam.'**
  String get steamGuideStep1;

  /// No description provided for @steamGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Paso 2: Ve a la sección Familia.'**
  String get steamGuideStep2;

  /// No description provided for @steamGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Paso 3: Habilita la Vista Familiar.'**
  String get steamGuideStep3;

  /// No description provided for @steamGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Paso 4: Configura un PIN.'**
  String get steamGuideStep4;

  /// No description provided for @steamGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Paso 5: Restringe el contenido según sea necesario.'**
  String get steamGuideStep5;

  /// No description provided for @iosGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Guía parental de iOS'**
  String get iosGuideTitle;

  /// No description provided for @iosGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Aprende a configurar los controles parentales en dispositivos iOS.'**
  String get iosGuideDescription;

  /// No description provided for @iosGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Paso 1: Abre Configuración.'**
  String get iosGuideStep1;

  /// No description provided for @iosGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Paso 2: Ve a Tiempo en Pantalla.'**
  String get iosGuideStep2;

  /// No description provided for @iosGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Paso 3: Habilita las restricciones.'**
  String get iosGuideStep3;

  /// No description provided for @iosGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Paso 4: Configura un código de acceso.'**
  String get iosGuideStep4;

  /// No description provided for @xboxGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Guía parental de Xbox'**
  String get xboxGuideTitle;

  /// No description provided for @xboxGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Aprende a configurar los controles parentales en Xbox.'**
  String get xboxGuideDescription;

  /// No description provided for @xboxGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Paso 1: Abre la configuración de Xbox.'**
  String get xboxGuideStep1;

  /// No description provided for @xboxGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Paso 2: Ve a la sección Familia.'**
  String get xboxGuideStep2;

  /// No description provided for @xboxGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Paso 3: Habilita los controles parentales.'**
  String get xboxGuideStep3;

  /// No description provided for @xboxGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Paso 4: Configura las restricciones.'**
  String get xboxGuideStep4;

  /// No description provided for @xboxGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Paso 5: Guarda la configuración.'**
  String get xboxGuideStep5;

  /// No description provided for @xboxTimeGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Guía de tiempo de Xbox'**
  String get xboxTimeGuideTitle;

  /// No description provided for @xboxTimeGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Aprende a configurar límites de tiempo en Xbox.'**
  String get xboxTimeGuideDescription;

  /// No description provided for @xboxTimeGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Paso 1: Abre la configuración de Xbox.'**
  String get xboxTimeGuideStep1;

  /// No description provided for @xboxTimeGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Paso 2: Ve a la sección Familia.'**
  String get xboxTimeGuideStep2;

  /// No description provided for @xboxTimeGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Paso 3: Habilita los límites de tiempo.'**
  String get xboxTimeGuideStep3;

  /// No description provided for @xboxTimeGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Paso 4: Configura los horarios.'**
  String get xboxTimeGuideStep4;

  /// No description provided for @xboxTimeGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Paso 5: Guarda la configuración.'**
  String get xboxTimeGuideStep5;

  /// No description provided for @nintendoGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Guía parental de Nintendo'**
  String get nintendoGuideTitle;

  /// No description provided for @nintendoGuideDescription.
  ///
  /// In es, this message translates to:
  /// **'Aprende a configurar los controles parentales en Nintendo.'**
  String get nintendoGuideDescription;

  /// No description provided for @nintendoGuideStep1.
  ///
  /// In es, this message translates to:
  /// **'Paso 1: Abre la configuración de Nintendo.'**
  String get nintendoGuideStep1;

  /// No description provided for @nintendoGuideStep2.
  ///
  /// In es, this message translates to:
  /// **'Paso 2: Ve a la sección de controles parentales.'**
  String get nintendoGuideStep2;

  /// No description provided for @nintendoGuideStep3.
  ///
  /// In es, this message translates to:
  /// **'Paso 3: Configura las restricciones.'**
  String get nintendoGuideStep3;

  /// No description provided for @nintendoGuideStep4.
  ///
  /// In es, this message translates to:
  /// **'Paso 4: Guarda la configuración.'**
  String get nintendoGuideStep4;

  /// No description provided for @nintendoGuideStep5.
  ///
  /// In es, this message translates to:
  /// **'Paso 5: Prueba los controles parentales.'**
  String get nintendoGuideStep5;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'gl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'gl':
      return AppLocalizationsGl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
