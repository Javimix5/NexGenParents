// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NexGen Parents';

  @override
  String loading(String appName) {
    return 'Loading $appName...';
  }

  @override
  String get classificationSystemsTitle => 'Classification Systems';

  @override
  String get pegiInfoSubtitle =>
      'Learn to interpret PEGI and ESRB to choose age-appropriate games.';

  @override
  String get ageRatingsMeaningTitle => 'What do age ratings mean?';

  @override
  String get pegiSystemEuropa => 'PEGI System (Europe)';

  @override
  String get esrbSystemUsa => 'ESRB System (USA)';

  @override
  String get esrbApiNote =>
      'This is the system that usually appears in the video game API we use.';

  @override
  String get pegiContentDescriptorsTitle => 'PEGI Content Descriptors';

  @override
  String get pegiContentDescriptorsSubtitle =>
      'In addition to age, ratings include icons that indicate the type of content:';

  @override
  String get contentDescriptorViolence => 'Violence';

  @override
  String get contentDescriptorFear => 'Fear';

  @override
  String get contentDescriptorOnline => 'Online';

  @override
  String get contentDescriptorDiscrimination => 'Discrimination';

  @override
  String get contentDescriptorDrugs => 'Drugs';

  @override
  String get contentDescriptorSex => 'Sex';

  @override
  String get contentDescriptorBadLanguage => 'Bad Language';

  @override
  String get contentDescriptorGambling => 'Gambling';

  @override
  String get errorInvalidEmail => 'The email is not valid';

  @override
  String get errorWeakPassword =>
      'The password must have at least 8 characters, an uppercase letter, a lowercase letter and a number';

  @override
  String get errorUserNotFound => 'No user exists with this email';

  @override
  String get errorWrongPassword => 'The password is incorrect';

  @override
  String get errorUserDisabled => 'This account has been disabled';

  @override
  String get errorEmailInUse => 'This email is already registered';

  @override
  String get errorEmailInUseRecovery =>
      'This email is already registered. If you only deleted the profile in the database, log in with your previous password to restore it.';

  @override
  String get errorDifferentCredential =>
      'This email is already registered with another login method';

  @override
  String get errorInvalidCredential => 'The credentials are not valid';

  @override
  String get errorPopupClosed =>
      'You closed the Google window before completing the login';

  @override
  String get errorPopupBlocked =>
      'The browser blocked the Google popup window. Try again';

  @override
  String get errorPermissionDenied =>
      'There are no permissions to access the profile in Firestore. Check and deploy firestore.rules.';

  @override
  String errorGeneric(String error) {
    return 'Unexpected error: $error';
  }

  @override
  String get errorCreatingUser => 'Error creating user';

  @override
  String get errorCreatingProfile => 'Failed to create user profile';

  @override
  String get errorLogin => 'Error logging in';

  @override
  String get errorLoadingProfile => 'Failed to load user profile';

  @override
  String get successUserRegistered => 'User registered successfully';

  @override
  String get successLogin => 'Login successful';

  @override
  String get successLoginGoogle => 'Successfully logged in with Google';

  @override
  String get successPasswordReset => 'Recovery email sent. Check your inbox';

  @override
  String get guideTypeEnable => 'Enable Guide';

  @override
  String get guideTypeDisable => 'Disable Guide';

  @override
  String get guideTypeApp => 'App Guide';

  @override
  String get guideTypeTime => 'Time Guide';

  @override
  String get guideTypeDefault => 'Default Guide';

  @override
  String get psEnableGuideTitle => 'How to enable parental guide';

  @override
  String get psEnableGuideDescription =>
      'Follow these steps to enable parental guide on your device.';

  @override
  String get psEnableGuideStep1 => 'Open the settings application.';

  @override
  String get psEnableGuideStep2 => 'Select \'Parental Controls\'.';

  @override
  String get psEnableGuideStep3 => 'Enable the parental guide option.';

  @override
  String get psEnableGuideStep4 =>
      'Configure restrictions according to your needs.';

  @override
  String get psEnableGuideStep5 => 'Save changes.';

  @override
  String get psEnableGuideStep6 => 'Verify that the guide is active.';

  @override
  String get psDisableGuideTitle => 'How to disable parental guide';

  @override
  String get psDisableGuideDescription =>
      'Follow these steps to disable parental guide on your device.';

  @override
  String get psDisableGuideStep1 => 'Open the settings application.';

  @override
  String get psDisableGuideStep2 => 'Select \'Parental Controls\'.';

  @override
  String get psDisableGuideStep3 => 'Disable the parental guide option.';

  @override
  String get psDisableGuideStep4 => 'Save changes.';

  @override
  String get psDisableGuideStep5 => 'Verify that the guide is disabled.';

  @override
  String get nintendoAppGuideStep2 => 'Step 2: Open the Nintendo app.';

  @override
  String get nintendoAppGuideStep3 =>
      'Step 3: Go to the parental controls section.';

  @override
  String get nintendoAppGuideStep4 => 'Step 4: Set up restrictions as needed.';

  @override
  String get nintendoAppGuideStep5 => 'Step 5: Save your settings.';

  @override
  String get nintendoAppGuideStep6 => 'Step 6: Link your account.';

  @override
  String get nintendoAppGuideStep7 => 'Step 7: Confirm the setup.';

  @override
  String get nintendoAppGuideStep8 => 'Step 8: Test the parental controls.';

  @override
  String get steamGuideTitle => 'Steam Parental Guide';

  @override
  String get steamGuideDescription =>
      'Learn how to set up parental controls on Steam.';

  @override
  String get steamGuideStep1 => 'Step 1: Open Steam settings.';

  @override
  String get steamGuideStep2 => 'Step 2: Go to the Family section.';

  @override
  String get steamGuideStep3 => 'Step 3: Enable Family View.';

  @override
  String get steamGuideStep4 => 'Step 4: Set up a PIN.';

  @override
  String get steamGuideStep5 => 'Step 5: Restrict content as needed.';

  @override
  String get iosGuideTitle => 'iOS Parental Guide';

  @override
  String get iosGuideDescription =>
      'Learn how to set up parental controls on iOS devices.';

  @override
  String get iosGuideStep1 => 'Step 1: Open Settings.';

  @override
  String get iosGuideStep2 => 'Step 2: Go to Screen Time.';

  @override
  String get iosGuideStep3 => 'Step 3: Enable restrictions.';

  @override
  String get iosGuideStep4 => 'Step 4: Set up a passcode.';

  @override
  String get xboxGuideTitle => 'Xbox Parental Guide';

  @override
  String get xboxGuideDescription =>
      'Learn how to set up parental controls on Xbox.';

  @override
  String get xboxGuideStep1 => 'Step 1: Open Xbox settings.';

  @override
  String get xboxGuideStep2 => 'Step 2: Go to the Family section.';

  @override
  String get xboxGuideStep3 => 'Step 3: Enable parental controls.';

  @override
  String get xboxGuideStep4 => 'Step 4: Set up restrictions.';

  @override
  String get xboxGuideStep5 => 'Step 5: Save your settings.';

  @override
  String get xboxTimeGuideTitle => 'Xbox Time Guide';

  @override
  String get xboxTimeGuideDescription =>
      'Learn how to set up time limits on Xbox.';

  @override
  String get xboxTimeGuideStep1 => 'Step 1: Open Xbox settings.';

  @override
  String get xboxTimeGuideStep2 => 'Step 2: Go to the Family section.';

  @override
  String get xboxTimeGuideStep3 => 'Step 3: Enable time limits.';

  @override
  String get xboxTimeGuideStep4 => 'Step 4: Set up schedules.';

  @override
  String get xboxTimeGuideStep5 => 'Step 5: Save your settings.';

  @override
  String get nintendoGuideTitle => 'Nintendo Parental Guide';

  @override
  String get nintendoGuideDescription =>
      'Learn how to set up parental controls on Nintendo.';

  @override
  String get nintendoGuideStep1 => 'Step 1: Open Nintendo settings.';

  @override
  String get nintendoGuideStep2 =>
      'Step 2: Go to the parental controls section.';

  @override
  String get nintendoGuideStep3 => 'Step 3: Set up restrictions.';

  @override
  String get nintendoGuideStep4 => 'Step 4: Save your settings.';

  @override
  String get nintendoGuideStep5 => 'Step 5: Test the parental controls.';

  @override
  String get searchGamesHint => 'Search game by name...';

  @override
  String get searchGamesAdvancedFilters => 'Advanced filters';

  @override
  String get searchGamesShowingRecent =>
      'Showing the most recent games from the last year';

  @override
  String get searchGamesFilterFrom => 'From';

  @override
  String get searchGamesFilterTo => 'To';

  @override
  String get searchGamesFilterGenres => 'genre(s)';

  @override
  String get searchGamesFilterPlatforms => 'platform(s)';

  @override
  String get searchGamesClearAll => 'Clear all';

  @override
  String get searchGamesEmptyTitle => 'No games found';

  @override
  String get searchGamesEmptyMessage =>
      'Try adjusting the filters or searching for another term';

  @override
  String get filtersTitle => 'Search Filters';

  @override
  String get filtersClear => 'Clear';

  @override
  String get filtersInfoBanner =>
      'Combine multiple filters to find the perfect game';

  @override
  String get filtersYearTitle => 'Release Year';

  @override
  String get filtersYearSubtitle => 'Filter games by their release year';

  @override
  String get filtersYearFrom => 'From';

  @override
  String get filtersYearTo => 'To';

  @override
  String get filtersYearAny => 'Any';

  @override
  String get filtersPegiTitle => 'Recommended Age (PEGI)';

  @override
  String get filtersPegiSubtitle =>
      'Select your child\'s age to see appropriate games';

  @override
  String get filtersPlatformTitle => 'Platform';

  @override
  String get filtersPlatformSubtitle =>
      'Select which devices you want it to be available on';

  @override
  String get filtersGenreTitle => 'Game Genre';

  @override
  String get filtersGenreSubtitle =>
      'Choose the type of games you are interested in';

  @override
  String get filtersApplyBtn => 'Apply Filters';

  @override
  String get forumSearchHint => 'Search threads by title...';

  @override
  String get forumEmptySearchTitle => 'No results';

  @override
  String get forumEmptySearchMessage =>
      'No threads found matching your search.';

  @override
  String get forumEmptyCategoryTitle => 'Empty category';

  @override
  String get forumEmptyCategoryMessage =>
      'No news in this section yet. Go ahead and post something!';

  @override
  String forumPostSubtitle(String author, int count) {
    return 'by $author • $count replies';
  }

  @override
  String get forumDeleteTooltip => 'Delete';

  @override
  String get forumDeletePostTitle => 'Delete post';

  @override
  String forumDeletePostContent(String title) {
    return 'Do you want to delete \"$title\" and all its replies?';
  }

  @override
  String get forumCancelBtn => 'Cancel';

  @override
  String get forumDeleteBtn => 'Delete';

  @override
  String get forumNewPostBtn => 'New Thread';

  @override
  String get forumPostDeletedSuccess => 'Post deleted';

  @override
  String get forumPostDeletedError => 'Could not delete post';

  @override
  String get forumCreateLoginRequired => 'You must be logged in to post';

  @override
  String get forumCreateUnknownError => 'Unknown error';

  @override
  String get forumCreateTitle => 'Create New Thread';

  @override
  String get forumCreateFieldTitle => 'Title';

  @override
  String get forumCreateErrorTitle => 'Title is required';

  @override
  String get forumCreateFieldSection => 'Section';

  @override
  String get forumCreateFieldContent => 'Content';

  @override
  String get forumCreateErrorContent => 'Content is required';

  @override
  String get forumCreatePublishingBtn => 'Publishing...';

  @override
  String get forumCreatePublishBtn => 'Publish';

  @override
  String forumPostByAuthor(String author) {
    return 'by $author';
  }

  @override
  String get forumDetailRepliesTitle => 'Replies';

  @override
  String get forumDetailEmptyReplies => 'No replies yet.';

  @override
  String get forumDeleteReplyTooltip => 'Delete reply';

  @override
  String get forumDeleteReplyTitle => 'Delete reply';

  @override
  String get forumDeleteReplyContent => 'Do you want to delete this reply?';

  @override
  String get forumReplyDeletedSuccess => 'Reply deleted';

  @override
  String get forumReplyDeletedError => 'Could not delete reply';

  @override
  String get forumDetailReplyInputHint => 'Write a reply...';

  @override
  String get dictDetailTitle => 'Term Detail';

  @override
  String get dictEditTooltip => 'Edit Term';

  @override
  String get dictDeleteTooltip => 'Delete Term';

  @override
  String get dictLoadingTerm => 'Loading term...';

  @override
  String get dictErrorLoadingTerm => 'Could not load the term';

  @override
  String get dictBackBtn => 'Back';

  @override
  String get dictDefinitionLabel => 'Definition';

  @override
  String get dictExampleLabel => 'Example of use';

  @override
  String get dictUsefulQuestion => 'Was this term helpful?';

  @override
  String get dictVoteThanks => 'Thanks for your vote!';

  @override
  String get dictVoteRegistered => 'Vote registered';

  @override
  String get dictVoteBtn => 'Yes, it helped me';

  @override
  String get dictUsefulVotes => 'Useful votes';

  @override
  String get dictViews => 'Views';

  @override
  String get dictAdditionalInfo => 'Additional info';

  @override
  String get dictAddedOn => 'Added on';

  @override
  String get dictLastUpdate => 'Last update';

  @override
  String get dictStatusLabel => 'Status';

  @override
  String get dictStatusApproved => 'Approved';

  @override
  String get dictStatusPending => 'Pending';

  @override
  String get dictStatusRejected => 'Rejected';

  @override
  String get dictEditDialogTitle => 'Edit Term';

  @override
  String get dictEditFieldTerm => 'Term';

  @override
  String get dictEditErrorTerm => 'The term cannot be empty';

  @override
  String get dictEditFieldDefinition => 'Definition';

  @override
  String get dictEditErrorDefinition => 'The definition cannot be empty';

  @override
  String get dictEditFieldExample => 'Example (optional)';

  @override
  String get dictEditFieldCategory => 'Category';

  @override
  String get dictCancelBtn => 'Cancel';

  @override
  String get dictSaveChangesBtn => 'Save Changes';

  @override
  String get dictUpdateSuccess => 'Term updated successfully';

  @override
  String get dictUpdateError => 'Error updating the term';

  @override
  String get dictDeleteConfirmTitle => 'Confirm Deletion';

  @override
  String get dictDeleteConfirmContent =>
      'Are you sure you want to permanently delete this term? This action cannot be undone.';

  @override
  String get dictDeleteBtn => 'Delete';

  @override
  String get dictDeleteSuccess => 'Term deleted successfully';

  @override
  String get dictDeleteError => 'Error deleting the term';

  @override
  String get dictListEmptyTitle => 'No terms in the dictionary';

  @override
  String get dictListEmptyMessage => 'Be the first to propose a term';

  @override
  String get dictListProposeBtn => 'Propose term';

  @override
  String get dictProposeErrorAuth => 'Error: User not authenticated';

  @override
  String get dictProposeSuccessTitle => 'Term submitted!';

  @override
  String get dictProposeSuccessMessage =>
      'Your term has been successfully proposed and will be reviewed by a moderator. We will notify you when it is approved.';

  @override
  String get dictProposeUnderstoodBtn => 'Understood';

  @override
  String get dictProposeErrorGeneric => 'Error proposing term';

  @override
  String get dictProposeTitle => 'Propose Term';

  @override
  String get dictProposeHelpText =>
      'Help other parents by adding terms you know';

  @override
  String get dictProposeFieldTerm => 'Term or word';

  @override
  String get dictProposeFieldTermHint => 'Ex: GG, Nerf, Farming';

  @override
  String get dictProposeErrorTermEmpty => 'Please enter the term';

  @override
  String get dictProposeErrorTermLength =>
      'The term must be at least 2 characters long';

  @override
  String get dictProposeFieldCategory => 'Category';

  @override
  String get dictProposeFieldDefinition => 'Definition';

  @override
  String get dictProposeFieldDefinitionHint =>
      'Explain what this term means clearly and simply';

  @override
  String get dictProposeErrorDefinitionEmpty => 'Please enter the definition';

  @override
  String get dictProposeErrorDefinitionLength =>
      'The definition must be at least 10 characters long';

  @override
  String get dictProposeFieldExample => 'Example of use';

  @override
  String get dictProposeFieldExampleHint =>
      'Ex: \"Kids say GG at the end of each match\"';

  @override
  String get dictProposeErrorExampleEmpty => 'Please enter an example of use';

  @override
  String get dictProposeErrorExampleLength =>
      'The example must be at least 10 characters long';

  @override
  String get dictProposeWarningText =>
      'Your term will be reviewed by a moderator before appearing in the dictionary. This helps maintain content quality.';

  @override
  String get dictProposeSendingBtn => 'Sending...';

  @override
  String get dictProposeSubmitBtn => 'Propose term';

  @override
  String get dictCategoryJerga => 'Gamer Slang';

  @override
  String get dictCategoryMechanics => 'Game Mechanics';

  @override
  String get dictCategoryPlatforms => 'Platforms';

  @override
  String get dictModAccessDeniedTitle => 'Access Denied';

  @override
  String get dictModAccessDeniedMessage =>
      'You do not have permission to access this section';

  @override
  String get dictModAccessDeniedSubtitle =>
      'Only moderators can review proposed terms';

  @override
  String get dictModTitle => 'Moderation Panel';

  @override
  String get dictModRefreshTooltip => 'Refresh';

  @override
  String get dictModLoading => 'Loading pending terms...';

  @override
  String get dictModAllReviewedTitle => 'All reviewed!';

  @override
  String get dictModAllReviewedMessage =>
      'There are no pending terms to review';

  @override
  String dictModPendingCount(int count) {
    return '$count pending terms to review';
  }

  @override
  String get dictModDefinitionLabel => 'Definition:';

  @override
  String get dictModExampleLabel => 'Example of use:';

  @override
  String dictModProposedOn(String date) {
    return 'Proposed on $date';
  }

  @override
  String get dictModEditBtn => 'Edit term';

  @override
  String get dictModSwipeHint => 'Swipe to approve or reject';

  @override
  String get dictModApproveTitle => 'Approve term';

  @override
  String dictModApproveConfirm(String term) {
    return 'Are you sure you want to approve the term \"$term\"?\n\nIt will be visible to all users.';
  }

  @override
  String get dictModCancelBtn => 'Cancel';

  @override
  String get dictModApproveBtn => 'Approve';

  @override
  String dictModApproveSuccess(String term) {
    return '✓ Term \"$term\" approved successfully';
  }

  @override
  String get dictModApproveError => '✗ Error approving term';

  @override
  String get dictModRejectTitle => 'Reject term';

  @override
  String dictModRejectReasonTitle(String term) {
    return 'Why are you rejecting the term \"$term\"?';
  }

  @override
  String get dictModRejectHint => 'Write the reason for rejection...';

  @override
  String get dictModRejectWarning =>
      'The user will see this reason in their proposed terms';

  @override
  String get dictModRejectErrorEmpty => 'You must provide a reason to reject';

  @override
  String get dictModRejectBtn => 'Reject';

  @override
  String dictModRejectSuccess(String term) {
    return '✓ Term \"$term\" rejected';
  }

  @override
  String get dictModRejectError => '✗ Error rejecting term';

  @override
  String get dictModEditTitle => 'Edit term';

  @override
  String get dictModEditFieldTerm => 'Term';

  @override
  String get dictModEditFieldDef => 'Definition';

  @override
  String get dictModEditFieldEx => 'Example (optional)';

  @override
  String get dictModEditFieldCat => 'Category';

  @override
  String get dictModEditErrorEmpty => 'Term and definition are required';

  @override
  String get dictModEditErrorGeneric => 'Could not update term';

  @override
  String get dictModEditSaveBtn => 'Save changes';

  @override
  String get dictModEditSuccess => '✓ Term updated successfully';

  @override
  String get myTermsTitle => 'My Proposed Terms';

  @override
  String get myTermsLoading => 'Loading your terms...';

  @override
  String get myTermsEmptyTitle => 'You haven\'t proposed any terms yet';

  @override
  String get myTermsEmptyMessage =>
      'Contribute to the dictionary by proposing new terms';

  @override
  String get myTermsProposedCount => 'Proposed terms';

  @override
  String get myTermsApproved => 'Approved';

  @override
  String get myTermsPending => 'Pending';

  @override
  String get myTermsViewReason => 'View reason';

  @override
  String get adminAccessDeniedTitle => 'Access Denied';

  @override
  String get adminAccessDeniedMessage =>
      'Only administrators can access this section';

  @override
  String get adminUsersTitle => 'User Management';

  @override
  String get adminUsersInfoTooltip => 'Information';

  @override
  String get adminUsersLoading => 'Loading users...';

  @override
  String get adminUsersError => 'Error loading users';

  @override
  String get adminUsersEmpty => 'No registered users found';

  @override
  String get adminUsersStatTotal => 'Total';

  @override
  String get adminUsersStatAdmins => 'Admins';

  @override
  String get adminUsersStatMods => 'Moderators';

  @override
  String get adminUsersStatUsers => 'Users';

  @override
  String get adminUsersBadgeYou => 'You';

  @override
  String adminUsersProposedApproved(Object approved, Object proposed) {
    return '$proposed proposed | $approved approved';
  }

  @override
  String get adminUsersActionMakeUser => 'Change to User';

  @override
  String get adminUsersActionMakeMod => 'Change to Moderator';

  @override
  String get adminUsersActionMakeAdmin => 'Change to Admin';

  @override
  String get adminRoleAdmin => 'Admin';

  @override
  String get adminRoleModerator => 'Moderator';

  @override
  String get adminRoleUser => 'User';

  @override
  String get adminChangeRoleTitle => 'Confirm role change';

  @override
  String adminChangeRoleConfirm(Object role, Object user) {
    return 'Are you sure you want to change the role of \"$user\" to \"$role\"?';
  }

  @override
  String get adminCancelBtn => 'Cancel';

  @override
  String get adminConfirmBtn => 'Confirm';

  @override
  String get adminInfoDialogTitle => 'Role Management';

  @override
  String get adminInfoDialogSubtitle => 'Available roles:';

  @override
  String get adminInfoUserDesc => 'Can view the dictionary and propose terms';

  @override
  String get adminInfoModDesc => 'Can approve or reject proposed terms';

  @override
  String get adminInfoAdminDesc => 'Has full access, including user management';

  @override
  String get adminInfoUnderstoodBtn => 'Understood';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navGuides => 'Guides';

  @override
  String get navDictionary => 'Dictionary';

  @override
  String get navGames => 'Games';

  @override
  String get navParentalControl => 'Parental Control';

  @override
  String get navCommunity => 'Community';

  @override
  String get headerSearchHint => 'Search...';

  @override
  String get headerMenuBtn => 'Menu';

  @override
  String get accountMenuProfile => 'My Profile';

  @override
  String get accountMenuMyTerms => 'My Proposed Terms';

  @override
  String accountMenuTermsCount(int count) {
    return '$count terms';
  }

  @override
  String get accountMenuModeration => 'Moderation';

  @override
  String get accountMenuUsers => 'User Management';

  @override
  String get accountMenuLogout => 'Log out';

  @override
  String get footerTaglineMobile =>
      'Empowering the next generation\nof parents in the digital age';

  @override
  String get footerPrivacy => 'Privacy Policy';

  @override
  String get footerAbout => 'About us';

  @override
  String get footerContact => 'Contact us';

  @override
  String footerCopyright(String year, String appName) {
    return '© $year $appName. All rights reserved.';
  }

  @override
  String get footerTaglineDesktop =>
      'Empowering the next generation of parents in the digital age';

  @override
  String get footerErrorLink => 'Could not open the external link.';

  @override
  String get genreAction => 'Action';

  @override
  String get genreAdventure => 'Adventure';

  @override
  String get genreRPG => 'RPG';

  @override
  String get genreStrategy => 'Strategy';

  @override
  String get genreShooter => 'Shooter';

  @override
  String get genrePuzzle => 'Puzzle';

  @override
  String get genreSports => 'Sports';

  @override
  String get genreRacing => 'Racing';

  @override
  String get genreSimulation => 'Simulation';

  @override
  String get genrePlatformer => 'Platformer';

  @override
  String get genreFighting => 'Fighting';

  @override
  String get genreArcade => 'Arcade';

  @override
  String get gameDetailLoading => 'Loading game information...';

  @override
  String get gameDetailError => 'Failed to load game information';

  @override
  String get gameDetailBackBtn => 'Back';

  @override
  String gameDetailRelease(String date) {
    return 'Release: $date';
  }

  @override
  String get gameDetailPegiTitle => 'Age rating (PEGI)';

  @override
  String gameDetailPegiWarning(int pegi) {
    return 'Recommended for ages $pegi and up';
  }

  @override
  String get gameDetailPegiNotAvailable =>
      'No PEGI rating information available';

  @override
  String get gameDetailDescriptionTitle => 'Game description';

  @override
  String get gameDetailDescriptionEmpty => 'No description available';

  @override
  String get gameDetailGenresTitle => 'Genres';

  @override
  String get gameDetailPlatformsTitle => 'Available platforms';

  @override
  String get gameDetailScreenshotsTitle => 'Screenshots';

  @override
  String get pegiDescription3 =>
      'Content suitable for all ages. No violence or inappropriate language.';

  @override
  String get pegiDescription7 =>
      'May contain scenes or sounds that can frighten young children.';

  @override
  String get pegiDescription12 =>
      'May include non-realistic violence towards fantasy characters or mild realistic violence.';

  @override
  String get pegiDescription16 =>
      'May contain realistic violence, strong language or mild sexual content.';

  @override
  String get pegiDescription18 =>
      'Adult content. May include intense violence, strong language, explicit sexual content, or drug use.';

  @override
  String get pegiDescriptionUnknown =>
      'No description available for this PEGI rating.';

  @override
  String get homeDefaultUser => 'User';

  @override
  String homeWelcomeUser(String userName) {
    return 'Welcome, $userName!';
  }

  @override
  String homeUserStats(int approved, int proposed) {
    return 'You have $approved approved terms and $proposed proposed terms.';
  }

  @override
  String homeActiveTerms(int count) {
    return '$count active terms';
  }

  @override
  String get homeQuickAccessTitle => 'Quick access';

  @override
  String get homeQuickAccessSubtitle =>
      'Access the most-used areas of the site';

  @override
  String get homeQuickActionGamesTitle => 'Find games by age';

  @override
  String get homeQuickActionGamesSubtitle =>
      'Find games that fit your child\'s age';

  @override
  String get homeQuickActionDictTitle => 'Search dictionary terms';

  @override
  String get homeQuickActionDictSubtitle =>
      'Discover what the words your child uses while gaming mean';

  @override
  String get homeQuickActionGuidesTitle => 'Set up Parental Controls';

  @override
  String get homeQuickActionGuidesSubtitle =>
      'Set age and usage limits based on the platform';

  @override
  String get homeGameOfTheWeek => 'Game of the week';

  @override
  String get homeSeeMonthsGames => 'See this month\'s games';

  @override
  String get homeFullAnalysisBtn => 'Full analysis';

  @override
  String get homeLatestUpdatesTitle => 'Latest updates';

  @override
  String get forumSectionGeneral => 'General';

  @override
  String get forumSectionNews => 'News';

  @override
  String get forumSectionQnA => 'Q&A';

  @override
  String get homeGoToCommunityBtn => 'Go to the community';

  @override
  String get homeGameSummaryEmpty =>
      'There is no featured game this week. Check this month\'s games to see the latest releases.';

  @override
  String homeGameSummaryReleased(String date) {
    return 'Released: $date';
  }

  @override
  String get homeGameSummaryReleasedEmpty => 'Released: unavailable';

  @override
  String homeGameSummaryRating(String rating) {
    return 'Rating: $rating';
  }

  @override
  String get homeGameSummaryRatingEmpty => 'Rating: no data';

  @override
  String get homeGameSummaryNoGenre => 'No genre';

  @override
  String get homeGameSummaryRatingPending => 'Rating pending';

  @override
  String homeGameSummaryFull(
      String genre, String released, String rating, String ageRating) {
    return 'Genre: $genre · $released · $rating · $ageRating';
  }

  @override
  String get homeGameTopLabelWeekly => 'Weekly pick';

  @override
  String get homeGameTopLabelUnrated => 'Unrated';

  @override
  String get homeUpdateNoNews => 'No recent updates in this section.';

  @override
  String get homeUpdateThreadUpdated => 'Thread updated recently';

  @override
  String get homeUpdateCommunity => 'Community';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleModerator => 'Moderator';

  @override
  String get commonLoading => 'Loading...';

  @override
  String userLevel(int level) {
    return 'Level $level';
  }

  @override
  String get forumSidebarFollowedTopics => 'Followed Topics';

  @override
  String get forumSidebarTopic1Title => 'Screen time limits for 10 year olds?';

  @override
  String get forumSidebarTopic1Subtitle => '24 new replies today';

  @override
  String get forumSidebarTopic2Title => 'Best educational games on Switch';

  @override
  String get forumSidebarTopic2Subtitle => '15 new replies today';

  @override
  String get forumSidebarTopic3Title => 'Dealing with online chat safety';

  @override
  String get forumSidebarTopic3Subtitle => '8 new replies today';

  @override
  String get forumSidebarRepliesToYou => 'Replies to you';

  @override
  String get forumSidebarReply1Link => 'Fortnite Safety';

  @override
  String get forumSidebarReply1Action => 'replied to your co...';

  @override
  String get forumSidebarReply1Time => '2 minutes ago';

  @override
  String get forumSidebarReply2Link => 'Console Comparison';

  @override
  String get forumSidebarReply2Action => 'tagged you in...';

  @override
  String get forumSidebarReply2Time => '1 hour ago';

  @override
  String get forumSidebarReply3Link => 'Welcome Thread';

  @override
  String get forumSidebarReply3Action => 'liked your reply i...';

  @override
  String get forumSidebarReply3Time => '3 hours ago';

  @override
  String get forumSidebarGlobalNews => 'Global Forum News';

  @override
  String get forumSidebarNews1Tag => 'Update';

  @override
  String get forumSidebarNews1Text =>
      'New parental control guides added to the Dictionary.';

  @override
  String get forumSidebarNews2Tag => 'Event';

  @override
  String get forumSidebarNews2Text =>
      'Live Q&A with child psychologist this Thursday at 6PM.';

  @override
  String get forumSidebarNews3Tag => 'Feature';

  @override
  String get forumSidebarNews3Text =>
      'Dark mode is now available in user settings!';
}
