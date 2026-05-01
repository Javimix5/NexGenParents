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
  String adminUsersProposedApproved(Object approved, Object proposed) {
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
  String adminChangeRoleConfirm(Object role, Object user) {
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
}
