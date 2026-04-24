import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
      <String>['es', 'gl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
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
