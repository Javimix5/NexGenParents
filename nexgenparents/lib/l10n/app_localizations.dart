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

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In es, this message translates to:
  /// **'Política de Privacidad'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Política de Privacidad de NexGen Parents'**
  String get privacyPolicySubtitle;

  /// No description provided for @privacyPolicyLastUpdate.
  ///
  /// In es, this message translates to:
  /// **'Última actualización: Marzo 2026'**
  String get privacyPolicyLastUpdate;

  /// No description provided for @privacyPolicyS1Title.
  ///
  /// In es, this message translates to:
  /// **'1. Recopilación de Información'**
  String get privacyPolicyS1Title;

  /// No description provided for @privacyPolicyS1Text.
  ///
  /// In es, this message translates to:
  /// **'En NexGen Parents nos tomamos muy en serio tu privacidad y la de tu familia. Recopilamos información básica del perfil (como el correo electrónico y tu nombre de usuario) para permitir el acceso a funcionalidades como el diccionario colaborativo y el foro.'**
  String get privacyPolicyS1Text;

  /// No description provided for @privacyPolicyS2Title.
  ///
  /// In es, this message translates to:
  /// **'2. Uso de los Datos'**
  String get privacyPolicyS2Title;

  /// No description provided for @privacyPolicyS2Text.
  ///
  /// In es, this message translates to:
  /// **'Los datos proporcionados se utilizan exclusivamente para mejorar tu experiencia en la plataforma, personalizar las recomendaciones por edad (PEGI/ESRB) y mantener un entorno seguro en nuestra comunidad.'**
  String get privacyPolicyS2Text;

  /// No description provided for @privacyPolicyS3Title.
  ///
  /// In es, this message translates to:
  /// **'3. Protección y Seguridad'**
  String get privacyPolicyS3Title;

  /// No description provided for @privacyPolicyS3Text.
  ///
  /// In es, this message translates to:
  /// **'Tus datos están protegidos mediante los servicios de Firebase y en ningún caso se venden o comparten con terceros con fines publicitarios no relacionados con el propósito educativo de la plataforma.'**
  String get privacyPolicyS3Text;

  /// No description provided for @privacyPolicyS4Title.
  ///
  /// In es, this message translates to:
  /// **'4. Tus Derechos'**
  String get privacyPolicyS4Title;

  /// No description provided for @privacyPolicyS4Text.
  ///
  /// In es, this message translates to:
  /// **'Puedes solicitar en cualquier momento la eliminación total de tu cuenta y tus datos asociados a través del panel de configuración de tu perfil.'**
  String get privacyPolicyS4Text;

  /// No description provided for @aboutUsTitle.
  ///
  /// In es, this message translates to:
  /// **'Quiénes somos'**
  String get aboutUsTitle;

  /// No description provided for @aboutUsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Acerca de NexGen Parents'**
  String get aboutUsSubtitle;

  /// No description provided for @aboutUsP1.
  ///
  /// In es, this message translates to:
  /// **'NexGen Parents nace para resolver una brecha informativa real: hoy en día, muchas familias no tienen referencias claras para interpretar el contenido, los riesgos y el gran valor educativo que ofrecen los videojuegos actuales.'**
  String get aboutUsP1;

  /// No description provided for @aboutUsP2.
  ///
  /// In es, this message translates to:
  /// **'Nuestro principal objetivo es reducir la incertidumbre de madres, padres, docentes y orientadores, facilitando decisiones de consumo digital mucho más responsables e informadas.'**
  String get aboutUsP2;

  /// No description provided for @aboutUsVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión 1.0.0 (Marzo 2026)\nProyecto TFC'**
  String get aboutUsVersion;

  /// No description provided for @contactUsTitle.
  ///
  /// In es, this message translates to:
  /// **'Contáctanos'**
  String get contactUsTitle;

  /// No description provided for @contactUsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'¡Nos encantaría escucharte!'**
  String get contactUsSubtitle;

  /// No description provided for @contactUsDescription.
  ///
  /// In es, this message translates to:
  /// **'¿Tienes alguna duda sobre nuestras guías, quieres proponer una mejora o necesitas ayuda técnica con la aplicación? Ponte en contacto con nosotros.'**
  String get contactUsDescription;

  /// No description provided for @contactUsEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get contactUsEmailLabel;

  /// No description provided for @contactUsWebLabel.
  ///
  /// In es, this message translates to:
  /// **'Sitio Web'**
  String get contactUsWebLabel;

  /// No description provided for @contactUsForumHint.
  ///
  /// In es, this message translates to:
  /// **'También puedes participar activamente dejando tus dudas en nuestro Foro Comunitario de la app.'**
  String get contactUsForumHint;

  /// No description provided for @errorNameLength.
  ///
  /// In es, this message translates to:
  /// **'El nombre debe tener al menos 3 caracteres'**
  String get errorNameLength;

  /// No description provided for @errorPasswordLength8.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener al menos 8 caracteres'**
  String get errorPasswordLength8;

  /// No description provided for @errorPasswordUppercase.
  ///
  /// In es, this message translates to:
  /// **'Incluye al menos una letra mayúscula'**
  String get errorPasswordUppercase;

  /// No description provided for @errorPasswordLowercase.
  ///
  /// In es, this message translates to:
  /// **'Incluye al menos una letra minúscula'**
  String get errorPasswordLowercase;

  /// No description provided for @errorPasswordNumber.
  ///
  /// In es, this message translates to:
  /// **'Incluye al menos un número'**
  String get errorPasswordNumber;

  /// No description provided for @errorConfirmPasswordRequired.
  ///
  /// In es, this message translates to:
  /// **'Por favor, confirma tu contraseña'**
  String get errorConfirmPasswordRequired;

  /// No description provided for @errorTermExists.
  ///
  /// In es, this message translates to:
  /// **'Este término ya existe en el diccionario'**
  String get errorTermExists;

  /// No description provided for @successTermProposed.
  ///
  /// In es, this message translates to:
  /// **'Término propuesto correctamente. Será revisado por un moderador'**
  String get successTermProposed;

  /// No description provided for @errorProposeTerm.
  ///
  /// In es, this message translates to:
  /// **'Error al proponer término'**
  String get errorProposeTerm;

  /// No description provided for @errorTermNotFound.
  ///
  /// In es, this message translates to:
  /// **'El término no existe'**
  String get errorTermNotFound;

  /// No description provided for @successTermApproved.
  ///
  /// In es, this message translates to:
  /// **'Término aprobado correctamente'**
  String get successTermApproved;

  /// No description provided for @errorApproveTerm.
  ///
  /// In es, this message translates to:
  /// **'Error al aprobar término'**
  String get errorApproveTerm;

  /// No description provided for @successTermRejected.
  ///
  /// In es, this message translates to:
  /// **'Término rechazado'**
  String get successTermRejected;

  /// No description provided for @errorRejectTerm.
  ///
  /// In es, this message translates to:
  /// **'Error al rechazar término'**
  String get errorRejectTerm;

  /// No description provided for @successTermUpdated.
  ///
  /// In es, this message translates to:
  /// **'Término actualizado correctamente'**
  String get successTermUpdated;

  /// No description provided for @errorUpdateTerm.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar término'**
  String get errorUpdateTerm;

  /// No description provided for @successTermDeleted.
  ///
  /// In es, this message translates to:
  /// **'Término eliminado correctamente'**
  String get successTermDeleted;

  /// No description provided for @errorDeleteTerm.
  ///
  /// In es, this message translates to:
  /// **'Error al eliminar término'**
  String get errorDeleteTerm;

  /// No description provided for @errorInvalidRole.
  ///
  /// In es, this message translates to:
  /// **'Rol inválido. Debe ser: user, moderator o admin'**
  String get errorInvalidRole;

  /// No description provided for @errorModifyOwnRole.
  ///
  /// In es, this message translates to:
  /// **'No puedes modificar tu propio rol'**
  String get errorModifyOwnRole;

  /// No description provided for @successRoleUpdated.
  ///
  /// In es, this message translates to:
  /// **'Rol actualizado correctamente'**
  String get successRoleUpdated;

  /// No description provided for @errorUpdateRole.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar rol'**
  String get errorUpdateRole;

  /// No description provided for @successBirthYearsUpdated.
  ///
  /// In es, this message translates to:
  /// **'Años de nacimiento actualizados correctamente'**
  String get successBirthYearsUpdated;

  /// No description provided for @errorUpdateBirthYears.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar años de nacimiento'**
  String get errorUpdateBirthYears;

  /// No description provided for @successPlatformsUpdated.
  ///
  /// In es, this message translates to:
  /// **'Plataformas actualizadas correctamente'**
  String get successPlatformsUpdated;

  /// No description provided for @errorUpdatePlatforms.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar plataformas'**
  String get errorUpdatePlatforms;

  /// No description provided for @successAvatarUpdated.
  ///
  /// In es, this message translates to:
  /// **'Avatar actualizado correctamente'**
  String get successAvatarUpdated;

  /// No description provided for @errorUpdateAvatar.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar avatar'**
  String get errorUpdateAvatar;

  /// No description provided for @successUserInfoUpdated.
  ///
  /// In es, this message translates to:
  /// **'Información de usuario actualizada correctamente'**
  String get successUserInfoUpdated;

  /// No description provided for @errorUpdateUserInfo.
  ///
  /// In es, this message translates to:
  /// **'Error al actualizar información'**
  String get errorUpdateUserInfo;

  /// No description provided for @successAccountDeleted.
  ///
  /// In es, this message translates to:
  /// **'Cuenta eliminada correctamente'**
  String get successAccountDeleted;

  /// No description provided for @errorDeleteAccount.
  ///
  /// In es, this message translates to:
  /// **'Error al eliminar cuenta'**
  String get errorDeleteAccount;

  /// No description provided for @successPostDeleted.
  ///
  /// In es, this message translates to:
  /// **'Publicación eliminada correctamente'**
  String get successPostDeleted;

  /// No description provided for @errorDeletePost.
  ///
  /// In es, this message translates to:
  /// **'Error al eliminar la publicación'**
  String get errorDeletePost;

  /// No description provided for @errorPostNotFound.
  ///
  /// In es, this message translates to:
  /// **'La publicación asociada no existe'**
  String get errorPostNotFound;

  /// No description provided for @successReplyDeleted.
  ///
  /// In es, this message translates to:
  /// **'Respuesta eliminada correctamente'**
  String get successReplyDeleted;

  /// No description provided for @errorDeleteReply.
  ///
  /// In es, this message translates to:
  /// **'Error al eliminar la respuesta'**
  String get errorDeleteReply;

  /// No description provided for @errorNoAuthUser.
  ///
  /// In es, this message translates to:
  /// **'No hay usuario autenticado'**
  String get errorNoAuthUser;

  /// No description provided for @successPasswordUpdated.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actualizada correctamente'**
  String get successPasswordUpdated;

  /// No description provided for @errorChangePassword.
  ///
  /// In es, this message translates to:
  /// **'Error al cambiar contraseña'**
  String get errorChangePassword;

  /// No description provided for @errorWrongCurrentPassword.
  ///
  /// In es, this message translates to:
  /// **'La contraseña actual es incorrecta'**
  String get errorWrongCurrentPassword;

  /// No description provided for @errorWeakNewPassword.
  ///
  /// In es, this message translates to:
  /// **'La nueva contraseña es demasiado débil'**
  String get errorWeakNewPassword;

  /// No description provided for @successEmailUpdated.
  ///
  /// In es, this message translates to:
  /// **'Email actualizado correctamente. Verifica tu nuevo correo.'**
  String get successEmailUpdated;

  /// No description provided for @errorChangeEmail.
  ///
  /// In es, this message translates to:
  /// **'Error al cambiar email'**
  String get errorChangeEmail;

  /// No description provided for @errorEmailAlreadyInUse.
  ///
  /// In es, this message translates to:
  /// **'Este email ya está en uso'**
  String get errorEmailAlreadyInUse;

  /// No description provided for @errorInvalidNewEmail.
  ///
  /// In es, this message translates to:
  /// **'El email no es válido'**
  String get errorInvalidNewEmail;

  /// No description provided for @errorNoPasswordAccount.
  ///
  /// In es, this message translates to:
  /// **'Tu cuenta no usa contraseña. Inicia sesión de nuevo con tu proveedor para continuar.'**
  String get errorNoPasswordAccount;

  /// No description provided for @successReauth.
  ///
  /// In es, this message translates to:
  /// **'Reautenticación correcta'**
  String get successReauth;

  /// No description provided for @errorReauth.
  ///
  /// In es, this message translates to:
  /// **'Error de reautenticación'**
  String get errorReauth;

  /// No description provided for @alertLoginRequiredForum.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para acceder a la comunidad y participar en el foro.'**
  String get alertLoginRequiredForum;

  /// No description provided for @alertLoginRequiredProfile.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para acceder a tu perfil y editar tu información.'**
  String get alertLoginRequiredProfile;

  /// No description provided for @alertLoginRequiredProposeTerm.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para proponer un término.'**
  String get alertLoginRequiredProposeTerm;

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

  /// No description provided for @errorLoginGoogle.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar sesión con Google'**
  String get errorLoginGoogle;

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

  /// No description provided for @forumSidebarFollowedTopics.
  ///
  /// In es, this message translates to:
  /// **'Temas Seguidos'**
  String get forumSidebarFollowedTopics;

  /// No description provided for @forumSidebarTopic1Title.
  ///
  /// In es, this message translates to:
  /// **'¿Límites de tiempo para niños de 10 años?'**
  String get forumSidebarTopic1Title;

  /// No description provided for @forumSidebarTopic1Subtitle.
  ///
  /// In es, this message translates to:
  /// **'24 respuestas nuevas hoy'**
  String get forumSidebarTopic1Subtitle;

  /// No description provided for @forumSidebarTopic2Title.
  ///
  /// In es, this message translates to:
  /// **'Los mejores juegos educativos en Switch'**
  String get forumSidebarTopic2Title;

  /// No description provided for @forumSidebarTopic2Subtitle.
  ///
  /// In es, this message translates to:
  /// **'15 respuestas nuevas hoy'**
  String get forumSidebarTopic2Subtitle;

  /// No description provided for @forumSidebarTopic3Title.
  ///
  /// In es, this message translates to:
  /// **'Cómo gestionar la seguridad en chats online'**
  String get forumSidebarTopic3Title;

  /// No description provided for @forumSidebarTopic3Subtitle.
  ///
  /// In es, this message translates to:
  /// **'8 respuestas nuevas hoy'**
  String get forumSidebarTopic3Subtitle;

  /// No description provided for @forumSidebarRepliesToYou.
  ///
  /// In es, this message translates to:
  /// **'Respuestas para ti'**
  String get forumSidebarRepliesToYou;

  /// No description provided for @forumSidebarReply1Link.
  ///
  /// In es, this message translates to:
  /// **'Seguridad en Fortnite'**
  String get forumSidebarReply1Link;

  /// No description provided for @forumSidebarReply1Action.
  ///
  /// In es, this message translates to:
  /// **'respondió a tu co...'**
  String get forumSidebarReply1Action;

  /// No description provided for @forumSidebarReply1Time.
  ///
  /// In es, this message translates to:
  /// **'hace 2 minutos'**
  String get forumSidebarReply1Time;

  /// No description provided for @forumSidebarReply2Link.
  ///
  /// In es, this message translates to:
  /// **'Comparativa de consolas'**
  String get forumSidebarReply2Link;

  /// No description provided for @forumSidebarReply2Action.
  ///
  /// In es, this message translates to:
  /// **'te etiquetó en...'**
  String get forumSidebarReply2Action;

  /// No description provided for @forumSidebarReply2Time.
  ///
  /// In es, this message translates to:
  /// **'hace 1 hora'**
  String get forumSidebarReply2Time;

  /// No description provided for @forumSidebarReply3Link.
  ///
  /// In es, this message translates to:
  /// **'Hilo de Bienvenida'**
  String get forumSidebarReply3Link;

  /// No description provided for @forumSidebarReply3Action.
  ///
  /// In es, this message translates to:
  /// **'le gustó tu respue...'**
  String get forumSidebarReply3Action;

  /// No description provided for @forumSidebarReply3Time.
  ///
  /// In es, this message translates to:
  /// **'hace 3 horas'**
  String get forumSidebarReply3Time;

  /// No description provided for @forumSidebarGlobalNews.
  ///
  /// In es, this message translates to:
  /// **'Noticias Globales del Foro'**
  String get forumSidebarGlobalNews;

  /// No description provided for @forumSidebarNews1Tag.
  ///
  /// In es, this message translates to:
  /// **'Actualización'**
  String get forumSidebarNews1Tag;

  /// No description provided for @forumSidebarNews1Text.
  ///
  /// In es, this message translates to:
  /// **'Nuevas guías de control parental añadidas al Diccionario.'**
  String get forumSidebarNews1Text;

  /// No description provided for @forumSidebarNews2Tag.
  ///
  /// In es, this message translates to:
  /// **'Evento'**
  String get forumSidebarNews2Tag;

  /// No description provided for @forumSidebarNews2Text.
  ///
  /// In es, this message translates to:
  /// **'Q&A en vivo con psicólogo infantil este jueves a las 18:00.'**
  String get forumSidebarNews2Text;

  /// No description provided for @forumSidebarNews3Tag.
  ///
  /// In es, this message translates to:
  /// **'Novedad'**
  String get forumSidebarNews3Tag;

  /// No description provided for @forumSidebarNews3Text.
  ///
  /// In es, this message translates to:
  /// **'¡El modo oscuro ya está disponible en los ajustes de usuario!'**
  String get forumSidebarNews3Text;

  /// No description provided for @forumMainCategoriesTitle.
  ///
  /// In es, this message translates to:
  /// **'Categorías Principales'**
  String get forumMainCategoriesTitle;

  /// No description provided for @forumViewAllBtn.
  ///
  /// In es, this message translates to:
  /// **'Ver todo'**
  String get forumViewAllBtn;

  /// No description provided for @forumEmptySectionTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay publicaciones en esta sección'**
  String get forumEmptySectionTitle;

  /// No description provided for @forumEmptySectionMessage.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay novedades aquí.'**
  String get forumEmptySectionMessage;

  /// No description provided for @forumPlatformsTitle.
  ///
  /// In es, this message translates to:
  /// **'Plataformas'**
  String get forumPlatformsTitle;

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

  /// No description provided for @parentalGuidesStepProgress.
  ///
  /// In es, this message translates to:
  /// **'Paso {current} de {total}'**
  String parentalGuidesStepProgress(int current, int total);

  /// No description provided for @parentalGuidesScreenshot.
  ///
  /// In es, this message translates to:
  /// **'Captura de pantalla:'**
  String get parentalGuidesScreenshot;

  /// No description provided for @parentalGuidesLoadingImage.
  ///
  /// In es, this message translates to:
  /// **'Cargando imagen...'**
  String get parentalGuidesLoadingImage;

  /// No description provided for @parentalGuidesImageNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'Imagen no disponible'**
  String get parentalGuidesImageNotAvailable;

  /// No description provided for @parentalGuidesSetupComplete.
  ///
  /// In es, this message translates to:
  /// **'¡Configuración completada! Ahora tu hijo puede jugar de forma segura con las restricciones configuradas.'**
  String get parentalGuidesSetupComplete;

  /// No description provided for @parentalGuidesPreviousBtn.
  ///
  /// In es, this message translates to:
  /// **'Anterior'**
  String get parentalGuidesPreviousBtn;

  /// No description provided for @parentalGuidesNextBtn.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get parentalGuidesNextBtn;

  /// No description provided for @parentalGuidesFinishBtn.
  ///
  /// In es, this message translates to:
  /// **'Finalizar'**
  String get parentalGuidesFinishBtn;

  /// No description provided for @parentalGuidesCompletedTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Guía completada!'**
  String get parentalGuidesCompletedTitle;

  /// No description provided for @parentalGuidesCompletedDesc.
  ///
  /// In es, this message translates to:
  /// **'Has completado todos los pasos de esta guía de control parental.'**
  String get parentalGuidesCompletedDesc;

  /// No description provided for @parentalGuidesRepeatBtn.
  ///
  /// In es, this message translates to:
  /// **'Repetir'**
  String get parentalGuidesRepeatBtn;

  /// No description provided for @parentalGuidesError.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar guías: {error}'**
  String parentalGuidesError(String error);

  /// No description provided for @parentalGuidesEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay guías disponibles'**
  String get parentalGuidesEmptyTitle;

  /// No description provided for @parentalGuidesEmptyMessage.
  ///
  /// In es, this message translates to:
  /// **'Vuelve a intentarlo más tarde.'**
  String get parentalGuidesEmptyMessage;

  /// No description provided for @parentalGuidesSelectPlatform.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu plataforma ({count} guías)'**
  String parentalGuidesSelectPlatform(int count);

  /// No description provided for @parentalGuidesBannerTitle.
  ///
  /// In es, this message translates to:
  /// **'Guías de Control Parental'**
  String get parentalGuidesBannerTitle;

  /// No description provided for @parentalGuidesBannerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Aprende a configurar controles de seguridad en las plataformas más populares.'**
  String get parentalGuidesBannerSubtitle;

  /// No description provided for @parentalGuidesMoreInfoBtn.
  ///
  /// In es, this message translates to:
  /// **'Saber más sobre PEGI/ESRB'**
  String get parentalGuidesMoreInfoBtn;

  /// No description provided for @parentalGuidesStepsCount.
  ///
  /// In es, this message translates to:
  /// **'{count} pasos'**
  String parentalGuidesStepsCount(int count);

  /// No description provided for @parentalGuidesWhyImportant.
  ///
  /// In es, this message translates to:
  /// **'¿Por qué es importante?'**
  String get parentalGuidesWhyImportant;

  /// No description provided for @parentalGuidesProtectionTitle.
  ///
  /// In es, this message translates to:
  /// **'Protección infantil'**
  String get parentalGuidesProtectionTitle;

  /// No description provided for @parentalGuidesProtectionDesc.
  ///
  /// In es, this message translates to:
  /// **'Evita que tus hijos accedan a contenido no apropiado para su edad.'**
  String get parentalGuidesProtectionDesc;

  /// No description provided for @parentalGuidesTimeTitle.
  ///
  /// In es, this message translates to:
  /// **'Gestión del tiempo'**
  String get parentalGuidesTimeTitle;

  /// No description provided for @parentalGuidesTimeDesc.
  ///
  /// In es, this message translates to:
  /// **'Establece límites de tiempo de juego para mantener un equilibrio saludable.'**
  String get parentalGuidesTimeDesc;

  /// No description provided for @parentalGuidesSpendingTitle.
  ///
  /// In es, this message translates to:
  /// **'Control de gastos'**
  String get parentalGuidesSpendingTitle;

  /// No description provided for @parentalGuidesSpendingDesc.
  ///
  /// In es, this message translates to:
  /// **'Previene compras no autorizadas dentro de los juegos.'**
  String get parentalGuidesSpendingDesc;

  /// No description provided for @esrbDescriptionE.
  ///
  /// In es, this message translates to:
  /// **'Contenido para todos. Equivalente a PEGI 3.'**
  String get esrbDescriptionE;

  /// No description provided for @esrbDescriptionE10.
  ///
  /// In es, this message translates to:
  /// **'Para mayores de 10 años. Similar a PEGI 7.'**
  String get esrbDescriptionE10;

  /// No description provided for @esrbDescriptionT.
  ///
  /// In es, this message translates to:
  /// **'Adolescentes. Equivalente a PEGI 12.'**
  String get esrbDescriptionT;

  /// No description provided for @esrbDescriptionM.
  ///
  /// In es, this message translates to:
  /// **'Mayores de 17 años. Similar a PEGI 16.'**
  String get esrbDescriptionM;

  /// No description provided for @esrbDescriptionAO.
  ///
  /// In es, this message translates to:
  /// **'Solo adultos. Equivalente a PEGI 18.'**
  String get esrbDescriptionAO;

  /// No description provided for @esrbDescriptionRP.
  ///
  /// In es, this message translates to:
  /// **'Clasificación pendiente (juegos en preventa).'**
  String get esrbDescriptionRP;

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

  /// No description provided for @homeDefaultUser.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get homeDefaultUser;

  /// No description provided for @homeWelcomeUser.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido, {userName}!'**
  String homeWelcomeUser(String userName);

  /// No description provided for @homeUserStats.
  ///
  /// In es, this message translates to:
  /// **'Tienes {approved} términos aprobados y {proposed} términos propuestos.'**
  String homeUserStats(int approved, int proposed);

  /// No description provided for @homeActiveTerms.
  ///
  /// In es, this message translates to:
  /// **'{count} términos activos'**
  String homeActiveTerms(int count);

  /// No description provided for @homeQuickAccessTitle.
  ///
  /// In es, this message translates to:
  /// **'Acceso rápido'**
  String get homeQuickAccessTitle;

  /// No description provided for @homeQuickAccessSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Acceso a las zonas de la web más usadas'**
  String get homeQuickAccessSubtitle;

  /// No description provided for @homeQuickActionGamesTitle.
  ///
  /// In es, this message translates to:
  /// **'Buscar juegos por edad'**
  String get homeQuickActionGamesTitle;

  /// No description provided for @homeQuickActionGamesSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Busca los juegos adecuados según la edad de tu hijo'**
  String get homeQuickActionGamesSubtitle;

  /// No description provided for @homeQuickActionDictTitle.
  ///
  /// In es, this message translates to:
  /// **'Busca términos en el diccionario'**
  String get homeQuickActionDictTitle;

  /// No description provided for @homeQuickActionDictSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Descubre qué significan las palabras que usa tu hijo cuando juega'**
  String get homeQuickActionDictSubtitle;

  /// No description provided for @homeQuickActionGuidesTitle.
  ///
  /// In es, this message translates to:
  /// **'Configurar Control Parental'**
  String get homeQuickActionGuidesTitle;

  /// No description provided for @homeQuickActionGuidesSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Configura los límites de edad y uso según la plataforma'**
  String get homeQuickActionGuidesSubtitle;

  /// No description provided for @homeGameOfTheWeek.
  ///
  /// In es, this message translates to:
  /// **'Juego de la semana'**
  String get homeGameOfTheWeek;

  /// No description provided for @homeSeeMonthsGames.
  ///
  /// In es, this message translates to:
  /// **'Ver los juegos del mes'**
  String get homeSeeMonthsGames;

  /// No description provided for @homeFullAnalysisBtn.
  ///
  /// In es, this message translates to:
  /// **'Análisis completo'**
  String get homeFullAnalysisBtn;

  /// No description provided for @homeLatestUpdatesTitle.
  ///
  /// In es, this message translates to:
  /// **'Últimas actualizaciones'**
  String get homeLatestUpdatesTitle;

  /// No description provided for @forumSectionGeneral.
  ///
  /// In es, this message translates to:
  /// **'General'**
  String get forumSectionGeneral;

  /// No description provided for @forumSectionNews.
  ///
  /// In es, this message translates to:
  /// **'Noticias'**
  String get forumSectionNews;

  /// No description provided for @forumSectionQnA.
  ///
  /// In es, this message translates to:
  /// **'Preguntas y respuestas'**
  String get forumSectionQnA;

  /// No description provided for @homeGoToCommunityBtn.
  ///
  /// In es, this message translates to:
  /// **'Accede a la comunidad'**
  String get homeGoToCommunityBtn;

  /// No description provided for @homeGameSummaryEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay juego destacado esta semana. Consulta los juegos del mes para ver las novedades.'**
  String get homeGameSummaryEmpty;

  /// No description provided for @homeGameSummaryReleased.
  ///
  /// In es, this message translates to:
  /// **'Salida: {date}'**
  String homeGameSummaryReleased(String date);

  /// No description provided for @homeGameSummaryReleasedEmpty.
  ///
  /// In es, this message translates to:
  /// **'Salida: no disponible'**
  String get homeGameSummaryReleasedEmpty;

  /// No description provided for @homeGameSummaryRating.
  ///
  /// In es, this message translates to:
  /// **'Rating: {rating}'**
  String homeGameSummaryRating(String rating);

  /// No description provided for @homeGameSummaryRatingEmpty.
  ///
  /// In es, this message translates to:
  /// **'Rating: sin datos'**
  String get homeGameSummaryRatingEmpty;

  /// No description provided for @homeGameSummaryNoGenre.
  ///
  /// In es, this message translates to:
  /// **'Sin género'**
  String get homeGameSummaryNoGenre;

  /// No description provided for @homeGameSummaryRatingPending.
  ///
  /// In es, this message translates to:
  /// **'Clasificación pendiente'**
  String get homeGameSummaryRatingPending;

  /// No description provided for @homeGameSummaryFull.
  ///
  /// In es, this message translates to:
  /// **'Género: {genre} · {released} · {rating} · {ageRating}'**
  String homeGameSummaryFull(
      String genre, String released, String rating, String ageRating);

  /// No description provided for @homeGameTopLabelWeekly.
  ///
  /// In es, this message translates to:
  /// **'Selección semanal'**
  String get homeGameTopLabelWeekly;

  /// No description provided for @homeGameTopLabelUnrated.
  ///
  /// In es, this message translates to:
  /// **'Sin clasificación'**
  String get homeGameTopLabelUnrated;

  /// No description provided for @homeUpdateNoNews.
  ///
  /// In es, this message translates to:
  /// **'Sin novedades recientes en esta sección.'**
  String get homeUpdateNoNews;

  /// No description provided for @homeUpdateThreadUpdated.
  ///
  /// In es, this message translates to:
  /// **'Hilo actualizado recientemente'**
  String get homeUpdateThreadUpdated;

  /// No description provided for @homeUpdateCommunity.
  ///
  /// In es, this message translates to:
  /// **'Comunidad'**
  String get homeUpdateCommunity;

  /// No description provided for @roleAdmin.
  ///
  /// In es, this message translates to:
  /// **'Administrador'**
  String get roleAdmin;

  /// No description provided for @roleModerator.
  ///
  /// In es, this message translates to:
  /// **'Moderador'**
  String get roleModerator;

  /// No description provided for @commonLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get commonLoading;

  /// No description provided for @userLevel.
  ///
  /// In es, this message translates to:
  /// **'Nivel {level}'**
  String userLevel(int level);

  /// No description provided for @homeWelcomeGuest.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido a NexGen Parents!'**
  String get homeWelcomeGuest;

  /// No description provided for @homeGuestDescription.
  ///
  /// In es, this message translates to:
  /// **'Tu guía definitiva sobre videojuegos. Descubre clasificaciones por edad, explora nuestro diccionario de términos gaming y aprende a configurar controles parentales.'**
  String get homeGuestDescription;

  /// No description provided for @dictRequireLoginDefault.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para acceder a esta función.'**
  String get dictRequireLoginDefault;

  /// No description provided for @dictGuestLockMessage.
  ///
  /// In es, this message translates to:
  /// **'El diccionario cuenta con {totalTerms} términos. Inicia sesión para verlos todos.'**
  String dictGuestLockMessage(int totalTerms);

  /// No description provided for @dictRequireLoginPropose.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para proponer un nuevo término.'**
  String get dictRequireLoginPropose;

  /// No description provided for @footerTaglineMobile.
  ///
  /// In es, this message translates to:
  /// **'Empoderando a la próxima generación\nde padres en la era digital'**
  String get footerTaglineMobile;

  /// No description provided for @footerPrivacy.
  ///
  /// In es, this message translates to:
  /// **'Política de privacidad'**
  String get footerPrivacy;

  /// No description provided for @footerAbout.
  ///
  /// In es, this message translates to:
  /// **'Quienes somos'**
  String get footerAbout;

  /// No description provided for @footerContact.
  ///
  /// In es, this message translates to:
  /// **'Contáctanos'**
  String get footerContact;

  /// No description provided for @footerCopyright.
  ///
  /// In es, this message translates to:
  /// **'© {year} {appName}. Todos los derechos reservados.'**
  String footerCopyright(String year, String appName);

  /// No description provided for @footerTaglineDesktop.
  ///
  /// In es, this message translates to:
  /// **'Empoderando a la próxima generación de padres en la era digital'**
  String get footerTaglineDesktop;

  /// No description provided for @footerErrorLink.
  ///
  /// In es, this message translates to:
  /// **'No se pudo abrir el enlace externo.'**
  String get footerErrorLink;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get navSearch;

  /// No description provided for @navGuides.
  ///
  /// In es, this message translates to:
  /// **'Guías'**
  String get navGuides;

  /// No description provided for @navDictionary.
  ///
  /// In es, this message translates to:
  /// **'Diccionario'**
  String get navDictionary;

  /// No description provided for @navGames.
  ///
  /// In es, this message translates to:
  /// **'Videojuegos'**
  String get navGames;

  /// No description provided for @navParentalControl.
  ///
  /// In es, this message translates to:
  /// **'Control Parental'**
  String get navParentalControl;

  /// No description provided for @navCommunity.
  ///
  /// In es, this message translates to:
  /// **'Comunidad'**
  String get navCommunity;

  /// No description provided for @headerSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar...'**
  String get headerSearchHint;

  /// No description provided for @headerMenuBtn.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get headerMenuBtn;

  /// No description provided for @profileEditTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar Perfil'**
  String get profileEditTitle;

  /// No description provided for @profileNoAuthUser.
  ///
  /// In es, this message translates to:
  /// **'No hay usuario autenticado'**
  String get profileNoAuthUser;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In es, this message translates to:
  /// **'Información Personal'**
  String get profilePersonalInfo;

  /// No description provided for @profileUsername.
  ///
  /// In es, this message translates to:
  /// **'Nombre de usuario'**
  String get profileUsername;

  /// No description provided for @profileNameRequired.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce tu nombre'**
  String get profileNameRequired;

  /// No description provided for @profileEmailRequired.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce tu correo'**
  String get profileEmailRequired;

  /// No description provided for @profileEmailChangeWarning.
  ///
  /// In es, this message translates to:
  /// **'Cambiar el email requiere verificación adicional'**
  String get profileEmailChangeWarning;

  /// No description provided for @profileChangePasswordBtn.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get profileChangePasswordBtn;

  /// No description provided for @profileChildrenInfo.
  ///
  /// In es, this message translates to:
  /// **'Información de tus Hijos'**
  String get profileChildrenInfo;

  /// No description provided for @profileChildrenInfoDesc.
  ///
  /// In es, this message translates to:
  /// **'Añade los años de nacimiento para personalizar recomendaciones de juegos'**
  String get profileChildrenInfoDesc;

  /// No description provided for @profilePlatforms.
  ///
  /// In es, this message translates to:
  /// **'Plataformas que Posees'**
  String get profilePlatforms;

  /// No description provided for @profilePlatformsDesc.
  ///
  /// In es, this message translates to:
  /// **'Selecciona las consolas y dispositivos que tienes en casa'**
  String get profilePlatformsDesc;

  /// No description provided for @profileSaveChangesBtn.
  ///
  /// In es, this message translates to:
  /// **'Guardar Cambios'**
  String get profileSaveChangesBtn;

  /// No description provided for @profileDeleteAccountBtn.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Cuenta'**
  String get profileDeleteAccountBtn;

  /// No description provided for @profileChangeAvatar.
  ///
  /// In es, this message translates to:
  /// **'Cambiar Avatar'**
  String get profileChangeAvatar;

  /// No description provided for @profileActivityTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu Actividad en NexGen Parents'**
  String get profileActivityTitle;

  /// No description provided for @profileTermsProposed.
  ///
  /// In es, this message translates to:
  /// **'Términos\nPropuestos'**
  String get profileTermsProposed;

  /// No description provided for @profileTermsApproved.
  ///
  /// In es, this message translates to:
  /// **'Términos\nAprobados'**
  String get profileTermsApproved;

  /// No description provided for @profileLevel.
  ///
  /// In es, this message translates to:
  /// **'Nivel'**
  String get profileLevel;

  /// No description provided for @profileYears.
  ///
  /// In es, this message translates to:
  /// **'años'**
  String get profileYears;

  /// No description provided for @profileAddBirthYearBtn.
  ///
  /// In es, this message translates to:
  /// **'Añadir Año de Nacimiento'**
  String get profileAddBirthYearBtn;

  /// No description provided for @profileSelectAvatarTitle.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu Avatar'**
  String get profileSelectAvatarTitle;

  /// No description provided for @profileBirthYearLabel.
  ///
  /// In es, this message translates to:
  /// **'Año de nacimiento'**
  String get profileBirthYearLabel;

  /// No description provided for @profileBirthYearHint.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo: 2015'**
  String get profileBirthYearHint;

  /// No description provided for @profileBirthYearDesc.
  ///
  /// In es, this message translates to:
  /// **'Introduce el año de nacimiento de tu hijo para obtener recomendaciones personalizadas.'**
  String get profileBirthYearDesc;

  /// No description provided for @profileInvalidBirthYear.
  ///
  /// In es, this message translates to:
  /// **'Por favor, introduce un año de nacimiento válido'**
  String get profileInvalidBirthYear;

  /// No description provided for @profileAddBtn.
  ///
  /// In es, this message translates to:
  /// **'Añadir'**
  String get profileAddBtn;

  /// No description provided for @profileErrorUpdateName.
  ///
  /// In es, this message translates to:
  /// **'No se pudo actualizar el nombre'**
  String get profileErrorUpdateName;

  /// No description provided for @profileErrorUpdateChildren.
  ///
  /// In es, this message translates to:
  /// **'No se pudo actualizar la información de hijos'**
  String get profileErrorUpdateChildren;

  /// No description provided for @profileErrorUpdatePlatforms.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron actualizar las plataformas'**
  String get profileErrorUpdatePlatforms;

  /// No description provided for @profileErrorUpdateAvatar.
  ///
  /// In es, this message translates to:
  /// **'No se pudo actualizar el avatar'**
  String get profileErrorUpdateAvatar;

  /// No description provided for @profileVerifyEmailTitle.
  ///
  /// In es, this message translates to:
  /// **'Verificación para cambiar email'**
  String get profileVerifyEmailTitle;

  /// No description provided for @profileVerifyEmailDesc.
  ///
  /// In es, this message translates to:
  /// **'Para cambiar tu correo, confirma tu contraseña actual.'**
  String get profileVerifyEmailDesc;

  /// No description provided for @profileEmailChangeCancelled.
  ///
  /// In es, this message translates to:
  /// **'Cambio de email cancelado'**
  String get profileEmailChangeCancelled;

  /// No description provided for @profileErrorChangeEmail.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cambiar el email'**
  String get profileErrorChangeEmail;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado correctamente'**
  String get profileUpdateSuccess;

  /// No description provided for @profileErrorSave.
  ///
  /// In es, this message translates to:
  /// **'Error al guardar perfil:'**
  String get profileErrorSave;

  /// No description provided for @profileCurrentPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actual'**
  String get profileCurrentPassword;

  /// No description provided for @profileNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get profileNewPassword;

  /// No description provided for @profileConfirmNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar nueva contraseña'**
  String get profileConfirmNewPassword;

  /// No description provided for @profileErrorEmptyFields.
  ///
  /// In es, this message translates to:
  /// **'Completa todos los campos'**
  String get profileErrorEmptyFields;

  /// No description provided for @profileErrorPasswordLength.
  ///
  /// In es, this message translates to:
  /// **'La nueva contraseña debe tener al menos 6 caracteres'**
  String get profileErrorPasswordLength;

  /// No description provided for @profileErrorPasswordMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get profileErrorPasswordMismatch;

  /// No description provided for @profileOperationCompleted.
  ///
  /// In es, this message translates to:
  /// **'Operación completada'**
  String get profileOperationCompleted;

  /// No description provided for @profileUpdateBtn.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get profileUpdateBtn;

  /// No description provided for @profileConfirmDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'Confirmar eliminación'**
  String get profileConfirmDeleteTitle;

  /// No description provided for @profileConfirmDeleteDesc.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres eliminar tu perfil? Esta acción es irreversible.'**
  String get profileConfirmDeleteDesc;

  /// No description provided for @profileNoBtn.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get profileNoBtn;

  /// No description provided for @profileYesDeleteBtn.
  ///
  /// In es, this message translates to:
  /// **'Sí, eliminar'**
  String get profileYesDeleteBtn;

  /// No description provided for @profileDeleteAccountTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta'**
  String get profileDeleteAccountTitle;

  /// No description provided for @profileDeleteAccountDesc.
  ///
  /// In es, this message translates to:
  /// **'Esta acción es permanente. Introduce tu contraseña para confirmar.'**
  String get profileDeleteAccountDesc;

  /// No description provided for @profileErrorPasswordRequired.
  ///
  /// In es, this message translates to:
  /// **'Debes introducir tu contraseña'**
  String get profileErrorPasswordRequired;

  /// No description provided for @profileErrorValidatePassword.
  ///
  /// In es, this message translates to:
  /// **'No se pudo validar la contraseña'**
  String get profileErrorValidatePassword;

  /// No description provided for @profileErrorDeleteFirestore.
  ///
  /// In es, this message translates to:
  /// **'No se pudo eliminar el perfil en la base de datos'**
  String get profileErrorDeleteFirestore;

  /// No description provided for @profileErrorDeleteAuth.
  ///
  /// In es, this message translates to:
  /// **'Se eliminó el perfil, pero no la cuenta de acceso'**
  String get profileErrorDeleteAuth;

  /// No description provided for @profileDeleteSuccess.
  ///
  /// In es, this message translates to:
  /// **'Cuenta eliminada correctamente'**
  String get profileDeleteSuccess;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Guía y Diccionario Game para Padres'**
  String get loginSubtitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In es, this message translates to:
  /// **'ejemplo@correo.com'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu contraseña'**
  String get loginPasswordHint;

  /// No description provided for @loginForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get loginForgotPassword;

  /// No description provided for @loginBtn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginBtn;

  /// No description provided for @loginGoogleBtn.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Google'**
  String get loginGoogleBtn;

  /// No description provided for @loginOr.
  ///
  /// In es, this message translates to:
  /// **'o'**
  String get loginOr;

  /// No description provided for @loginCreateAccountBtn.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta nueva'**
  String get loginCreateAccountBtn;

  /// No description provided for @loginRecoveryTitle.
  ///
  /// In es, this message translates to:
  /// **'Recuperar contraseña'**
  String get loginRecoveryTitle;

  /// No description provided for @loginRecoveryDesc.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.'**
  String get loginRecoveryDesc;

  /// No description provided for @loginRecoverySendBtn.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get loginRecoverySendBtn;

  /// No description provided for @loginRecoveryError.
  ///
  /// In es, this message translates to:
  /// **'Error al enviar correo'**
  String get loginRecoveryError;

  /// No description provided for @registerError.
  ///
  /// In es, this message translates to:
  /// **'Error al registrarse'**
  String get registerError;

  /// No description provided for @registerErrorGoogle.
  ///
  /// In es, this message translates to:
  /// **'No se pudo registrar con Google'**
  String get registerErrorGoogle;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get registerTitle;

  /// No description provided for @registerHeader.
  ///
  /// In es, this message translates to:
  /// **'Registro de Padres'**
  String get registerHeader;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta para acceder a todas las funciones'**
  String get registerSubtitle;

  /// No description provided for @registerNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get registerNameLabel;

  /// No description provided for @registerNameHint.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre'**
  String get registerNameHint;

  /// No description provided for @registerPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get registerPasswordHint;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerConfirmPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Repite la contraseña'**
  String get registerConfirmPasswordHint;

  /// No description provided for @registerInfoDesc.
  ///
  /// In es, this message translates to:
  /// **'Tu información será utilizada únicamente para mejorar tu experiencia en la app'**
  String get registerInfoDesc;

  /// No description provided for @registerGoogleBtn.
  ///
  /// In es, this message translates to:
  /// **'Registrarse con Google'**
  String get registerGoogleBtn;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? '**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerLoginBtn.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get registerLoginBtn;

  /// No description provided for @registerSuccess.
  ///
  /// In es, this message translates to:
  /// **'Usuario registrado correctamente. Por favor, inicia sesión'**
  String get registerSuccess;

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
  String adminUsersProposedApproved(int proposed, int approved);

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
  String adminChangeRoleConfirm(String user, String role);

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

  /// No description provided for @accountMenuProfile.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get accountMenuProfile;

  /// No description provided for @accountMenuMyTerms.
  ///
  /// In es, this message translates to:
  /// **'Mis términos propuestos'**
  String get accountMenuMyTerms;

  /// No description provided for @accountMenuTermsCount.
  ///
  /// In es, this message translates to:
  /// **'{count} términos'**
  String accountMenuTermsCount(int count);

  /// No description provided for @accountMenuModeration.
  ///
  /// In es, this message translates to:
  /// **'Moderación'**
  String get accountMenuModeration;

  /// No description provided for @accountMenuUsers.
  ///
  /// In es, this message translates to:
  /// **'Gestión de usuarios'**
  String get accountMenuUsers;

  /// No description provided for @accountMenuLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get accountMenuLogout;

  /// No description provided for @genreAction.
  ///
  /// In es, this message translates to:
  /// **'Acción'**
  String get genreAction;

  /// No description provided for @genreAdventure.
  ///
  /// In es, this message translates to:
  /// **'Aventura'**
  String get genreAdventure;

  /// No description provided for @genreRPG.
  ///
  /// In es, this message translates to:
  /// **'RPG'**
  String get genreRPG;

  /// No description provided for @genreStrategy.
  ///
  /// In es, this message translates to:
  /// **'Estrategia'**
  String get genreStrategy;

  /// No description provided for @genreShooter.
  ///
  /// In es, this message translates to:
  /// **'Shooter'**
  String get genreShooter;

  /// No description provided for @genrePuzzle.
  ///
  /// In es, this message translates to:
  /// **'Puzzle'**
  String get genrePuzzle;

  /// No description provided for @genreSports.
  ///
  /// In es, this message translates to:
  /// **'Deportes'**
  String get genreSports;

  /// No description provided for @genreRacing.
  ///
  /// In es, this message translates to:
  /// **'Carreras'**
  String get genreRacing;

  /// No description provided for @genreSimulation.
  ///
  /// In es, this message translates to:
  /// **'Simulación'**
  String get genreSimulation;

  /// No description provided for @genrePlatformer.
  ///
  /// In es, this message translates to:
  /// **'Plataformas'**
  String get genrePlatformer;

  /// No description provided for @genreFighting.
  ///
  /// In es, this message translates to:
  /// **'Lucha'**
  String get genreFighting;

  /// No description provided for @genreArcade.
  ///
  /// In es, this message translates to:
  /// **'Arcade'**
  String get genreArcade;

  /// No description provided for @gameDetailLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando información del juego...'**
  String get gameDetailLoading;

  /// No description provided for @gameDetailError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar la información del juego'**
  String get gameDetailError;

  /// No description provided for @gameDetailBackBtn.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get gameDetailBackBtn;

  /// No description provided for @gameDetailRelease.
  ///
  /// In es, this message translates to:
  /// **'Lanzamiento: {date}'**
  String gameDetailRelease(String date);

  /// No description provided for @gameDetailPegiTitle.
  ///
  /// In es, this message translates to:
  /// **'Clasificación por edad (PEGI)'**
  String get gameDetailPegiTitle;

  /// No description provided for @gameDetailPegiWarning.
  ///
  /// In es, this message translates to:
  /// **'Recomendado para mayores de {pegi} años'**
  String gameDetailPegiWarning(int pegi);

  /// No description provided for @gameDetailPegiNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay información de clasificación PEGI disponible'**
  String get gameDetailPegiNotAvailable;

  /// No description provided for @gameDetailDescriptionTitle.
  ///
  /// In es, this message translates to:
  /// **'Descripción del juego'**
  String get gameDetailDescriptionTitle;

  /// No description provided for @gameDetailDescriptionEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay descripción disponible'**
  String get gameDetailDescriptionEmpty;

  /// No description provided for @gameDetailGenresTitle.
  ///
  /// In es, this message translates to:
  /// **'Géneros'**
  String get gameDetailGenresTitle;

  /// No description provided for @gameDetailPlatformsTitle.
  ///
  /// In es, this message translates to:
  /// **'Plataformas disponibles'**
  String get gameDetailPlatformsTitle;

  /// No description provided for @gameDetailScreenshotsTitle.
  ///
  /// In es, this message translates to:
  /// **'Capturas de pantalla'**
  String get gameDetailScreenshotsTitle;

  /// No description provided for @pegiDescription3.
  ///
  /// In es, this message translates to:
  /// **'Contenido apropiado para todas las edades. Sin violencia ni lenguaje inapropiado.'**
  String get pegiDescription3;

  /// No description provided for @pegiDescription7.
  ///
  /// In es, this message translates to:
  /// **'Puede contener escenas o sonidos que asusten a niños pequeños.'**
  String get pegiDescription7;

  /// No description provided for @pegiDescription12.
  ///
  /// In es, this message translates to:
  /// **'Puede incluir violencia no realista hacia personajes de fantasía o violencia realista leve.'**
  String get pegiDescription12;

  /// No description provided for @pegiDescription16.
  ///
  /// In es, this message translates to:
  /// **'Puede contener violencia realista, lenguaje fuerte o contenido sexual leve.'**
  String get pegiDescription16;

  /// No description provided for @pegiDescription18.
  ///
  /// In es, this message translates to:
  /// **'Contenido para adultos. Puede incluir violencia intensa, lenguaje fuerte, contenido sexual explícito o uso de drogas.'**
  String get pegiDescription18;

  /// No description provided for @pegiDescriptionUnknown.
  ///
  /// In es, this message translates to:
  /// **'No hay una descripción disponible para esta clasificación PEGI.'**
  String get pegiDescriptionUnknown;

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

  /// Nombre de la aplicación
  ///
  /// In es, this message translates to:
  /// **'NexGen Parents'**
  String get appName;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando {appName}...'**
  String loading(String appName);

  /// No description provided for @forumAccessDeniedTitle.
  ///
  /// In es, this message translates to:
  /// **'Acceso restringido'**
  String get forumAccessDeniedTitle;

  /// No description provided for @forumRequireLoginMessage.
  ///
  /// In es, this message translates to:
  /// **'Debes iniciar sesión para acceder a la comunidad.'**
  String get forumRequireLoginMessage;
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
