import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

class TranslationHelper {
  /// Traduce dinámicamente una clave proveniente de un Provider/Servicio
  static String translateDynamicKey(BuildContext context, String? key, {String? fallback}) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null || key == null) return fallback ?? key ?? 'Error desconocido';

    switch (key) {
      case 'errorTermExists': return l10n.errorTermExists;
      case 'successTermProposed': return l10n.successTermProposed;
      case 'errorProposeTerm': return l10n.errorProposeTerm;
      case 'errorTermNotFound': return l10n.errorTermNotFound;
      case 'successTermApproved': return l10n.successTermApproved;
      case 'errorApproveTerm': return l10n.errorApproveTerm;
      case 'successTermRejected': return l10n.successTermRejected;
      case 'errorRejectTerm': return l10n.errorRejectTerm;
      case 'successTermUpdated': return l10n.successTermUpdated;
      case 'errorUpdateTerm': return l10n.errorUpdateTerm;
      case 'successTermDeleted': return l10n.successTermDeleted;
      case 'errorDeleteTerm': return l10n.errorDeleteTerm;
      case 'errorInvalidRole': return l10n.errorInvalidRole;
      case 'errorModifyOwnRole': return l10n.errorModifyOwnRole;
      case 'successRoleUpdated': return l10n.successRoleUpdated;
      case 'errorUpdateRole': return l10n.errorUpdateRole;
      case 'successBirthYearsUpdated': return l10n.successBirthYearsUpdated;
      case 'errorUpdateBirthYears': return l10n.errorUpdateBirthYears;
      case 'successPlatformsUpdated': return l10n.successPlatformsUpdated;
      case 'errorUpdatePlatforms': return l10n.errorUpdatePlatforms;
      case 'successAvatarUpdated': return l10n.successAvatarUpdated;
      case 'errorUpdateAvatar': return l10n.errorUpdateAvatar;
      case 'successUserInfoUpdated': return l10n.successUserInfoUpdated;
      case 'errorUpdateUserInfo': return l10n.errorUpdateUserInfo;
      case 'successAccountDeleted': return l10n.successAccountDeleted;
      case 'errorDeleteAccount': return l10n.errorDeleteAccount;
      case 'successPostDeleted': return l10n.successPostDeleted;
      case 'errorDeletePost': return l10n.errorDeletePost;
      case 'errorPostNotFound': return l10n.errorPostNotFound;
      case 'successReplyDeleted': return l10n.successReplyDeleted;
      case 'errorDeleteReply': return l10n.errorDeleteReply;
      case 'errorNoAuthUser': return l10n.errorNoAuthUser;
      case 'successPasswordUpdated': return l10n.successPasswordUpdated;
      case 'errorChangePassword': return l10n.errorChangePassword;
      case 'errorWrongCurrentPassword': return l10n.errorWrongCurrentPassword;
      case 'errorWeakNewPassword': return l10n.errorWeakNewPassword;
      case 'successEmailUpdated': return l10n.successEmailUpdated;
      case 'errorChangeEmail': return l10n.errorChangeEmail;
      case 'errorEmailAlreadyInUse': return l10n.errorEmailAlreadyInUse;
      case 'errorInvalidNewEmail': return l10n.errorInvalidNewEmail;
      case 'errorNoPasswordAccount': return l10n.errorNoPasswordAccount;
      case 'successReauth': return l10n.successReauth;
      case 'errorReauth': return l10n.errorReauth;
      default: return fallback ?? key;
    }
  }
}
