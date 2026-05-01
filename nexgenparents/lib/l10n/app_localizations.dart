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

  /// No description provided for @searchGamesHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar juego por nombre...'**
  String get searchGamesHint;

  /// No description provided for @searchGamesAdvancedFilters.
  ///
  /// In es, this message translates to:
  /// **'Filtros avanzados'**
  String get searchGamesAdvancedFilters;

  /// No description provided for @searchGamesShowingRecent.
  ///
  /// In es, this message translates to:
  /// **'Mostrando los juegos más recientes del último año'**
  String get searchGamesShowingRecent;

  /// No description provided for @searchGamesFilterFrom.
  ///
  /// In es, this message translates to:
  /// **'Desde'**
  String get searchGamesFilterFrom;

  /// No description provided for @searchGamesFilterTo.
  ///
  /// In es, this message translates to:
  /// **'Hasta'**
  String get searchGamesFilterTo;

  /// No description provided for @searchGamesFilterGenres.
  ///
  /// In es, this message translates to:
  /// **'género(s)'**
  String get searchGamesFilterGenres;

  /// No description provided for @searchGamesFilterPlatforms.
  ///
  /// In es, this message translates to:
  /// **'plataforma(s)'**
  String get searchGamesFilterPlatforms;

  /// No description provided for @searchGamesClearAll.
  ///
  /// In es, this message translates to:
  /// **'Limpiar todo'**
  String get searchGamesClearAll;

  /// No description provided for @searchGamesEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron juegos'**
  String get searchGamesEmptyTitle;

  /// No description provided for @searchGamesEmptyMessage.
  ///
  /// In es, this message translates to:
  /// **'Intenta ajustar los filtros o busca otro término'**
  String get searchGamesEmptyMessage;

  /// No description provided for @filtersTitle.
  ///
  /// In es, this message translates to:
  /// **'Filtros de Búsqueda'**
  String get filtersTitle;

  /// No description provided for @filtersClear.
  ///
  /// In es, this message translates to:
  /// **'Limpiar'**
  String get filtersClear;

  /// No description provided for @filtersInfoBanner.
  ///
  /// In es, this message translates to:
  /// **'Combina múltiples filtros para encontrar el juego perfecto'**
  String get filtersInfoBanner;

  /// No description provided for @filtersYearTitle.
  ///
  /// In es, this message translates to:
  /// **'Año de lanzamiento'**
  String get filtersYearTitle;

  /// No description provided for @filtersYearSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Filtra juegos por su año de salida'**
  String get filtersYearSubtitle;

  /// No description provided for @filtersYearFrom.
  ///
  /// In es, this message translates to:
  /// **'Desde'**
  String get filtersYearFrom;

  /// No description provided for @filtersYearTo.
  ///
  /// In es, this message translates to:
  /// **'Hasta'**
  String get filtersYearTo;

  /// No description provided for @filtersYearAny.
  ///
  /// In es, this message translates to:
  /// **'Cualquiera'**
  String get filtersYearAny;

  /// No description provided for @filtersPegiTitle.
  ///
  /// In es, this message translates to:
  /// **'Edad recomendada (PEGI)'**
  String get filtersPegiTitle;

  /// No description provided for @filtersPegiSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Selecciona la edad de tu hijo para ver juegos apropiados'**
  String get filtersPegiSubtitle;

  /// No description provided for @filtersPlatformTitle.
  ///
  /// In es, this message translates to:
  /// **'Plataforma'**
  String get filtersPlatformTitle;

  /// No description provided for @filtersPlatformSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Selecciona en qué dispositivos quieres que esté disponible'**
  String get filtersPlatformSubtitle;

  /// No description provided for @filtersGenreTitle.
  ///
  /// In es, this message translates to:
  /// **'Género de juego'**
  String get filtersGenreTitle;

  /// No description provided for @filtersGenreSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Elige el tipo de juegos que te interesan'**
  String get filtersGenreSubtitle;

  /// No description provided for @filtersApplyBtn.
  ///
  /// In es, this message translates to:
  /// **'Aplicar Filtros'**
  String get filtersApplyBtn;

  /// No description provided for @forumSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar hilos por título...'**
  String get forumSearchHint;

  /// No description provided for @forumEmptySearchTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin resultados'**
  String get forumEmptySearchTitle;

  /// No description provided for @forumEmptySearchMessage.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron hilos que coincidan con tu búsqueda.'**
  String get forumEmptySearchMessage;

  /// No description provided for @forumEmptyCategoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Categoría vacía'**
  String get forumEmptyCategoryTitle;

  /// No description provided for @forumEmptyCategoryMessage.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay novedades en esta sección. ¡Anímate y publica algo!'**
  String get forumEmptyCategoryMessage;

  /// No description provided for @forumPostSubtitle.
  ///
  /// In es, this message translates to:
  /// **'por {author} • {count} respuestas'**
  String forumPostSubtitle(String author, int count);

  /// No description provided for @forumDeleteTooltip.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get forumDeleteTooltip;

  /// No description provided for @forumDeletePostTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar publicación'**
  String get forumDeletePostTitle;

  /// No description provided for @forumDeletePostContent.
  ///
  /// In es, this message translates to:
  /// **'¿Quieres eliminar \"{title}\" y todas sus respuestas?'**
  String forumDeletePostContent(String title);

  /// No description provided for @forumCancelBtn.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get forumCancelBtn;

  /// No description provided for @forumDeleteBtn.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get forumDeleteBtn;

  /// No description provided for @forumNewPostBtn.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Hilo'**
  String get forumNewPostBtn;

  /// No description provided for @forumPostDeletedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Publicación eliminada'**
  String get forumPostDeletedSuccess;

  /// No description provided for @forumPostDeletedError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo eliminar la publicación'**
  String get forumPostDeletedError;

  /// No description provided for @forumCreateLoginRequired.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para publicar'**
  String get forumCreateLoginRequired;

  /// No description provided for @forumCreateUnknownError.
  ///
  /// In es, this message translates to:
  /// **'Error desconocido'**
  String get forumCreateUnknownError;

  /// No description provided for @forumCreateTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear Nuevo Hilo'**
  String get forumCreateTitle;

  /// No description provided for @forumCreateFieldTitle.
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get forumCreateFieldTitle;

  /// No description provided for @forumCreateErrorTitle.
  ///
  /// In es, this message translates to:
  /// **'El título es obligatorio'**
  String get forumCreateErrorTitle;

  /// No description provided for @forumCreateFieldSection.
  ///
  /// In es, this message translates to:
  /// **'Sección'**
  String get forumCreateFieldSection;

  /// No description provided for @forumCreateFieldContent.
  ///
  /// In es, this message translates to:
  /// **'Contenido'**
  String get forumCreateFieldContent;

  /// No description provided for @forumCreateErrorContent.
  ///
  /// In es, this message translates to:
  /// **'El contenido es obligatorio'**
  String get forumCreateErrorContent;

  /// No description provided for @forumCreatePublishingBtn.
  ///
  /// In es, this message translates to:
  /// **'Publicando...'**
  String get forumCreatePublishingBtn;

  /// No description provided for @forumCreatePublishBtn.
  ///
  /// In es, this message translates to:
  /// **'Publicar'**
  String get forumCreatePublishBtn;

  /// No description provided for @forumPostByAuthor.
  ///
  /// In es, this message translates to:
  /// **'por {author}'**
  String forumPostByAuthor(String author);

  /// No description provided for @forumDetailRepliesTitle.
  ///
  /// In es, this message translates to:
  /// **'Respuestas'**
  String get forumDetailRepliesTitle;

  /// No description provided for @forumDetailEmptyReplies.
  ///
  /// In es, this message translates to:
  /// **'No hay respuestas todavía.'**
  String get forumDetailEmptyReplies;

  /// No description provided for @forumDeleteReplyTooltip.
  ///
  /// In es, this message translates to:
  /// **'Eliminar respuesta'**
  String get forumDeleteReplyTooltip;

  /// No description provided for @forumDeleteReplyTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar respuesta'**
  String get forumDeleteReplyTitle;

  /// No description provided for @forumDeleteReplyContent.
  ///
  /// In es, this message translates to:
  /// **'¿Quieres eliminar esta respuesta?'**
  String get forumDeleteReplyContent;

  /// No description provided for @forumReplyDeletedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Respuesta eliminada'**
  String get forumReplyDeletedSuccess;

  /// No description provided for @forumReplyDeletedError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo eliminar la respuesta'**
  String get forumReplyDeletedError;

  /// No description provided for @forumDetailReplyInputHint.
  ///
  /// In es, this message translates to:
  /// **'Escribe una respuesta...'**
  String get forumDetailReplyInputHint;

  /// No description provided for @dictDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalle del Término'**
  String get dictDetailTitle;

  /// No description provided for @dictEditTooltip.
  ///
  /// In es, this message translates to:
  /// **'Editar Término'**
  String get dictEditTooltip;

  /// No description provided for @dictDeleteTooltip.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Término'**
  String get dictDeleteTooltip;

  /// No description provided for @dictLoadingTerm.
  ///
  /// In es, this message translates to:
  /// **'Cargando término...'**
  String get dictLoadingTerm;

  /// No description provided for @dictErrorLoadingTerm.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar el término'**
  String get dictErrorLoadingTerm;

  /// No description provided for @dictBackBtn.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get dictBackBtn;

  /// No description provided for @dictDefinitionLabel.
  ///
  /// In es, this message translates to:
  /// **'Definición'**
  String get dictDefinitionLabel;

  /// No description provided for @dictExampleLabel.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo de uso'**
  String get dictExampleLabel;

  /// No description provided for @dictUsefulQuestion.
  ///
  /// In es, this message translates to:
  /// **'¿Te ha sido útil este término?'**
  String get dictUsefulQuestion;

  /// No description provided for @dictVoteThanks.
  ///
  /// In es, this message translates to:
  /// **'¡Gracias por tu voto!'**
  String get dictVoteThanks;

  /// No description provided for @dictVoteRegistered.
  ///
  /// In es, this message translates to:
  /// **'Voto registrado'**
  String get dictVoteRegistered;

  /// No description provided for @dictVoteBtn.
  ///
  /// In es, this message translates to:
  /// **'Sí, me ha ayudado'**
  String get dictVoteBtn;

  /// No description provided for @dictUsefulVotes.
  ///
  /// In es, this message translates to:
  /// **'Votos útiles'**
  String get dictUsefulVotes;

  /// No description provided for @dictViews.
  ///
  /// In es, this message translates to:
  /// **'Visualizaciones'**
  String get dictViews;

  /// No description provided for @dictAdditionalInfo.
  ///
  /// In es, this message translates to:
  /// **'Información adicional'**
  String get dictAdditionalInfo;

  /// No description provided for @dictAddedOn.
  ///
  /// In es, this message translates to:
  /// **'Añadido el'**
  String get dictAddedOn;

  /// No description provided for @dictLastUpdate.
  ///
  /// In es, this message translates to:
  /// **'Última actualización'**
  String get dictLastUpdate;

  /// No description provided for @dictStatusLabel.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get dictStatusLabel;

  /// No description provided for @dictStatusApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobado'**
  String get dictStatusApproved;

  /// No description provided for @dictStatusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get dictStatusPending;

  /// No description provided for @dictStatusRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazado'**
  String get dictStatusRejected;

  /// No description provided for @dictEditDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar Término'**
  String get dictEditDialogTitle;

  /// No description provided for @dictEditFieldTerm.
  ///
  /// In es, this message translates to:
  /// **'Término'**
  String get dictEditFieldTerm;

  /// No description provided for @dictEditErrorTerm.
  ///
  /// In es, this message translates to:
  /// **'El término no puede estar vacío'**
  String get dictEditErrorTerm;

  /// No description provided for @dictEditFieldDefinition.
  ///
  /// In es, this message translates to:
  /// **'Definición'**
  String get dictEditFieldDefinition;

  /// No description provided for @dictEditErrorDefinition.
  ///
  /// In es, this message translates to:
  /// **'La definición no puede estar vacía'**
  String get dictEditErrorDefinition;

  /// No description provided for @dictEditFieldExample.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo (opcional)'**
  String get dictEditFieldExample;

  /// No description provided for @dictEditFieldCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get dictEditFieldCategory;

  /// No description provided for @dictCancelBtn.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get dictCancelBtn;

  /// No description provided for @dictSaveChangesBtn.
  ///
  /// In es, this message translates to:
  /// **'Guardar Cambios'**
  String get dictSaveChangesBtn;

  /// No description provided for @dictUpdateSuccess.
  ///
  /// In es, this message translates to:
  /// **'Término actualizado correctamente'**
  String get dictUpdateSuccess;

  /// No description provided for @dictUpdateError.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar el término'**
  String get dictUpdateError;

  /// No description provided for @dictDeleteConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Eliminación'**
  String get dictDeleteConfirmTitle;

  /// No description provided for @dictDeleteConfirmContent.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que quieres eliminar este término de forma permanente? Esta acción no se puede deshacer.'**
  String get dictDeleteConfirmContent;

  /// No description provided for @dictDeleteBtn.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get dictDeleteBtn;

  /// No description provided for @dictDeleteSuccess.
  ///
  /// In es, this message translates to:
  /// **'Término eliminado correctamente'**
  String get dictDeleteSuccess;

  /// No description provided for @dictDeleteError.
  ///
  /// In es, this message translates to:
  /// **'Error al eliminar el término'**
  String get dictDeleteError;

  /// No description provided for @dictListEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay términos en el diccionario'**
  String get dictListEmptyTitle;

  /// No description provided for @dictListEmptyMessage.
  ///
  /// In es, this message translates to:
  /// **'Sé el primero en proponer un término'**
  String get dictListEmptyMessage;

  /// No description provided for @dictListProposeBtn.
  ///
  /// In es, this message translates to:
  /// **'Proponer término'**
  String get dictListProposeBtn;

  /// No description provided for @dictProposeErrorAuth.
  ///
  /// In es, this message translates to:
  /// **'Error: Usuario no autenticado'**
  String get dictProposeErrorAuth;

  /// No description provided for @dictProposeSuccessTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Término enviado!'**
  String get dictProposeSuccessTitle;

  /// No description provided for @dictProposeSuccessMessage.
  ///
  /// In es, this message translates to:
  /// **'Tu término ha sido propuesto correctamente y será revisado por un moderador. Te notificaremos cuando sea aprobado.'**
  String get dictProposeSuccessMessage;

  /// No description provided for @dictProposeUnderstoodBtn.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get dictProposeUnderstoodBtn;

  /// No description provided for @dictProposeErrorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Error al proponer término'**
  String get dictProposeErrorGeneric;

  /// No description provided for @dictProposeTitle.
  ///
  /// In es, this message translates to:
  /// **'Proponer Término'**
  String get dictProposeTitle;

  /// No description provided for @dictProposeHelpText.
  ///
  /// In es, this message translates to:
  /// **'Ayuda a otros padres añadiendo términos que conozcas'**
  String get dictProposeHelpText;

  /// No description provided for @dictProposeFieldTerm.
  ///
  /// In es, this message translates to:
  /// **'Término o palabra'**
  String get dictProposeFieldTerm;

  /// No description provided for @dictProposeFieldTermHint.
  ///
  /// In es, this message translates to:
  /// **'Ej: GG, Nerf, Farming'**
  String get dictProposeFieldTermHint;

  /// No description provided for @dictProposeErrorTermEmpty.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce el término'**
  String get dictProposeErrorTermEmpty;

  /// No description provided for @dictProposeErrorTermLength.
  ///
  /// In es, this message translates to:
  /// **'El término debe tener al menos 2 caracteres'**
  String get dictProposeErrorTermLength;

  /// No description provided for @dictProposeFieldCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get dictProposeFieldCategory;

  /// No description provided for @dictProposeFieldDefinition.
  ///
  /// In es, this message translates to:
  /// **'Definición'**
  String get dictProposeFieldDefinition;

  /// No description provided for @dictProposeFieldDefinitionHint.
  ///
  /// In es, this message translates to:
  /// **'Explica qué significa este término de forma clara y sencilla'**
  String get dictProposeFieldDefinitionHint;

  /// No description provided for @dictProposeErrorDefinitionEmpty.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce la definición'**
  String get dictProposeErrorDefinitionEmpty;

  /// No description provided for @dictProposeErrorDefinitionLength.
  ///
  /// In es, this message translates to:
  /// **'La definición debe tener al menos 10 caracteres'**
  String get dictProposeErrorDefinitionLength;

  /// No description provided for @dictProposeFieldExample.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo de uso'**
  String get dictProposeFieldExample;

  /// No description provided for @dictProposeFieldExampleHint.
  ///
  /// In es, this message translates to:
  /// **'Ej: \"Los niños dicen GG al final de cada partida\"'**
  String get dictProposeFieldExampleHint;

  /// No description provided for @dictProposeErrorExampleEmpty.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce un ejemplo de uso'**
  String get dictProposeErrorExampleEmpty;

  /// No description provided for @dictProposeErrorExampleLength.
  ///
  /// In es, this message translates to:
  /// **'El ejemplo debe tener al menos 10 caracteres'**
  String get dictProposeErrorExampleLength;

  /// No description provided for @dictProposeWarningText.
  ///
  /// In es, this message translates to:
  /// **'Tu término será revisado por un moderador antes de aparecer en el diccionario. Esto ayuda a mantener la calidad del contenido.'**
  String get dictProposeWarningText;

  /// No description provided for @dictProposeSendingBtn.
  ///
  /// In es, this message translates to:
  /// **'Enviando...'**
  String get dictProposeSendingBtn;

  /// No description provided for @dictProposeSubmitBtn.
  ///
  /// In es, this message translates to:
  /// **'Proponer término'**
  String get dictProposeSubmitBtn;

  /// No description provided for @dictCategoryJerga.
  ///
  /// In es, this message translates to:
  /// **'Jerga Gamer'**
  String get dictCategoryJerga;

  /// No description provided for @dictCategoryMechanics.
  ///
  /// In es, this message translates to:
  /// **'Mecánicas de Juego'**
  String get dictCategoryMechanics;

  /// No description provided for @dictCategoryPlatforms.
  ///
  /// In es, this message translates to:
  /// **'Plataformas'**
  String get dictCategoryPlatforms;

  /// No description provided for @dictModAccessDeniedTitle.
  ///
  /// In es, this message translates to:
  /// **'Acceso Denegado'**
  String get dictModAccessDeniedTitle;

  /// No description provided for @dictModAccessDeniedMessage.
  ///
  /// In es, this message translates to:
  /// **'No tienes permisos para acceder a esta sección'**
  String get dictModAccessDeniedMessage;

  /// No description provided for @dictModAccessDeniedSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Solo los moderadores pueden revisar términos propuestos'**
  String get dictModAccessDeniedSubtitle;

  /// No description provided for @dictModTitle.
  ///
  /// In es, this message translates to:
  /// **'Panel de Moderación'**
  String get dictModTitle;

  /// No description provided for @dictModRefreshTooltip.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get dictModRefreshTooltip;

  /// No description provided for @dictModLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando términos pendientes...'**
  String get dictModLoading;

  /// No description provided for @dictModAllReviewedTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Todo revisado!'**
  String get dictModAllReviewedTitle;

  /// No description provided for @dictModAllReviewedMessage.
  ///
  /// In es, this message translates to:
  /// **'No hay términos pendientes de revisar'**
  String get dictModAllReviewedMessage;

  /// No description provided for @dictModPendingCount.
  ///
  /// In es, this message translates to:
  /// **'{count} términos pendientes de revisión'**
  String dictModPendingCount(int count);

  /// No description provided for @dictModDefinitionLabel.
  ///
  /// In es, this message translates to:
  /// **'Definición:'**
  String get dictModDefinitionLabel;

  /// No description provided for @dictModExampleLabel.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo de uso:'**
  String get dictModExampleLabel;

  /// No description provided for @dictModProposedOn.
  ///
  /// In es, this message translates to:
  /// **'Propuesto el {date}'**
  String dictModProposedOn(String date);

  /// No description provided for @dictModEditBtn.
  ///
  /// In es, this message translates to:
  /// **'Editar término'**
  String get dictModEditBtn;

  /// No description provided for @dictModSwipeHint.
  ///
  /// In es, this message translates to:
  /// **'Desliza para aprobar o rechazar'**
  String get dictModSwipeHint;

  /// No description provided for @dictModApproveTitle.
  ///
  /// In es, this message translates to:
  /// **'Aprobar término'**
  String get dictModApproveTitle;

  /// No description provided for @dictModApproveConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas aprobar el término \"{term}\"?\n\nSerá visible para todos los usuarios.'**
  String dictModApproveConfirm(String term);

  /// No description provided for @dictModCancelBtn.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get dictModCancelBtn;

  /// No description provided for @dictModApproveBtn.
  ///
  /// In es, this message translates to:
  /// **'Aprobar'**
  String get dictModApproveBtn;

  /// No description provided for @dictModApproveSuccess.
  ///
  /// In es, this message translates to:
  /// **'✓ Término \"{term}\" aprobado correctamente'**
  String dictModApproveSuccess(String term);

  /// No description provided for @dictModApproveError.
  ///
  /// In es, this message translates to:
  /// **'✗ Error al aprobar el término'**
  String get dictModApproveError;

  /// No description provided for @dictModRejectTitle.
  ///
  /// In es, this message translates to:
  /// **'Rechazar término'**
  String get dictModRejectTitle;

  /// No description provided for @dictModRejectReasonTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Por qué rechazas el término \"{term}\"?'**
  String dictModRejectReasonTitle(String term);

  /// No description provided for @dictModRejectHint.
  ///
  /// In es, this message translates to:
  /// **'Escribe el motivo del rechazo...'**
  String get dictModRejectHint;

  /// No description provided for @dictModRejectWarning.
  ///
  /// In es, this message translates to:
  /// **'El usuario verá este motivo en sus términos propuestos'**
  String get dictModRejectWarning;

  /// No description provided for @dictModRejectErrorEmpty.
  ///
  /// In es, this message translates to:
  /// **'Debes indicar un motivo para rechazar'**
  String get dictModRejectErrorEmpty;

  /// No description provided for @dictModRejectBtn.
  ///
  /// In es, this message translates to:
  /// **'Rechazar'**
  String get dictModRejectBtn;

  /// No description provided for @dictModRejectSuccess.
  ///
  /// In es, this message translates to:
  /// **'✓ Término \"{term}\" rechazado'**
  String dictModRejectSuccess(String term);

  /// No description provided for @dictModRejectError.
  ///
  /// In es, this message translates to:
  /// **'✗ Error al rechazar el término'**
  String get dictModRejectError;

  /// No description provided for @dictModEditTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar término'**
  String get dictModEditTitle;

  /// No description provided for @dictModEditFieldTerm.
  ///
  /// In es, this message translates to:
  /// **'Término'**
  String get dictModEditFieldTerm;

  /// No description provided for @dictModEditFieldDef.
  ///
  /// In es, this message translates to:
  /// **'Definición'**
  String get dictModEditFieldDef;

  /// No description provided for @dictModEditFieldEx.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo (opcional)'**
  String get dictModEditFieldEx;

  /// No description provided for @dictModEditFieldCat.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get dictModEditFieldCat;

  /// No description provided for @dictModEditErrorEmpty.
  ///
  /// In es, this message translates to:
  /// **'Término y definición son obligatorios'**
  String get dictModEditErrorEmpty;

  /// No description provided for @dictModEditErrorGeneric.
  ///
  /// In es, this message translates to:
  /// **'No se pudo actualizar el término'**
  String get dictModEditErrorGeneric;

  /// No description provided for @dictModEditSaveBtn.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get dictModEditSaveBtn;

  /// No description provided for @dictModEditSuccess.
  ///
  /// In es, this message translates to:
  /// **'✓ Término actualizado correctamente'**
  String get dictModEditSuccess;

  /// No description provided for @myTermsTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis Términos Propuestos'**
  String get myTermsTitle;

  /// No description provided for @myTermsLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando tus términos...'**
  String get myTermsLoading;

  /// No description provided for @myTermsEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No has propuesto términos aún'**
  String get myTermsEmptyTitle;

  /// No description provided for @myTermsEmptyMessage.
  ///
  /// In es, this message translates to:
  /// **'Contribuye al diccionario proponiendo nuevos términos'**
  String get myTermsEmptyMessage;

  /// No description provided for @myTermsProposedCount.
  ///
  /// In es, this message translates to:
  /// **'Términos propuestos'**
  String get myTermsProposedCount;

  /// No description provided for @myTermsApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobados'**
  String get myTermsApproved;

  /// No description provided for @myTermsPending.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get myTermsPending;

  /// No description provided for @myTermsViewReason.
  ///
  /// In es, this message translates to:
  /// **'Ver motivo'**
  String get myTermsViewReason;

  /// No description provided for @adminAccessDeniedTitle.
  ///
  /// In es, this message translates to:
  /// **'Acceso Denegado'**
  String get adminAccessDeniedTitle;

  /// No description provided for @adminAccessDeniedMessage.
  ///
  /// In es, this message translates to:
  /// **'Solo los administradores pueden acceder'**
  String get adminAccessDeniedMessage;

  /// No description provided for @adminUsersTitle.
  ///
  /// In es, this message translates to:
  /// **'Gestión de Usuarios'**
  String get adminUsersTitle;

  /// No description provided for @adminUsersInfoTooltip.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get adminUsersInfoTooltip;

  /// No description provided for @adminUsersLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando usuarios...'**
  String get adminUsersLoading;

  /// No description provided for @adminUsersError.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar usuarios'**
  String get adminUsersError;

  /// No description provided for @adminUsersEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay usuarios registrados'**
  String get adminUsersEmpty;

  /// No description provided for @adminUsersStatTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get adminUsersStatTotal;

  /// No description provided for @adminUsersStatAdmins.
  ///
  /// In es, this message translates to:
  /// **'Admins'**
  String get adminUsersStatAdmins;

  /// No description provided for @adminUsersStatMods.
  ///
  /// In es, this message translates to:
  /// **'Moderadores'**
  String get adminUsersStatMods;

  /// No description provided for @adminUsersStatUsers.
  ///
  /// In es, this message translates to:
  /// **'Usuarios'**
  String get adminUsersStatUsers;

  /// No description provided for @adminUsersBadgeYou.
  ///
  /// In es, this message translates to:
  /// **'Tú'**
  String get adminUsersBadgeYou;

  /// No description provided for @adminUsersProposedApproved.
  ///
  /// In es, this message translates to:
  /// **'{proposed} propuestos | {approved} aprobados'**
  String adminUsersProposedApproved(Object approved, Object proposed);

  /// No description provided for @adminUsersActionMakeUser.
  ///
  /// In es, this message translates to:
  /// **'Cambiar a Usuario'**
  String get adminUsersActionMakeUser;

  /// No description provided for @adminUsersActionMakeMod.
  ///
  /// In es, this message translates to:
  /// **'Cambiar a Moderador'**
  String get adminUsersActionMakeMod;

  /// No description provided for @adminUsersActionMakeAdmin.
  ///
  /// In es, this message translates to:
  /// **'Cambiar a Admin'**
  String get adminUsersActionMakeAdmin;

  /// No description provided for @adminRoleAdmin.
  ///
  /// In es, this message translates to:
  /// **'Admin'**
  String get adminRoleAdmin;

  /// No description provided for @adminRoleModerator.
  ///
  /// In es, this message translates to:
  /// **'Moderador'**
  String get adminRoleModerator;

  /// No description provided for @adminRoleUser.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get adminRoleUser;

  /// No description provided for @adminChangeRoleTitle.
  ///
  /// In es, this message translates to:
  /// **'Confirmar cambio de rol'**
  String get adminChangeRoleTitle;

  /// No description provided for @adminChangeRoleConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas cambiar el rol de \"{user}\" a \"{role}\"?'**
  String adminChangeRoleConfirm(Object role, Object user);

  /// No description provided for @adminCancelBtn.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get adminCancelBtn;

  /// No description provided for @adminConfirmBtn.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get adminConfirmBtn;

  /// No description provided for @adminInfoDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'Gestión de Roles'**
  String get adminInfoDialogTitle;

  /// No description provided for @adminInfoDialogSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Roles disponibles:'**
  String get adminInfoDialogSubtitle;

  /// No description provided for @adminInfoUserDesc.
  ///
  /// In es, this message translates to:
  /// **'Puede consultar el diccionario y proponer términos'**
  String get adminInfoUserDesc;

  /// No description provided for @adminInfoModDesc.
  ///
  /// In es, this message translates to:
  /// **'Puede aprobar o rechazar términos propuestos'**
  String get adminInfoModDesc;

  /// No description provided for @adminInfoAdminDesc.
  ///
  /// In es, this message translates to:
  /// **'Tiene acceso completo, incluida la gestión de usuarios'**
  String get adminInfoAdminDesc;

  /// No description provided for @adminInfoUnderstoodBtn.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get adminInfoUnderstoodBtn;
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
