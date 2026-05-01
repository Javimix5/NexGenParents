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

  @override
  String get searchGamesHint => 'Buscar xogo por nome...';

  @override
  String get searchGamesAdvancedFilters => 'Filtros avanzados';

  @override
  String get searchGamesShowingRecent =>
      'Mostrando os xogos máis recentes do último ano';

  @override
  String get searchGamesFilterFrom => 'Desde';

  @override
  String get searchGamesFilterTo => 'Ata';

  @override
  String get searchGamesFilterGenres => 'xénero(s)';

  @override
  String get searchGamesFilterPlatforms => 'plataforma(s)';

  @override
  String get searchGamesClearAll => 'Limpar todo';

  @override
  String get searchGamesEmptyTitle => 'Non se atoparon xogos';

  @override
  String get searchGamesEmptyMessage =>
      'Tenta axustar os filtros ou busca outro termo';

  @override
  String get filtersTitle => 'Filtros de Busca';

  @override
  String get filtersClear => 'Limpar';

  @override
  String get filtersInfoBanner =>
      'Combina múltiples filtros para atopar o xogo perfecto';

  @override
  String get filtersYearTitle => 'Ano de lanzamento';

  @override
  String get filtersYearSubtitle => 'Filtra xogos polo seu ano de saída';

  @override
  String get filtersYearFrom => 'Desde';

  @override
  String get filtersYearTo => 'Ata';

  @override
  String get filtersYearAny => 'Calquera';

  @override
  String get filtersPegiTitle => 'Idade recomendada (PEGI)';

  @override
  String get filtersPegiSubtitle =>
      'Selecciona a idade do teu fillo para ver xogos apropiados';

  @override
  String get filtersPlatformTitle => 'Plataforma';

  @override
  String get filtersPlatformSubtitle =>
      'Selecciona en que dispositivos queres que estea dispoñible';

  @override
  String get filtersGenreTitle => 'Xénero de xogo';

  @override
  String get filtersGenreSubtitle => 'Elixe o tipo de xogos que che interesan';

  @override
  String get filtersApplyBtn => 'Aplicar Filtros';

  @override
  String get forumSearchHint => 'Buscar fíos por título...';

  @override
  String get forumEmptySearchTitle => 'Sen resultados';

  @override
  String get forumEmptySearchMessage =>
      'Non se atoparon fíos que coincidan coa túa busca.';

  @override
  String get forumEmptyCategoryTitle => 'Categoría baleira';

  @override
  String get forumEmptyCategoryMessage =>
      'Aínda non hai novidades nesta sección. Anímate e publica algo!';

  @override
  String forumPostSubtitle(String author, int count) {
    return 'por $author • $count respostas';
  }

  @override
  String get forumDeleteTooltip => 'Eliminar';

  @override
  String get forumDeletePostTitle => 'Eliminar publicación';

  @override
  String forumDeletePostContent(String title) {
    return 'Queres eliminar \"$title\" e todas as súas respostas?';
  }

  @override
  String get forumCancelBtn => 'Cancelar';

  @override
  String get forumDeleteBtn => 'Eliminar';

  @override
  String get forumNewPostBtn => 'Novo Fío';

  @override
  String get forumPostDeletedSuccess => 'Publicación eliminada';

  @override
  String get forumPostDeletedError => 'Non se puido eliminar a publicación';

  @override
  String get forumCreateLoginRequired => 'Debes iniciar sesión para publicar';

  @override
  String get forumCreateUnknownError => 'Erro descoñecido';

  @override
  String get forumCreateTitle => 'Crear Novo Fío';

  @override
  String get forumCreateFieldTitle => 'Título';

  @override
  String get forumCreateErrorTitle => 'O título é obrigatorio';

  @override
  String get forumCreateFieldSection => 'Sección';

  @override
  String get forumCreateFieldContent => 'Contido';

  @override
  String get forumCreateErrorContent => 'O contido é obrigatorio';

  @override
  String get forumCreatePublishingBtn => 'Publicando...';

  @override
  String get forumCreatePublishBtn => 'Publicar';

  @override
  String forumPostByAuthor(String author) {
    return 'por $author';
  }

  @override
  String get forumDetailRepliesTitle => 'Respostas';

  @override
  String get forumDetailEmptyReplies => 'Aínda non hai respostas.';

  @override
  String get forumDeleteReplyTooltip => 'Eliminar resposta';

  @override
  String get forumDeleteReplyTitle => 'Eliminar resposta';

  @override
  String get forumDeleteReplyContent => 'Queres eliminar esta resposta?';

  @override
  String get forumReplyDeletedSuccess => 'Resposta eliminada';

  @override
  String get forumReplyDeletedError => 'Non se puido eliminar a resposta';

  @override
  String get forumDetailReplyInputHint => 'Escribe unha resposta...';

  @override
  String get dictDetailTitle => 'Detalle do Termo';

  @override
  String get dictEditTooltip => 'Editar Termo';

  @override
  String get dictDeleteTooltip => 'Eliminar Termo';

  @override
  String get dictLoadingTerm => 'Cargando termo...';

  @override
  String get dictErrorLoadingTerm => 'Non se puido cargar o termo';

  @override
  String get dictBackBtn => 'Volver';

  @override
  String get dictDefinitionLabel => 'Definición';

  @override
  String get dictExampleLabel => 'Exemplo de uso';

  @override
  String get dictUsefulQuestion => 'Fóiche útil este termo?';

  @override
  String get dictVoteThanks => 'Grazas polo teu voto!';

  @override
  String get dictVoteRegistered => 'Voto rexistrado';

  @override
  String get dictVoteBtn => 'Si, axudoume';

  @override
  String get dictUsefulVotes => 'Votos útiles';

  @override
  String get dictViews => 'Visualizacións';

  @override
  String get dictAdditionalInfo => 'Información adicional';

  @override
  String get dictAddedOn => 'Engadido o';

  @override
  String get dictLastUpdate => 'Última actualización';

  @override
  String get dictStatusLabel => 'Estado';

  @override
  String get dictStatusApproved => 'Aprobado';

  @override
  String get dictStatusPending => 'Pendente';

  @override
  String get dictStatusRejected => 'Rexeitado';

  @override
  String get dictEditDialogTitle => 'Editar Termo';

  @override
  String get dictEditFieldTerm => 'Termo';

  @override
  String get dictEditErrorTerm => 'O termo non pode estar baleiro';

  @override
  String get dictEditFieldDefinition => 'Definición';

  @override
  String get dictEditErrorDefinition => 'A definición non pode estar baleira';

  @override
  String get dictEditFieldExample => 'Exemplo (opcional)';

  @override
  String get dictEditFieldCategory => 'Categoría';

  @override
  String get dictCancelBtn => 'Cancelar';

  @override
  String get dictSaveChangesBtn => 'Gardar Cambios';

  @override
  String get dictUpdateSuccess => 'Termo actualizado correctamente';

  @override
  String get dictUpdateError => 'Erro ao actualizar o termo';

  @override
  String get dictDeleteConfirmTitle => 'Confirmar Eliminación';

  @override
  String get dictDeleteConfirmContent =>
      'Estás seguro de que queres eliminar este termo de forma permanente? Esta acción non se pode desfacer.';

  @override
  String get dictDeleteBtn => 'Eliminar';

  @override
  String get dictDeleteSuccess => 'Termo eliminado correctamente';

  @override
  String get dictDeleteError => 'Erro ao eliminar o termo';

  @override
  String get dictListEmptyTitle => 'Non hai termos no dicionario';

  @override
  String get dictListEmptyMessage => 'Sé o primeiro en propoñer un termo';

  @override
  String get dictListProposeBtn => 'Propoñer termo';

  @override
  String get dictProposeErrorAuth => 'Erro: Usuario non autenticado';

  @override
  String get dictProposeSuccessTitle => 'Termo enviado!';

  @override
  String get dictProposeSuccessMessage =>
      'O teu termo foi proposto correctamente e será revisado por un moderador. Notificarémosche cando sexa aprobado.';

  @override
  String get dictProposeUnderstoodBtn => 'Entendido';

  @override
  String get dictProposeErrorGeneric => 'Erro ao propoñer termo';

  @override
  String get dictProposeTitle => 'Propoñer Termo';

  @override
  String get dictProposeHelpText =>
      'Axuda a outros pais engadindo termos que coñezas';

  @override
  String get dictProposeFieldTerm => 'Termo ou palabra';

  @override
  String get dictProposeFieldTermHint => 'Ex: GG, Nerf, Farming';

  @override
  String get dictProposeErrorTermEmpty => 'Por favor, introduce o termo';

  @override
  String get dictProposeErrorTermLength =>
      'O termo debe ter polo menos 2 caracteres';

  @override
  String get dictProposeFieldCategory => 'Categoría';

  @override
  String get dictProposeFieldDefinition => 'Definición';

  @override
  String get dictProposeFieldDefinitionHint =>
      'Explica que significa este termo de forma clara e sinxela';

  @override
  String get dictProposeErrorDefinitionEmpty =>
      'Por favor, introduce a definición';

  @override
  String get dictProposeErrorDefinitionLength =>
      'A definición debe ter polo menos 10 caracteres';

  @override
  String get dictProposeFieldExample => 'Exemplo de uso';

  @override
  String get dictProposeFieldExampleHint =>
      'Ex: \"Os nenos din GG ao final de cada partida\"';

  @override
  String get dictProposeErrorExampleEmpty =>
      'Por favor, introduce un exemplo de uso';

  @override
  String get dictProposeErrorExampleLength =>
      'O exemplo debe ter polo menos 10 caracteres';

  @override
  String get dictProposeWarningText =>
      'O teu termo será revisado por un moderador antes de aparecer no dicionario. Isto axuda a manter a calidade do contido.';

  @override
  String get dictProposeSendingBtn => 'Enviando...';

  @override
  String get dictProposeSubmitBtn => 'Propoñer termo';

  @override
  String get dictCategoryJerga => 'Xerga Gamer';

  @override
  String get dictCategoryMechanics => 'Mecánicas de Xogo';

  @override
  String get dictCategoryPlatforms => 'Plataformas';

  @override
  String get dictModAccessDeniedTitle => 'Acceso Denegado';

  @override
  String get dictModAccessDeniedMessage =>
      'Non tes permisos para acceder a esta sección';

  @override
  String get dictModAccessDeniedSubtitle =>
      'Só os moderadores poden revisar termos propostos';

  @override
  String get dictModTitle => 'Panel de Moderación';

  @override
  String get dictModRefreshTooltip => 'Actualizar';

  @override
  String get dictModLoading => 'Cargando termos pendentes...';

  @override
  String get dictModAllReviewedTitle => 'Todo revisado!';

  @override
  String get dictModAllReviewedMessage => 'Non hai termos pendentes de revisar';

  @override
  String dictModPendingCount(int count) {
    return '$count termos pendentes de revisión';
  }

  @override
  String get dictModDefinitionLabel => 'Definición:';

  @override
  String get dictModExampleLabel => 'Exemplo de uso:';

  @override
  String dictModProposedOn(String date) {
    return 'Proposto o $date';
  }

  @override
  String get dictModEditBtn => 'Editar termo';

  @override
  String get dictModSwipeHint => 'Desliza para aprobar ou rexeitar';

  @override
  String get dictModApproveTitle => 'Aprobar termo';

  @override
  String dictModApproveConfirm(String term) {
    return 'Estás seguro de que desexas aprobar o termo \"$term\"?\n\nSerá visible para todos os usuarios.';
  }

  @override
  String get dictModCancelBtn => 'Cancelar';

  @override
  String get dictModApproveBtn => 'Aprobar';

  @override
  String dictModApproveSuccess(String term) {
    return '✓ Termo \"$term\" aprobado correctamente';
  }

  @override
  String get dictModApproveError => '✗ Erro ao aprobar o termo';

  @override
  String get dictModRejectTitle => 'Rexeitar termo';

  @override
  String dictModRejectReasonTitle(String term) {
    return 'Por que rexeitas o termo \"$term\"?';
  }

  @override
  String get dictModRejectHint => 'Escribe o motivo do rexeitamento...';

  @override
  String get dictModRejectWarning =>
      'O usuario verá este motivo nos seus termos propostos';

  @override
  String get dictModRejectErrorEmpty => 'Debes indicar un motivo para rexeitar';

  @override
  String get dictModRejectBtn => 'Rexeitar';

  @override
  String dictModRejectSuccess(String term) {
    return '✓ Termo \"$term\" rexeitado';
  }

  @override
  String get dictModRejectError => '✗ Erro ao rexeitar o termo';

  @override
  String get dictModEditTitle => 'Editar termo';

  @override
  String get dictModEditFieldTerm => 'Termo';

  @override
  String get dictModEditFieldDef => 'Definición';

  @override
  String get dictModEditFieldEx => 'Exemplo (opcional)';

  @override
  String get dictModEditFieldCat => 'Categoría';

  @override
  String get dictModEditErrorEmpty => 'Termo e definición son obrigatorios';

  @override
  String get dictModEditErrorGeneric => 'Non se puido actualizar o termo';

  @override
  String get dictModEditSaveBtn => 'Gardar cambios';

  @override
  String get dictModEditSuccess => '✓ Termo actualizado correctamente';

  @override
  String get myTermsTitle => 'Os Meus Termos Propostos';

  @override
  String get myTermsLoading => 'Cargando os teus termos...';

  @override
  String get myTermsEmptyTitle => 'Aínda non propuxeches termos';

  @override
  String get myTermsEmptyMessage =>
      'Contribúe ao dicionario propoñendo novos termos';

  @override
  String get myTermsProposedCount => 'Termos propostos';

  @override
  String get myTermsApproved => 'Aprobados';

  @override
  String get myTermsPending => 'Pendentes';

  @override
  String get myTermsViewReason => 'Ver motivo';

  @override
  String get adminAccessDeniedTitle => 'Acceso Denegado';

  @override
  String get adminAccessDeniedMessage => 'Só os administradores poden acceder';

  @override
  String get adminUsersTitle => 'Xestión de Usuarios';

  @override
  String get adminUsersInfoTooltip => 'Información';

  @override
  String get adminUsersLoading => 'Cargando usuarios...';

  @override
  String get adminUsersError => 'Erro ao cargar usuarios';

  @override
  String get adminUsersEmpty => 'Non hai usuarios rexistrados';

  @override
  String get adminUsersStatTotal => 'Total';

  @override
  String get adminUsersStatAdmins => 'Admins';

  @override
  String get adminUsersStatMods => 'Moderadores';

  @override
  String get adminUsersStatUsers => 'Usuarios';

  @override
  String get adminUsersBadgeYou => 'Ti';

  @override
  String adminUsersProposedApproved(Object approved, Object proposed) {
    return '$proposed propostos | $approved aprobados';
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
    return 'Estás seguro de que desexas cambiar o rol de \"$user\" a \"$role\"?';
  }

  @override
  String get adminCancelBtn => 'Cancelar';

  @override
  String get adminConfirmBtn => 'Confirmar';

  @override
  String get adminInfoDialogTitle => 'Xestión de Roles';

  @override
  String get adminInfoDialogSubtitle => 'Roles dispoñibles:';

  @override
  String get adminInfoUserDesc =>
      'Pode consultar o dicionario e propoñer termos';

  @override
  String get adminInfoModDesc => 'Pode aprobar ou rexeitar termos propostos';

  @override
  String get adminInfoAdminDesc =>
      'Ten acceso completo, incluída a xestión de usuarios';

  @override
  String get adminInfoUnderstoodBtn => 'Entendido';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navGuides => 'Guías';

  @override
  String get navDictionary => 'Dicionario';

  @override
  String get navGames => 'Xogos';

  @override
  String get navParentalControl => 'Control Parental';

  @override
  String get navCommunity => 'Comunidade';

  @override
  String get headerSearchHint => 'Buscar...';

  @override
  String get headerMenuBtn => 'Menú';

  @override
  String get accountMenuProfile => 'O meu perfil';

  @override
  String get accountMenuMyTerms => 'Os meus termos propostos';

  @override
  String accountMenuTermsCount(int count) {
    return '$count termos';
  }

  @override
  String get accountMenuModeration => 'Moderación';

  @override
  String get accountMenuUsers => 'Xestión de usuarios';

  @override
  String get accountMenuLogout => 'Pechar sesión';

  @override
  String get footerTaglineMobile =>
      'Empoderando á vindeira xeración\nde pais na era dixital';

  @override
  String get footerPrivacy => 'Política de privacidade';

  @override
  String get footerAbout => 'Quen somos';

  @override
  String get footerContact => 'Contacta connosco';

  @override
  String footerCopyright(String year, String appName) {
    return '© $year $appName. Todos os dereitos reservados.';
  }

  @override
  String get footerTaglineDesktop =>
      'Empoderando á vindeira xeración de pais na era dixital';

  @override
  String get footerErrorLink => 'Non se puido abrir a ligazón externa.';

  @override
  String get genreAction => 'Acción';

  @override
  String get genreAdventure => 'Aventura';

  @override
  String get genreRPG => 'RPG';

  @override
  String get genreStrategy => 'Estratexia';

  @override
  String get genreShooter => 'Shooter';

  @override
  String get genrePuzzle => 'Puzzle';

  @override
  String get genreSports => 'Deportes';

  @override
  String get genreRacing => 'Carreiras';

  @override
  String get genreSimulation => 'Simulación';

  @override
  String get genrePlatformer => 'Plataformas';

  @override
  String get genreFighting => 'Loita';

  @override
  String get genreArcade => 'Arcade';

  @override
  String get gameDetailLoading => 'Cargando información do xogo...';

  @override
  String get gameDetailError => 'Non se puido cargar a información do xogo';

  @override
  String get gameDetailBackBtn => 'Volver';

  @override
  String gameDetailRelease(String date) {
    return 'Lanzamento: $date';
  }

  @override
  String get gameDetailPegiTitle => 'Clasificación por idade (PEGI)';

  @override
  String gameDetailPegiWarning(int pegi) {
    return 'Recomendado para maiores de $pegi anos';
  }

  @override
  String get gameDetailPegiNotAvailable =>
      'Non hai información de clasificación PEGI dispoñible';

  @override
  String get gameDetailDescriptionTitle => 'Descrición do xogo';

  @override
  String get gameDetailDescriptionEmpty => 'Non hai descrición dispoñible';

  @override
  String get gameDetailGenresTitle => 'Xéneros';

  @override
  String get gameDetailPlatformsTitle => 'Plataformas dispoñibles';

  @override
  String get gameDetailScreenshotsTitle => 'Capturas de pantalla';

  @override
  String get pegiDescription3 =>
      'Contido apropiado para todas as idades. Sen violencia nin linguaxe inapropiada.';

  @override
  String get pegiDescription7 =>
      'Pode conter escenas ou sons que asusten a nenos pequenos.';

  @override
  String get pegiDescription12 =>
      'Pode incluír violencia non realista cara a personaxes de fantasía ou violencia realista leve.';

  @override
  String get pegiDescription16 =>
      'Pode conter violencia realista, linguaxe forte ou contido sexual leve.';

  @override
  String get pegiDescription18 =>
      'Contido para adultos. Pode incluír violencia intensa, linguaxe forte, contido sexual explícito ou uso de drogas.';

  @override
  String get pegiDescriptionUnknown =>
      'Non hai unha descrición dispoñible para esta clasificación PEGI.';

  @override
  String get homeDefaultUser => 'Usuario';

  @override
  String homeWelcomeUser(String userName) {
    return 'Benvido, $userName!';
  }

  @override
  String homeUserStats(int approved, int proposed) {
    return 'Tes $approved termos aprobados e $proposed termos propostos.';
  }

  @override
  String homeActiveTerms(int count) {
    return '$count termos activos';
  }

  @override
  String get homeQuickAccessTitle => 'Acceso rápido';

  @override
  String get homeQuickAccessSubtitle => 'Acceso ás zonas da web máis usadas';

  @override
  String get homeQuickActionGamesTitle => 'Buscar xogos por idade';

  @override
  String get homeQuickActionGamesSubtitle =>
      'Busca os xogos axeitados segundo a idade do teu fillo';

  @override
  String get homeQuickActionDictTitle => 'Busca termos no dicionario';

  @override
  String get homeQuickActionDictSubtitle =>
      'Descubre que significan as palabras que usa o teu fillo cando xoga';

  @override
  String get homeQuickActionGuidesTitle => 'Configurar Control Parental';

  @override
  String get homeQuickActionGuidesSubtitle =>
      'Configura os límites de idade e uso segundo a plataforma';

  @override
  String get homeGameOfTheWeek => 'Xogo da semana';

  @override
  String get homeSeeMonthsGames => 'Ver os xogos do mes';

  @override
  String get homeFullAnalysisBtn => 'Análise completo';

  @override
  String get homeLatestUpdatesTitle => 'Últimas actualizacións';

  @override
  String get forumSectionGeneral => 'Xeral';

  @override
  String get forumSectionNews => 'Novas';

  @override
  String get forumSectionQnA => 'Preguntas e respostas';

  @override
  String get homeGoToCommunityBtn => 'Accede á comunidade';

  @override
  String get homeGameSummaryEmpty =>
      'Non hai un xogo destacado esta semana. Consulta os xogos do mes para ver as novidades.';

  @override
  String homeGameSummaryReleased(String date) {
    return 'Saída: $date';
  }

  @override
  String get homeGameSummaryReleasedEmpty => 'Saída: non dispoñible';

  @override
  String homeGameSummaryRating(String rating) {
    return 'Valoración: $rating';
  }

  @override
  String get homeGameSummaryRatingEmpty => 'Valoración: sen datos';

  @override
  String get homeGameSummaryNoGenre => 'Sen xénero';

  @override
  String get homeGameSummaryRatingPending => 'Clasificación pendente';

  @override
  String homeGameSummaryFull(
      String genre, String released, String rating, String ageRating) {
    return 'Xénero: $genre · $released · $rating · $ageRating';
  }

  @override
  String get homeGameTopLabelWeekly => 'Selección semanal';

  @override
  String get homeGameTopLabelUnrated => 'Sen clasificación';

  @override
  String get homeUpdateNoNews => 'Sen novidades recentes nesta sección.';

  @override
  String get homeUpdateThreadUpdated => 'Fío actualizado recentemente';

  @override
  String get homeUpdateCommunity => 'Comunidade';

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
  String get forumSidebarFollowedTopics => 'Temas Seguidos';

  @override
  String get forumSidebarTopic1Title =>
      'Límites de tempo para nenos de 10 anos?';

  @override
  String get forumSidebarTopic1Subtitle => '24 respostas novas hoxe';

  @override
  String get forumSidebarTopic2Title =>
      'Os mellores xogos educativos en Switch';

  @override
  String get forumSidebarTopic2Subtitle => '15 respostas novas hoxe';

  @override
  String get forumSidebarTopic3Title =>
      'Como xestionar a seguridade en chats online';

  @override
  String get forumSidebarTopic3Subtitle => '8 respostas novas hoxe';

  @override
  String get forumSidebarRepliesToYou => 'Respostas para ti';

  @override
  String get forumSidebarReply1Link => 'Seguridade en Fortnite';

  @override
  String get forumSidebarReply1Action => 'respondeu ao teu co...';

  @override
  String get forumSidebarReply1Time => 'hai 2 minutos';

  @override
  String get forumSidebarReply2Link => 'Comparativa de consolas';

  @override
  String get forumSidebarReply2Action => 'etiquetoute en...';

  @override
  String get forumSidebarReply2Time => 'hai 1 hora';

  @override
  String get forumSidebarReply3Link => 'Fío de Benvida';

  @override
  String get forumSidebarReply3Action => 'gustoulle a túa respo...';

  @override
  String get forumSidebarReply3Time => 'hai 3 horas';

  @override
  String get forumSidebarGlobalNews => 'Novas Globais do Foro';

  @override
  String get forumSidebarNews1Tag => 'Actualización';

  @override
  String get forumSidebarNews1Text =>
      'Novas guías de control parental engadidas ao Dicionario.';

  @override
  String get forumSidebarNews2Tag => 'Evento';

  @override
  String get forumSidebarNews2Text =>
      'Q&A en directo con psicólogo infantil este xoves ás 18:00.';

  @override
  String get forumSidebarNews3Tag => 'Novidade';

  @override
  String get forumSidebarNews3Text =>
      'O modo escuro xa está dispoñible nos axustes de usuario!';
}
