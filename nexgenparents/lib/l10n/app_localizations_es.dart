// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get privacyPolicyTitle => 'Política de Privacidad';

  @override
  String get privacyPolicySubtitle =>
      'Política de Privacidad de NexGen Parents';

  @override
  String get privacyPolicyLastUpdate => 'Última actualización: Marzo 2026';

  @override
  String get privacyPolicyS1Title => '1. Recopilación de Información';

  @override
  String get privacyPolicyS1Text =>
      'En NexGen Parents nos tomamos muy en serio tu privacidad y la de tu familia. Recopilamos información básica del perfil (como el correo electrónico y tu nombre de usuario) para permitir el acceso a funcionalidades como el diccionario colaborativo y el foro.';

  @override
  String get privacyPolicyS2Title => '2. Uso de los Datos';

  @override
  String get privacyPolicyS2Text =>
      'Los datos proporcionados se utilizan exclusivamente para mejorar tu experiencia en la plataforma, personalizar las recomendaciones por edad (PEGI/ESRB) y mantener un entorno seguro en nuestra comunidad.';

  @override
  String get privacyPolicyS3Title => '3. Protección y Seguridad';

  @override
  String get privacyPolicyS3Text =>
      'Tus datos están protegidos mediante los servicios de Firebase y en ningún caso se venden o comparten con terceros con fines publicitarios no relacionados con el propósito educativo de la plataforma.';

  @override
  String get privacyPolicyS4Title => '4. Tus Derechos';

  @override
  String get privacyPolicyS4Text =>
      'Puedes solicitar en cualquier momento la eliminación total de tu cuenta y tus datos asociados a través del panel de configuración de tu perfil.';

  @override
  String get aboutUsTitle => 'Quiénes somos';

  @override
  String get aboutUsSubtitle => 'Acerca de NexGen Parents';

  @override
  String get aboutUsP1 =>
      'NexGen Parents nace para resolver una brecha informativa real: hoy en día, muchas familias no tienen referencias claras para interpretar el contenido, los riesgos y el gran valor educativo que ofrecen los videojuegos actuales.';

  @override
  String get aboutUsP2 =>
      'Nuestro principal objetivo es reducir la incertidumbre de madres, padres, docentes y orientadores, facilitando decisiones de consumo digital mucho más responsables e informadas.';

  @override
  String get aboutUsVersion => 'Versión 1.0.0 (Marzo 2026)\nProyecto TFC';

  @override
  String get contactUsTitle => 'Contáctanos';

  @override
  String get contactUsSubtitle => '¡Nos encantaría escucharte!';

  @override
  String get contactUsDescription =>
      '¿Tienes alguna duda sobre nuestras guías, quieres proponer una mejora o necesitas ayuda técnica con la aplicación? Ponte en contacto con nosotros.';

  @override
  String get contactUsEmailLabel => 'Correo electrónico';

  @override
  String get contactUsWebLabel => 'Sitio Web';

  @override
  String get contactUsForumHint =>
      'También puedes participar activamente dejando tus dudas en nuestro Foro Comunitario de la app.';

  @override
  String get errorNameLength => 'El nombre debe tener al menos 3 caracteres';

  @override
  String get errorPasswordLength8 =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get errorPasswordUppercase => 'Incluye al menos una letra mayúscula';

  @override
  String get errorPasswordLowercase => 'Incluye al menos una letra minúscula';

  @override
  String get errorPasswordNumber => 'Incluye al menos un número';

  @override
  String get errorConfirmPasswordRequired =>
      'Por favor, confirma tu contraseña';

  @override
  String get errorTermExists => 'Este término ya existe en el diccionario';

  @override
  String get successTermProposed =>
      'Término propuesto correctamente. Será revisado por un moderador';

  @override
  String get errorProposeTerm => 'Error al proponer término';

  @override
  String get errorTermNotFound => 'El término no existe';

  @override
  String get successTermApproved => 'Término aprobado correctamente';

  @override
  String get errorApproveTerm => 'Error al aprobar término';

  @override
  String get successTermRejected => 'Término rechazado';

  @override
  String get errorRejectTerm => 'Error al rechazar término';

  @override
  String get successTermUpdated => 'Término actualizado correctamente';

  @override
  String get errorUpdateTerm => 'Error al actualizar término';

  @override
  String get successTermDeleted => 'Término eliminado correctamente';

  @override
  String get errorDeleteTerm => 'Error al eliminar término';

  @override
  String get errorInvalidRole =>
      'Rol inválido. Debe ser: user, moderator o admin';

  @override
  String get errorModifyOwnRole => 'No puedes modificar tu propio rol';

  @override
  String get successRoleUpdated => 'Rol actualizado correctamente';

  @override
  String get errorUpdateRole => 'Error al actualizar rol';

  @override
  String get successBirthYearsUpdated =>
      'Años de nacimiento actualizados correctamente';

  @override
  String get errorUpdateBirthYears => 'Error al actualizar años de nacimiento';

  @override
  String get successPlatformsUpdated =>
      'Plataformas actualizadas correctamente';

  @override
  String get errorUpdatePlatforms => 'Error al actualizar plataformas';

  @override
  String get successAvatarUpdated => 'Avatar actualizado correctamente';

  @override
  String get errorUpdateAvatar => 'Error al actualizar avatar';

  @override
  String get successUserInfoUpdated =>
      'Información de usuario actualizada correctamente';

  @override
  String get errorUpdateUserInfo => 'Error al actualizar información';

  @override
  String get successAccountDeleted => 'Cuenta eliminada correctamente';

  @override
  String get errorDeleteAccount => 'Error al eliminar cuenta';

  @override
  String get successPostDeleted => 'Publicación eliminada correctamente';

  @override
  String get errorDeletePost => 'Error al eliminar la publicación';

  @override
  String get errorPostNotFound => 'La publicación asociada no existe';

  @override
  String get successReplyDeleted => 'Respuesta eliminada correctamente';

  @override
  String get errorDeleteReply => 'Error al eliminar la respuesta';

  @override
  String get errorNoAuthUser => 'No hay usuario autenticado';

  @override
  String get successPasswordUpdated => 'Contraseña actualizada correctamente';

  @override
  String get errorChangePassword => 'Error al cambiar contraseña';

  @override
  String get errorWrongCurrentPassword => 'La contraseña actual es incorrecta';

  @override
  String get errorWeakNewPassword => 'La nueva contraseña es demasiado débil';

  @override
  String get successEmailUpdated =>
      'Email actualizado correctamente. Verifica tu nuevo correo.';

  @override
  String get errorChangeEmail => 'Error al cambiar email';

  @override
  String get errorEmailAlreadyInUse => 'Este email ya está en uso';

  @override
  String get errorInvalidNewEmail => 'El email no es válido';

  @override
  String get errorNoPasswordAccount =>
      'Tu cuenta no usa contraseña. Inicia sesión de nuevo con tu proveedor para continuar.';

  @override
  String get successReauth => 'Reautenticación correcta';

  @override
  String get errorReauth => 'Error de reautenticación';

  @override
  String get alertLoginRequiredForum =>
      'Debes iniciar sesión para acceder a la comunidad y participar en el foro.';

  @override
  String get alertLoginRequiredProfile =>
      'Debes iniciar sesión para acceder a tu perfil y editar tu información.';

  @override
  String get alertLoginRequiredProposeTerm =>
      'Debes iniciar sesión para proponer un término.';

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
  String get errorLoginGoogle => 'No se pudo iniciar sesión con Google';

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
  String get dictDetailTitle => 'Detalle del Término';

  @override
  String get dictEditTooltip => 'Editar Término';

  @override
  String get dictDeleteTooltip => 'Eliminar Término';

  @override
  String get dictLoadingTerm => 'Cargando término...';

  @override
  String get dictErrorLoadingTerm => 'No se pudo cargar el término';

  @override
  String get dictBackBtn => 'Volver';

  @override
  String get dictDefinitionLabel => 'Definición';

  @override
  String get dictExampleLabel => 'Ejemplo de uso';

  @override
  String get dictUsefulQuestion => '¿Te ha sido útil este término?';

  @override
  String get dictVoteThanks => '¡Gracias por tu voto!';

  @override
  String get dictVoteRegistered => 'Voto registrado';

  @override
  String get dictVoteBtn => 'Sí, me ha ayudado';

  @override
  String get dictUsefulVotes => 'Votos útiles';

  @override
  String get dictViews => 'Visualizaciones';

  @override
  String get dictAdditionalInfo => 'Información adicional';

  @override
  String get dictAddedOn => 'Añadido el';

  @override
  String get dictLastUpdate => 'Última actualización';

  @override
  String get dictStatusLabel => 'Estado';

  @override
  String get dictStatusApproved => 'Aprobado';

  @override
  String get dictStatusPending => 'Pendiente';

  @override
  String get dictStatusRejected => 'Rechazado';

  @override
  String get dictEditDialogTitle => 'Editar Término';

  @override
  String get dictEditFieldTerm => 'Término';

  @override
  String get dictEditErrorTerm => 'El término no puede estar vacío';

  @override
  String get dictEditFieldDefinition => 'Definición';

  @override
  String get dictEditErrorDefinition => 'La definición no puede estar vacía';

  @override
  String get dictEditFieldExample => 'Ejemplo (opcional)';

  @override
  String get dictEditFieldCategory => 'Categoría';

  @override
  String get dictCancelBtn => 'Cancelar';

  @override
  String get dictSaveChangesBtn => 'Guardar Cambios';

  @override
  String get dictUpdateSuccess => 'Término actualizado correctamente';

  @override
  String get dictUpdateError => 'Error al actualizar el término';

  @override
  String get dictDeleteConfirmTitle => 'Confirmar Eliminación';

  @override
  String get dictDeleteConfirmContent =>
      '¿Estás seguro de que quieres eliminar este término de forma permanente? Esta acción no se puede deshacer.';

  @override
  String get dictDeleteBtn => 'Eliminar';

  @override
  String get dictDeleteSuccess => 'Término eliminado correctamente';

  @override
  String get dictDeleteError => 'Error al eliminar el término';

  @override
  String get dictListEmptyTitle => 'No hay términos en el diccionario';

  @override
  String get dictListEmptyMessage => 'Sé el primero en proponer un término';

  @override
  String get dictListProposeBtn => 'Proponer término';

  @override
  String get dictProposeErrorAuth => 'Error: Usuario no autenticado';

  @override
  String get dictProposeSuccessTitle => '¡Término enviado!';

  @override
  String get dictProposeSuccessMessage =>
      'Tu término ha sido propuesto correctamente y será revisado por un moderador. Te notificaremos cuando sea aprobado.';

  @override
  String get dictProposeUnderstoodBtn => 'Entendido';

  @override
  String get dictProposeErrorGeneric => 'Error al proponer término';

  @override
  String get dictProposeTitle => 'Proponer Término';

  @override
  String get dictProposeHelpText =>
      'Ayuda a otros padres añadiendo términos que conozcas';

  @override
  String get dictProposeFieldTerm => 'Término o palabra';

  @override
  String get dictProposeFieldTermHint => 'Ej: GG, Nerf, Farming';

  @override
  String get dictProposeErrorTermEmpty => 'Por favor, introduce el término';

  @override
  String get dictProposeErrorTermLength =>
      'El término debe tener al menos 2 caracteres';

  @override
  String get dictProposeFieldCategory => 'Categoría';

  @override
  String get dictProposeFieldDefinition => 'Definición';

  @override
  String get dictProposeFieldDefinitionHint =>
      'Explica qué significa este término de forma clara y sencilla';

  @override
  String get dictProposeErrorDefinitionEmpty =>
      'Por favor, introduce la definición';

  @override
  String get dictProposeErrorDefinitionLength =>
      'La definición debe tener al menos 10 caracteres';

  @override
  String get dictProposeFieldExample => 'Ejemplo de uso';

  @override
  String get dictProposeFieldExampleHint =>
      'Ej: \"Los niños dicen GG al final de cada partida\"';

  @override
  String get dictProposeErrorExampleEmpty =>
      'Por favor, introduce un ejemplo de uso';

  @override
  String get dictProposeErrorExampleLength =>
      'El ejemplo debe tener al menos 10 caracteres';

  @override
  String get dictProposeWarningText =>
      'Tu término será revisado por un moderador antes de aparecer en el diccionario. Esto ayuda a mantener la calidad del contenido.';

  @override
  String get dictProposeSendingBtn => 'Enviando...';

  @override
  String get dictProposeSubmitBtn => 'Proponer término';

  @override
  String get dictCategoryJerga => 'Jerga Gamer';

  @override
  String get dictCategoryMechanics => 'Mecánicas de Juego';

  @override
  String get dictCategoryPlatforms => 'Plataformas';

  @override
  String get dictModAccessDeniedTitle => 'Acceso Denegado';

  @override
  String get dictModAccessDeniedMessage =>
      'No tienes permisos para acceder a esta sección';

  @override
  String get dictModAccessDeniedSubtitle =>
      'Solo los moderadores pueden revisar términos propuestos';

  @override
  String get dictModTitle => 'Panel de Moderación';

  @override
  String get dictModRefreshTooltip => 'Actualizar';

  @override
  String get dictModLoading => 'Cargando términos pendientes...';

  @override
  String get dictModAllReviewedTitle => '¡Todo revisado!';

  @override
  String get dictModAllReviewedMessage =>
      'No hay términos pendientes de revisar';

  @override
  String dictModPendingCount(int count) {
    return '$count términos pendientes de revisión';
  }

  @override
  String get dictModDefinitionLabel => 'Definición:';

  @override
  String get dictModExampleLabel => 'Ejemplo de uso:';

  @override
  String dictModProposedOn(String date) {
    return 'Propuesto el $date';
  }

  @override
  String get dictModEditBtn => 'Editar término';

  @override
  String get dictModSwipeHint => 'Desliza para aprobar o rechazar';

  @override
  String get dictModApproveTitle => 'Aprobar término';

  @override
  String dictModApproveConfirm(String term) {
    return '¿Estás seguro de que deseas aprobar el término \"$term\"?\n\nSerá visible para todos los usuarios.';
  }

  @override
  String get dictModCancelBtn => 'Cancelar';

  @override
  String get dictModApproveBtn => 'Aprobar';

  @override
  String dictModApproveSuccess(String term) {
    return '✓ Término \"$term\" aprobado correctamente';
  }

  @override
  String get dictModApproveError => '✗ Error al aprobar el término';

  @override
  String get dictModRejectTitle => 'Rechazar término';

  @override
  String dictModRejectReasonTitle(String term) {
    return '¿Por qué rechazas el término \"$term\"?';
  }

  @override
  String get dictModRejectHint => 'Escribe el motivo del rechazo...';

  @override
  String get dictModRejectWarning =>
      'El usuario verá este motivo en sus términos propuestos';

  @override
  String get dictModRejectErrorEmpty => 'Debes indicar un motivo para rechazar';

  @override
  String get dictModRejectBtn => 'Rechazar';

  @override
  String dictModRejectSuccess(String term) {
    return '✓ Término \"$term\" rechazado';
  }

  @override
  String get dictModRejectError => '✗ Error al rechazar el término';

  @override
  String get dictModEditTitle => 'Editar término';

  @override
  String get dictModEditFieldTerm => 'Término';

  @override
  String get dictModEditFieldDef => 'Definición';

  @override
  String get dictModEditFieldEx => 'Ejemplo (opcional)';

  @override
  String get dictModEditFieldCat => 'Categoría';

  @override
  String get dictModEditErrorEmpty => 'Término y definición son obligatorios';

  @override
  String get dictModEditErrorGeneric => 'No se pudo actualizar el término';

  @override
  String get dictModEditSaveBtn => 'Guardar cambios';

  @override
  String get dictModEditSuccess => '✓ Término actualizado correctamente';

  @override
  String get myTermsTitle => 'Mis Términos Propuestos';

  @override
  String get myTermsLoading => 'Cargando tus términos...';

  @override
  String get myTermsEmptyTitle => 'No has propuesto términos aún';

  @override
  String get myTermsEmptyMessage =>
      'Contribuye al diccionario proponiendo nuevos términos';

  @override
  String get myTermsProposedCount => 'Términos propuestos';

  @override
  String get myTermsApproved => 'Aprobados';

  @override
  String get myTermsPending => 'Pendientes';

  @override
  String get myTermsViewReason => 'Ver motivo';

  @override
  String get forumSidebarFollowedTopics => 'Temas Seguidos';

  @override
  String get forumSidebarTopic1Title =>
      '¿Límites de tiempo para niños de 10 años?';

  @override
  String get forumSidebarTopic1Subtitle => '24 respuestas nuevas hoy';

  @override
  String get forumSidebarTopic2Title =>
      'Los mejores juegos educativos en Switch';

  @override
  String get forumSidebarTopic2Subtitle => '15 respuestas nuevas hoy';

  @override
  String get forumSidebarTopic3Title =>
      'Cómo gestionar la seguridad en chats online';

  @override
  String get forumSidebarTopic3Subtitle => '8 respuestas nuevas hoy';

  @override
  String get forumSidebarRepliesToYou => 'Respuestas para ti';

  @override
  String get forumSidebarReply1Link => 'Seguridad en Fortnite';

  @override
  String get forumSidebarReply1Action => 'respondió a tu co...';

  @override
  String get forumSidebarReply1Time => 'hace 2 minutos';

  @override
  String get forumSidebarReply2Link => 'Comparativa de consolas';

  @override
  String get forumSidebarReply2Action => 'te etiquetó en...';

  @override
  String get forumSidebarReply2Time => 'hace 1 hora';

  @override
  String get forumSidebarReply3Link => 'Hilo de Bienvenida';

  @override
  String get forumSidebarReply3Action => 'le gustó tu respue...';

  @override
  String get forumSidebarReply3Time => 'hace 3 horas';

  @override
  String get forumSidebarGlobalNews => 'Noticias Globales del Foro';

  @override
  String get forumSidebarNews1Tag => 'Actualización';

  @override
  String get forumSidebarNews1Text =>
      'Nuevas guías de control parental añadidas al Diccionario.';

  @override
  String get forumSidebarNews2Tag => 'Evento';

  @override
  String get forumSidebarNews2Text =>
      'Q&A en vivo con psicólogo infantil este jueves a las 18:00.';

  @override
  String get forumSidebarNews3Tag => 'Novedad';

  @override
  String get forumSidebarNews3Text =>
      '¡El modo oscuro ya está disponible en los ajustes de usuario!';

  @override
  String get forumMainCategoriesTitle => 'Categorías Principales';

  @override
  String get forumViewAllBtn => 'Ver todo';

  @override
  String get forumEmptySectionTitle => 'No hay publicaciones en esta sección';

  @override
  String get forumEmptySectionMessage => 'Todavía no hay novedades aquí.';

  @override
  String get forumPlatformsTitle => 'Plataformas';

  @override
  String get forumSearchHint => 'Buscar hilos por título...';

  @override
  String get forumEmptySearchTitle => 'Sin resultados';

  @override
  String get forumEmptySearchMessage =>
      'No se encontraron hilos que coincidan con tu búsqueda.';

  @override
  String get forumEmptyCategoryTitle => 'Categoría vacía';

  @override
  String get forumEmptyCategoryMessage =>
      'Todavía no hay novedades en esta sección. ¡Anímate y publica algo!';

  @override
  String forumPostSubtitle(String author, int count) {
    return 'por $author • $count respuestas';
  }

  @override
  String get forumDeleteTooltip => 'Eliminar';

  @override
  String get forumDeletePostTitle => 'Eliminar publicación';

  @override
  String forumDeletePostContent(String title) {
    return '¿Quieres eliminar \"$title\" y todas sus respuestas?';
  }

  @override
  String get forumCancelBtn => 'Cancelar';

  @override
  String get forumDeleteBtn => 'Eliminar';

  @override
  String get forumNewPostBtn => 'Nuevo Hilo';

  @override
  String get forumPostDeletedSuccess => 'Publicación eliminada';

  @override
  String get forumPostDeletedError => 'No se pudo eliminar la publicación';

  @override
  String get forumCreateLoginRequired => 'Debes iniciar sesión para publicar';

  @override
  String get forumCreateUnknownError => 'Error desconocido';

  @override
  String get forumCreateTitle => 'Crear Nuevo Hilo';

  @override
  String get forumCreateFieldTitle => 'Título';

  @override
  String get forumCreateErrorTitle => 'El título es obligatorio';

  @override
  String get forumCreateFieldSection => 'Sección';

  @override
  String get forumCreateFieldContent => 'Contenido';

  @override
  String get forumCreateErrorContent => 'El contenido es obligatorio';

  @override
  String get forumCreatePublishingBtn => 'Publicando...';

  @override
  String get forumCreatePublishBtn => 'Publicar';

  @override
  String forumPostByAuthor(String author) {
    return 'por $author';
  }

  @override
  String get forumDetailRepliesTitle => 'Respuestas';

  @override
  String get forumDetailEmptyReplies => 'No hay respuestas todavía.';

  @override
  String get forumDeleteReplyTooltip => 'Eliminar respuesta';

  @override
  String get forumDeleteReplyTitle => 'Eliminar respuesta';

  @override
  String get forumDeleteReplyContent => '¿Quieres eliminar esta respuesta?';

  @override
  String get forumReplyDeletedSuccess => 'Respuesta eliminada';

  @override
  String get forumReplyDeletedError => 'No se pudo eliminar la respuesta';

  @override
  String get forumDetailReplyInputHint => 'Escribe una respuesta...';

  @override
  String parentalGuidesStepProgress(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get parentalGuidesScreenshot => 'Captura de pantalla:';

  @override
  String get parentalGuidesLoadingImage => 'Cargando imagen...';

  @override
  String get parentalGuidesImageNotAvailable => 'Imagen no disponible';

  @override
  String get parentalGuidesSetupComplete =>
      '¡Configuración completada! Ahora tu hijo puede jugar de forma segura con las restricciones configuradas.';

  @override
  String get parentalGuidesPreviousBtn => 'Anterior';

  @override
  String get parentalGuidesNextBtn => 'Siguiente';

  @override
  String get parentalGuidesFinishBtn => 'Finalizar';

  @override
  String get parentalGuidesCompletedTitle => '¡Guía completada!';

  @override
  String get parentalGuidesCompletedDesc =>
      'Has completado todos los pasos de esta guía de control parental.';

  @override
  String get parentalGuidesRepeatBtn => 'Repetir';

  @override
  String parentalGuidesError(String error) {
    return 'Error al cargar guías: $error';
  }

  @override
  String get parentalGuidesEmptyTitle => 'No hay guías disponibles';

  @override
  String get parentalGuidesEmptyMessage => 'Vuelve a intentarlo más tarde.';

  @override
  String parentalGuidesSelectPlatform(int count) {
    return 'Selecciona tu plataforma ($count guías)';
  }

  @override
  String get parentalGuidesBannerTitle => 'Guías de Control Parental';

  @override
  String get parentalGuidesBannerSubtitle =>
      'Aprende a configurar controles de seguridad en las plataformas más populares.';

  @override
  String get parentalGuidesMoreInfoBtn => 'Saber más sobre PEGI/ESRB';

  @override
  String parentalGuidesStepsCount(int count) {
    return '$count pasos';
  }

  @override
  String get parentalGuidesWhyImportant => '¿Por qué es importante?';

  @override
  String get parentalGuidesProtectionTitle => 'Protección infantil';

  @override
  String get parentalGuidesProtectionDesc =>
      'Evita que tus hijos accedan a contenido no apropiado para su edad.';

  @override
  String get parentalGuidesTimeTitle => 'Gestión del tiempo';

  @override
  String get parentalGuidesTimeDesc =>
      'Establece límites de tiempo de juego para mantener un equilibrio saludable.';

  @override
  String get parentalGuidesSpendingTitle => 'Control de gastos';

  @override
  String get parentalGuidesSpendingDesc =>
      'Previene compras no autorizadas dentro de los juegos.';

  @override
  String get esrbDescriptionE => 'Contenido para todos. Equivalente a PEGI 3.';

  @override
  String get esrbDescriptionE10 => 'Para mayores de 10 años. Similar a PEGI 7.';

  @override
  String get esrbDescriptionT => 'Adolescentes. Equivalente a PEGI 12.';

  @override
  String get esrbDescriptionM => 'Mayores de 17 años. Similar a PEGI 16.';

  @override
  String get esrbDescriptionAO => 'Solo adultos. Equivalente a PEGI 18.';

  @override
  String get esrbDescriptionRP =>
      'Clasificación pendiente (juegos en preventa).';

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

  @override
  String get homeDefaultUser => 'Usuario';

  @override
  String homeWelcomeUser(String userName) {
    return 'Bienvenido, $userName!';
  }

  @override
  String homeUserStats(int approved, int proposed) {
    return 'Tienes $approved términos aprobados y $proposed términos propuestos.';
  }

  @override
  String homeActiveTerms(int count) {
    return '$count términos activos';
  }

  @override
  String get homeQuickAccessTitle => 'Acceso rápido';

  @override
  String get homeQuickAccessSubtitle =>
      'Acceso a las zonas de la web más usadas';

  @override
  String get homeQuickActionGamesTitle => 'Buscar juegos por edad';

  @override
  String get homeQuickActionGamesSubtitle =>
      'Busca los juegos adecuados según la edad de tu hijo';

  @override
  String get homeQuickActionDictTitle => 'Busca términos en el diccionario';

  @override
  String get homeQuickActionDictSubtitle =>
      'Descubre qué significan las palabras que usa tu hijo cuando juega';

  @override
  String get homeQuickActionGuidesTitle => 'Configurar Control Parental';

  @override
  String get homeQuickActionGuidesSubtitle =>
      'Configura los límites de edad y uso según la plataforma';

  @override
  String get homeGameOfTheWeek => 'Juego de la semana';

  @override
  String get homeSeeMonthsGames => 'Ver los juegos del mes';

  @override
  String get homeFullAnalysisBtn => 'Análisis completo';

  @override
  String get homeLatestUpdatesTitle => 'Últimas actualizaciones';

  @override
  String get forumSectionGeneral => 'General';

  @override
  String get forumSectionNews => 'Noticias';

  @override
  String get forumSectionQnA => 'Preguntas y respuestas';

  @override
  String get homeGoToCommunityBtn => 'Accede a la comunidad';

  @override
  String get homeGameSummaryEmpty =>
      'No hay juego destacado esta semana. Consulta los juegos del mes para ver las novedades.';

  @override
  String homeGameSummaryReleased(String date) {
    return 'Salida: $date';
  }

  @override
  String get homeGameSummaryReleasedEmpty => 'Salida: no disponible';

  @override
  String homeGameSummaryRating(String rating) {
    return 'Rating: $rating';
  }

  @override
  String get homeGameSummaryRatingEmpty => 'Rating: sin datos';

  @override
  String get homeGameSummaryNoGenre => 'Sin género';

  @override
  String get homeGameSummaryRatingPending => 'Clasificación pendiente';

  @override
  String homeGameSummaryFull(
      String genre, String released, String rating, String ageRating) {
    return 'Género: $genre · $released · $rating · $ageRating';
  }

  @override
  String get homeGameTopLabelWeekly => 'Selección semanal';

  @override
  String get homeGameTopLabelUnrated => 'Sin clasificación';

  @override
  String get homeUpdateNoNews => 'Sin novedades recientes en esta sección.';

  @override
  String get homeUpdateThreadUpdated => 'Hilo actualizado recientemente';

  @override
  String get homeUpdateCommunity => 'Comunidad';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleModerator => 'Moderador';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String userLevel(int level) {
    return 'Nivel $level';
  }

  @override
  String get homeWelcomeGuest => '¡Bienvenido a NexGen Parents!';

  @override
  String get homeGuestDescription =>
      'Tu guía definitiva sobre videojuegos. Descubre clasificaciones por edad, explora nuestro diccionario de términos gaming y aprende a configurar controles parentales.';

  @override
  String get dictRequireLoginDefault =>
      'Debes iniciar sesión para acceder a esta función.';

  @override
  String dictGuestLockMessage(int totalTerms) {
    return 'El diccionario cuenta con $totalTerms términos. Inicia sesión para verlos todos.';
  }

  @override
  String get dictRequireLoginPropose =>
      'Debes iniciar sesión para proponer un nuevo término.';

  @override
  String get footerTaglineMobile =>
      'Empoderando a la próxima generación\nde padres en la era digital';

  @override
  String get footerPrivacy => 'Política de privacidad';

  @override
  String get footerAbout => 'Quienes somos';

  @override
  String get footerContact => 'Contáctanos';

  @override
  String footerCopyright(String year, String appName) {
    return '© $year $appName. Todos los derechos reservados.';
  }

  @override
  String get footerTaglineDesktop =>
      'Empoderando a la próxima generación de padres en la era digital';

  @override
  String get footerErrorLink => 'No se pudo abrir el enlace externo.';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navGuides => 'Guías';

  @override
  String get navDictionary => 'Diccionario';

  @override
  String get navGames => 'Videojuegos';

  @override
  String get navParentalControl => 'Control Parental';

  @override
  String get navCommunity => 'Comunidad';

  @override
  String get headerSearchHint => 'Buscar...';

  @override
  String get headerMenuBtn => 'Menú';

  @override
  String get profileEditTitle => 'Editar Perfil';

  @override
  String get profileNoAuthUser => 'No hay usuario autenticado';

  @override
  String get profilePersonalInfo => 'Información Personal';

  @override
  String get profileUsername => 'Nombre de usuario';

  @override
  String get profileNameRequired => 'Por favor, introduce tu nombre';

  @override
  String get profileEmailRequired => 'Por favor, introduce tu correo';

  @override
  String get profileEmailChangeWarning =>
      'Cambiar el email requiere verificación adicional';

  @override
  String get profileChangePasswordBtn => 'Cambiar contraseña';

  @override
  String get profileChildrenInfo => 'Información de tus Hijos';

  @override
  String get profileChildrenInfoDesc =>
      'Añade los años de nacimiento para personalizar recomendaciones de juegos';

  @override
  String get profilePlatforms => 'Plataformas que Posees';

  @override
  String get profilePlatformsDesc =>
      'Selecciona las consolas y dispositivos que tienes en casa';

  @override
  String get profileSaveChangesBtn => 'Guardar Cambios';

  @override
  String get profileDeleteAccountBtn => 'Eliminar Cuenta';

  @override
  String get profileChangeAvatar => 'Cambiar Avatar';

  @override
  String get profileActivityTitle => 'Tu Actividad en NexGen Parents';

  @override
  String get profileTermsProposed => 'Términos\nPropuestos';

  @override
  String get profileTermsApproved => 'Términos\nAprobados';

  @override
  String get profileLevel => 'Nivel';

  @override
  String get profileYears => 'años';

  @override
  String get profileAddBirthYearBtn => 'Añadir Año de Nacimiento';

  @override
  String get profileSelectAvatarTitle => 'Selecciona tu Avatar';

  @override
  String get profileBirthYearLabel => 'Año de nacimiento';

  @override
  String get profileBirthYearHint => 'Ejemplo: 2015';

  @override
  String get profileBirthYearDesc =>
      'Introduce el año de nacimiento de tu hijo para obtener recomendaciones personalizadas.';

  @override
  String get profileInvalidBirthYear =>
      'Por favor, introduce un año de nacimiento válido';

  @override
  String get profileAddBtn => 'Añadir';

  @override
  String get profileErrorUpdateName => 'No se pudo actualizar el nombre';

  @override
  String get profileErrorUpdateChildren =>
      'No se pudo actualizar la información de hijos';

  @override
  String get profileErrorUpdatePlatforms =>
      'No se pudieron actualizar las plataformas';

  @override
  String get profileErrorUpdateAvatar => 'No se pudo actualizar el avatar';

  @override
  String get profileVerifyEmailTitle => 'Verificación para cambiar email';

  @override
  String get profileVerifyEmailDesc =>
      'Para cambiar tu correo, confirma tu contraseña actual.';

  @override
  String get profileEmailChangeCancelled => 'Cambio de email cancelado';

  @override
  String get profileErrorChangeEmail => 'No se pudo cambiar el email';

  @override
  String get profileUpdateSuccess => 'Perfil actualizado correctamente';

  @override
  String get profileErrorSave => 'Error al guardar perfil:';

  @override
  String get profileCurrentPassword => 'Contraseña actual';

  @override
  String get profileNewPassword => 'Nueva contraseña';

  @override
  String get profileConfirmNewPassword => 'Confirmar nueva contraseña';

  @override
  String get profileErrorEmptyFields => 'Completa todos los campos';

  @override
  String get profileErrorPasswordLength =>
      'La nueva contraseña debe tener al menos 6 caracteres';

  @override
  String get profileErrorPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get profileOperationCompleted => 'Operación completada';

  @override
  String get profileUpdateBtn => 'Actualizar';

  @override
  String get profileConfirmDeleteTitle => 'Confirmar eliminación';

  @override
  String get profileConfirmDeleteDesc =>
      '¿Seguro que quieres eliminar tu perfil? Esta acción es irreversible.';

  @override
  String get profileNoBtn => 'No';

  @override
  String get profileYesDeleteBtn => 'Sí, eliminar';

  @override
  String get profileDeleteAccountTitle => 'Eliminar cuenta';

  @override
  String get profileDeleteAccountDesc =>
      'Esta acción es permanente. Introduce tu contraseña para confirmar.';

  @override
  String get profileErrorPasswordRequired => 'Debes introducir tu contraseña';

  @override
  String get profileErrorValidatePassword => 'No se pudo validar la contraseña';

  @override
  String get profileErrorDeleteFirestore =>
      'No se pudo eliminar el perfil en la base de datos';

  @override
  String get profileErrorDeleteAuth =>
      'Se eliminó el perfil, pero no la cuenta de acceso';

  @override
  String get profileDeleteSuccess => 'Cuenta eliminada correctamente';

  @override
  String get loginSubtitle => 'Guía y Diccionario Game para Padres';

  @override
  String get loginEmailHint => 'ejemplo@correo.com';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Introduce tu contraseña';

  @override
  String get loginForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginBtn => 'Iniciar sesión';

  @override
  String get loginGoogleBtn => 'Continuar con Google';

  @override
  String get loginOr => 'o';

  @override
  String get loginCreateAccountBtn => 'Crear cuenta nueva';

  @override
  String get loginRecoveryTitle => 'Recuperar contraseña';

  @override
  String get loginRecoveryDesc =>
      'Introduce tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.';

  @override
  String get loginRecoverySendBtn => 'Enviar';

  @override
  String get loginRecoveryError => 'Error al enviar correo';

  @override
  String get registerError => 'Error al registrarse';

  @override
  String get registerErrorGoogle => 'No se pudo registrar con Google';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerHeader => 'Registro de Padres';

  @override
  String get registerSubtitle =>
      'Crea tu cuenta para acceder a todas las funciones';

  @override
  String get registerNameLabel => 'Nombre completo';

  @override
  String get registerNameHint => 'Tu nombre';

  @override
  String get registerPasswordHint => 'Mínimo 8 caracteres';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerConfirmPasswordHint => 'Repite la contraseña';

  @override
  String get registerInfoDesc =>
      'Tu información será utilizada únicamente para mejorar tu experiencia en la app';

  @override
  String get registerGoogleBtn => 'Registrarse con Google';

  @override
  String get registerAlreadyHaveAccount => '¿Ya tienes cuenta? ';

  @override
  String get registerLoginBtn => 'Inicia sesión';

  @override
  String get registerSuccess =>
      'Usuario registrado correctamente. Por favor, inicia sesión';

  @override
  String get adminAccessDeniedTitle => 'Acceso Denegado';

  @override
  String get adminAccessDeniedMessage =>
      'Solo los administradores pueden acceder';

  @override
  String get adminUsersTitle => 'Gestión de Usuarios';

  @override
  String get adminUsersInfoTooltip => 'Información';

  @override
  String get adminUsersLoading => 'Cargando usuarios...';

  @override
  String get adminUsersError => 'Error al cargar usuarios';

  @override
  String get adminUsersEmpty => 'No hay usuarios registrados';

  @override
  String get adminUsersStatTotal => 'Total';

  @override
  String get adminUsersStatAdmins => 'Admins';

  @override
  String get adminUsersStatMods => 'Moderadores';

  @override
  String get adminUsersStatUsers => 'Usuarios';

  @override
  String get adminUsersBadgeYou => 'Tú';

  @override
  String adminUsersProposedApproved(int proposed, int approved) {
    return '$proposed propuestos | $approved aprobados';
  }

  @override
  String get adminUsersActionMakeUser => 'Cambiar a Usuario';

  @override
  String get adminUsersActionMakeMod => 'Cambiar a Moderador';

  @override
  String get adminUsersActionMakeAdmin => 'Cambiar a Admin';

  @override
  String get adminRoleAdmin => 'Admin';

  @override
  String get adminRoleModerator => 'Moderador';

  @override
  String get adminRoleUser => 'Usuario';

  @override
  String get adminChangeRoleTitle => 'Confirmar cambio de rol';

  @override
  String adminChangeRoleConfirm(String user, String role) {
    return '¿Estás seguro de que deseas cambiar el rol de \"$user\" a \"$role\"?';
  }

  @override
  String get adminCancelBtn => 'Cancelar';

  @override
  String get adminConfirmBtn => 'Confirmar';

  @override
  String get adminInfoDialogTitle => 'Gestión de Roles';

  @override
  String get adminInfoDialogSubtitle => 'Roles disponibles:';

  @override
  String get adminInfoUserDesc =>
      'Puede consultar el diccionario y proponer términos';

  @override
  String get adminInfoModDesc => 'Puede aprobar o rechazar términos propuestos';

  @override
  String get adminInfoAdminDesc =>
      'Tiene acceso completo, incluida la gestión de usuarios';

  @override
  String get adminInfoUnderstoodBtn => 'Entendido';

  @override
  String get accountMenuProfile => 'Mi perfil';

  @override
  String get accountMenuMyTerms => 'Mis términos propuestos';

  @override
  String accountMenuTermsCount(int count) {
    return '$count términos';
  }

  @override
  String get accountMenuModeration => 'Moderación';

  @override
  String get accountMenuUsers => 'Gestión de usuarios';

  @override
  String get accountMenuLogout => 'Cerrar sesión';

  @override
  String get genreAction => 'Acción';

  @override
  String get genreAdventure => 'Aventura';

  @override
  String get genreRPG => 'RPG';

  @override
  String get genreStrategy => 'Estrategia';

  @override
  String get genreShooter => 'Shooter';

  @override
  String get genrePuzzle => 'Puzzle';

  @override
  String get genreSports => 'Deportes';

  @override
  String get genreRacing => 'Carreras';

  @override
  String get genreSimulation => 'Simulación';

  @override
  String get genrePlatformer => 'Plataformas';

  @override
  String get genreFighting => 'Lucha';

  @override
  String get genreArcade => 'Arcade';

  @override
  String get gameDetailLoading => 'Cargando información del juego...';

  @override
  String get gameDetailError => 'No se pudo cargar la información del juego';

  @override
  String get gameDetailBackBtn => 'Volver';

  @override
  String gameDetailRelease(String date) {
    return 'Lanzamiento: $date';
  }

  @override
  String get gameDetailPegiTitle => 'Clasificación por edad (PEGI)';

  @override
  String gameDetailPegiWarning(int pegi) {
    return 'Recomendado para mayores de $pegi años';
  }

  @override
  String get gameDetailPegiNotAvailable =>
      'No hay información de clasificación PEGI disponible';

  @override
  String get gameDetailDescriptionTitle => 'Descripción del juego';

  @override
  String get gameDetailDescriptionEmpty => 'No hay descripción disponible';

  @override
  String get gameDetailGenresTitle => 'Géneros';

  @override
  String get gameDetailPlatformsTitle => 'Plataformas disponibles';

  @override
  String get gameDetailScreenshotsTitle => 'Capturas de pantalla';

  @override
  String get pegiDescription3 =>
      'Contenido apropiado para todas las edades. Sin violencia ni lenguaje inapropiado.';

  @override
  String get pegiDescription7 =>
      'Puede contener escenas o sonidos que asusten a niños pequeños.';

  @override
  String get pegiDescription12 =>
      'Puede incluir violencia no realista hacia personajes de fantasía o violencia realista leve.';

  @override
  String get pegiDescription16 =>
      'Puede contener violencia realista, lenguaje fuerte o contenido sexual leve.';

  @override
  String get pegiDescription18 =>
      'Contenido para adultos. Puede incluir violencia intensa, lenguaje fuerte, contenido sexual explícito o uso de drogas.';

  @override
  String get pegiDescriptionUnknown =>
      'No hay una descripción disponible para esta clasificación PEGI.';

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
  String get searchGamesHint => 'Buscar juego por nombre...';

  @override
  String get searchGamesAdvancedFilters => 'Filtros avanzados';

  @override
  String get searchGamesShowingRecent =>
      'Mostrando los juegos más recientes del último año';

  @override
  String get searchGamesFilterFrom => 'Desde';

  @override
  String get searchGamesFilterTo => 'Hasta';

  @override
  String get searchGamesFilterGenres => 'género(s)';

  @override
  String get searchGamesFilterPlatforms => 'plataforma(s)';

  @override
  String get searchGamesClearAll => 'Limpiar todo';

  @override
  String get searchGamesEmptyTitle => 'No se encontraron juegos';

  @override
  String get searchGamesEmptyMessage =>
      'Intenta ajustar los filtros o busca otro término';

  @override
  String get filtersTitle => 'Filtros de Búsqueda';

  @override
  String get filtersClear => 'Limpiar';

  @override
  String get filtersInfoBanner =>
      'Combina múltiples filtros para encontrar el juego perfecto';

  @override
  String get filtersYearTitle => 'Año de lanzamiento';

  @override
  String get filtersYearSubtitle => 'Filtra juegos por su año de salida';

  @override
  String get filtersYearFrom => 'Desde';

  @override
  String get filtersYearTo => 'Hasta';

  @override
  String get filtersYearAny => 'Cualquiera';

  @override
  String get filtersPegiTitle => 'Edad recomendada (PEGI)';

  @override
  String get filtersPegiSubtitle =>
      'Selecciona la edad de tu hijo para ver juegos apropiados';

  @override
  String get filtersPlatformTitle => 'Plataforma';

  @override
  String get filtersPlatformSubtitle =>
      'Selecciona en qué dispositivos quieres que esté disponible';

  @override
  String get filtersGenreTitle => 'Género de juego';

  @override
  String get filtersGenreSubtitle => 'Elige el tipo de juegos que te interesan';

  @override
  String get filtersApplyBtn => 'Aplicar Filtros';

  @override
  String get appName => 'NexGen Parents';

  @override
  String loading(String appName) {
    return 'Cargando $appName...';
  }
}
