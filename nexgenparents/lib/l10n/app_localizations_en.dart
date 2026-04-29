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
}
