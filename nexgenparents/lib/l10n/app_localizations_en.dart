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
  String get classificationSystemsTitle => 'Rating Systems';

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
      'In addition to age, ratings include icons indicating the type of content:';

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
      'Password must be at least 8 characters long, with one uppercase, one lowercase, and one number';

  @override
  String get errorUserNotFound => 'No user found with this email';

  @override
  String get errorWrongPassword => 'Incorrect password';

  @override
  String get errorUserDisabled => 'This account has been disabled';

  @override
  String get errorEmailInUse => 'This email is already registered';

  @override
  String get errorEmailInUseRecovery =>
      'This email is already registered. If you only deleted the database profile, log in with your old password to restore it.';

  @override
  String get errorDifferentCredential =>
      'This email is already registered with another sign-in method';

  @override
  String get errorInvalidCredential => 'The credentials are not valid';

  @override
  String get errorPopupClosed =>
      'You closed the Google window before completing the sign-in';

  @override
  String get errorPopupBlocked =>
      'The browser blocked the Google pop-up. Please try again';

  @override
  String get errorPermissionDenied =>
      'Permission denied to access the profile in Firestore. Please review and deploy firestore.rules.';

  @override
  String errorGeneric(String error) {
    return 'Unexpected error: $error';
  }

  @override
  String get errorCreatingUser => 'Error creating user';

  @override
  String get errorCreatingProfile => 'Could not create user profile';

  @override
  String get errorLogin => 'Error signing in';

  @override
  String get errorLoadingProfile => 'Could not load user profile';

  @override
  String get successUserRegistered => 'User registered successfully';

  @override
  String get successLogin => 'Logged in successfully';

  @override
  String get successLoginGoogle => 'Logged in successfully with Google';

  @override
  String get successPasswordReset =>
      'Password recovery email sent. Check your inbox';

  @override
  String get psEnableGuideTitle => 'Enable Parental Controls on PlayStation';

  @override
  String get psEnableGuideDescription =>
      'Learn how to enable and configure age restrictions, spending limits, and playtime schedules on PlayStation 4 and PlayStation 5.';

  @override
  String get psEnableGuideStep1 =>
      'From the home screen, go to "Settings" (toolbox icon in the top right).';

  @override
  String get psEnableGuideStep2 =>
      'Select "Family and Parental Controls" → "Parental Controls/Family Management".';

  @override
  String get psEnableGuideStep3 => 'Choose the child\'s profile you want to configure.';

  @override
  String get psEnableGuideStep4 =>
      'Set age restrictions for games, movies, and the web browser according to your child\'s age.';

  @override
  String get psEnableGuideStep5 =>
      'Set monthly spending limits and allowed playtime schedules.';

  @override
  String get psEnableGuideStep6 =>
      'Save the changes, and the parental controls will be activated.';

  @override
  String get psDisableGuideTitle => 'Disable Parental Controls on PlayStation';

  @override
  String get psDisableGuideDescription =>
      'Learn how to disable or modify parental control restrictions on PlayStation 4 and PlayStation 5.';

  @override
  String get psDisableGuideStep1 => 'Go to "Settings" from the home screen.';

  @override
  String get psDisableGuideStep2 => 'Access "Family and Parental Controls".';

  @override
  String get psDisableGuideStep3 => 'Enter the parental control PIN code.';

  @override
  String get psDisableGuideStep4 =>
      'Select "Disable Restrictions" or modify the settings.';

  @override
  String get psDisableGuideStep5 => 'Confirm the deactivation and save the changes.';

  @override
  String get platformPlaystation => 'PlayStation (PS4/PS5)';

  @override
  String get platformXbox => 'Xbox (Series X/S)';

  @override
  String get guideTypeEnable => 'Enable';

  @override
  String get guideTypeDisable => 'Disable';

  @override
  String get guideTypeApp => 'Enable in App';

  @override
  String get guideTypeTime => 'Screen Time';

  @override
  String get guideTypeDefault => 'Guide';

  @override
  String get platformNintendo => 'Nintendo Switch';

  @override
  String get platformSteam => 'Steam (PC)';

  @override
  String get platformAndroid => 'Android';

  @override
  String get platformIos => 'iOS';

  @override
  String get profileTooltip => 'User Profile';

  @override
  String get navBarHome => 'Home';

  @override
  String get navBarSearch => 'Search';

  @override
  String get navBarGuides => 'Guides';
}