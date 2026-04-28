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
  String get xboxGuideTitle => 'Parental Controls on Xbox';

  @override
  String get xboxGuideDescription =>
      'Set up content filters, purchase restrictions, and privacy settings on Xbox Series X/S and Xbox One using your Microsoft family account.';

  @override
  String get xboxGuideStep1 =>
      'Press the Xbox button on the controller and go to "Profile & system" → "Settings".';

  @override
  String get xboxGuideStep2 => 'Select "Account" → "Family settings".';

  @override
  String get xboxGuideStep3 =>
      'Choose the child\'s account and select "Privacy & online safety".';

  @override
  String get xboxGuideStep4 =>
      'Set up restrictions for content, communication with other players, and purchases.';

  @override
  String get xboxGuideStep5 =>
      'Confirm the changes. The settings are automatically applied to the child\'s profile.';

  @override
  String get xboxTimeGuideTitle => 'Screen Time Limits on Xbox';

  @override
  String get xboxTimeGuideDescription =>
      'Set schedules and daily game time limits on Xbox for each family member from the Microsoft Family Safety app.';

  @override
  String get xboxTimeGuideStep1 =>
      'Download and install the "Microsoft Family Safety" app on your smartphone. Sign in with your Microsoft account.';

  @override
  String get xboxTimeGuideStep2 =>
      'Select the child\'s profile in the app and go to "Screen time".';

  @override
  String get xboxTimeGuideStep3 =>
      'Enable time limits and configure how many hours they can use Xbox each day of the week.';

  @override
  String get xboxTimeGuideStep4 =>
      'Set the time slots when the console is available (e.g., only from 5:00 PM to 8:00 PM).';

  @override
  String get xboxTimeGuideStep5 =>
      'Save the settings. The child will receive warnings before their time is up and will need your approval to request more time.';

  @override
  String get nintendoGuideTitle => 'Parental Controls on Nintendo Switch';

  @override
  String get nintendoGuideDescription =>
      'Set up parental controls directly on the Nintendo Switch console to restrict content and set age limits.';

  @override
  String get nintendoGuideStep1 =>
      'Access "System Settings" from the Nintendo Switch main menu.';

  @override
  String get nintendoGuideStep2 => 'Scroll down and select "Parental Controls".';

  @override
  String get nintendoGuideStep3 =>
      'Choose "Use Smart Device" to link the app, or "Set up on this console" if you prefer to do it from the console.';

  @override
  String get nintendoGuideStep4 =>
      'Select the content restriction level based on the child\'s age.';

  @override
  String get nintendoGuideStep5 =>
      'Set a 4-digit PIN to protect the settings. Save and confirm.';

  @override
  String get nintendoAppGuideTitle => 'Set up the Parental Controls App (Nintendo)';

  @override
  String get nintendoAppGuideDescription =>
      'Learn how to link and set up the "Nintendo Switch Parental Controls" app on your smartphone to remotely manage game time limits.';

  @override
  String get nintendoAppGuideStep1 =>
      'Download the "Nintendo Switch Parental Controls" app on your smartphone (available on Android and iOS).';

  @override
  String get nintendoAppGuideStep2 =>
      'Open the app and accept the terms of use. Sign in with your Nintendo Account or create a new one.';

  @override
  String get nintendoAppGuideStep3 =>
      'On the console, go to "System Settings" → "Parental Controls" → "Use Smart Device" and scan the QR code with the app.';

  @override
  String get nintendoAppGuideStep4 =>
      'Assign a name to the child and select their age group to apply automatic restrictions.';

  @override
  String get nintendoAppGuideStep5 =>
      'Set the daily game time limit. You can set different limits for weekdays and weekends.';

  @override
  String get nintendoAppGuideStep6 =>
      'Enable the play restriction after the time limit and customize the message the child will see upon reaching it.';

  @override
  String get nintendoAppGuideStep7 =>
      'Review the monthly activity summary: games played, total time, and daily trends.';

  @override
  String get nintendoAppGuideStep8 =>
      'From the app, you can add extra time on the spot or temporarily suspend limits without touching the console.';

  @override
  String get steamGuideTitle => 'Parental Controls on Steam';

  @override
  String get steamGuideDescription =>
      'Set up Steam\'s Family View to control which games your children can access.';

  @override
  String get steamGuideStep1 =>
      'Open Steam on the PC and click on "Steam" (top left) → "Settings".';

  @override
  String get steamGuideStep2 => 'Select "Family" from the side menu.';

  @override
  String get steamGuideStep3 => 'Enable "Family View" and set a security PIN.';

  @override
  String get steamGuideStep4 =>
      'Manually select which games from your library will be visible in family mode.';

  @override
  String get steamGuideStep5 =>
      'Children will only be able to access approved games. To exit the mode, they will need the PIN.';

  @override
  String get iosGuideTitle => 'Activate Parental Controls on iOS (iPhone/iPad)';

  @override
  String get iosGuideDescription =>
      'Set up Screen Time, content, and privacy on iPhone/iPad to protect minors.';

  @override
  String get iosGuideStep1 =>
      'Open Settings on the iPhone/iPad and go to "Screen Time".';

  @override
  String get iosGuideStep2 =>
      'Tap "Turn On Screen Time" and select "This is My Child\'s iPhone".';

  @override
  String get iosGuideStep3 =>
      'Set a Screen Time passcode different from the device unlock code.';

  @override
  String get iosGuideStep4 =>
      'Set up "Downtime", "App Limits", and "Content & Privacy Restrictions".';
}
