import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application title shown in the app shell.
  ///
  /// In en, this message translates to:
  /// **'Insurance App'**
  String get appTitle;

  /// Title for the policy list area.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get policies;

  /// Title for the policy detail route.
  ///
  /// In en, this message translates to:
  /// **'Policy Details'**
  String get policyDetails;

  /// Label for vehicle insurance policies.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Insurance'**
  String get vehicleInsurance;

  /// Label for health insurance policies.
  ///
  /// In en, this message translates to:
  /// **'Health Insurance'**
  String get healthInsurance;

  /// Label for home insurance policies.
  ///
  /// In en, this message translates to:
  /// **'Home Insurance'**
  String get homeInsurance;

  /// Label for a policy coverage amount.
  ///
  /// In en, this message translates to:
  /// **'Coverage Amount'**
  String get coverageAmount;

  /// Label for a policy number.
  ///
  /// In en, this message translates to:
  /// **'Policy Number'**
  String get policyNumber;

  /// Label for policy status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// Label for an active policy status.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get policyStatusActive;

  /// Label for an inactive policy status.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get policyStatusInactive;

  /// Label for a pending policy status.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get policyStatusPending;

  /// Label for an expired policy status.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get policyStatusExpired;

  /// Label for a policy or claim start date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// Label for a policy end date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// Title for the claim submission route.
  ///
  /// In en, this message translates to:
  /// **'Submit Claim'**
  String get submitClaim;

  /// Claim incident date field label.
  ///
  /// In en, this message translates to:
  /// **'Incident Date'**
  String get incidentDate;

  /// Claim incident description field label.
  ///
  /// In en, this message translates to:
  /// **'Incident Description'**
  String get incidentDescription;

  /// Hint text for the claim description field.
  ///
  /// In en, this message translates to:
  /// **'Describe what happened'**
  String get incidentDescriptionHint;

  /// Validation message when the incident description is missing.
  ///
  /// In en, this message translates to:
  /// **'Description is required.'**
  String get descriptionRequired;

  /// Validation message when the incident date is missing.
  ///
  /// In en, this message translates to:
  /// **'Incident date is required.'**
  String get incidentDateRequired;

  /// Action label for choosing the incident date.
  ///
  /// In en, this message translates to:
  /// **'Select incident date'**
  String get selectIncidentDate;

  /// Helper copy shown above the claim form.
  ///
  /// In en, this message translates to:
  /// **'Provide the incident details below to submit your claim.'**
  String get claimFormDescription;

  /// Button label shown while a claim is being submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitting Claim...'**
  String get submittingClaim;

  /// Snackbar message shown after a successful claim submission.
  ///
  /// In en, this message translates to:
  /// **'Your claim has been submitted successfully.'**
  String get claimSubmittedMessage;

  /// Error message shown when claim submission fails.
  ///
  /// In en, this message translates to:
  /// **'We could not submit your claim right now.'**
  String get claimSubmissionFailed;

  /// Error message shown when a claim is opened without a policy.
  ///
  /// In en, this message translates to:
  /// **'A policy reference is required to submit a claim.'**
  String get policyReferenceRequired;

  /// Empty state message for the policy list.
  ///
  /// In en, this message translates to:
  /// **'No active policies found.'**
  String get noActivePolicies;

  /// Supporting copy shown when the user has no policies.
  ///
  /// In en, this message translates to:
  /// **'Once policies are issued, they will appear here for quick access.'**
  String get noPoliciesDescription;

  /// Loading message for the policy list.
  ///
  /// In en, this message translates to:
  /// **'Loading policies...'**
  String get loadingPolicies;

  /// Intro title shown at the top of the policy list screen.
  ///
  /// In en, this message translates to:
  /// **'Protected with confidence'**
  String get policyListIntroTitle;

  /// Intro subtitle shown at the top of the policy list screen.
  ///
  /// In en, this message translates to:
  /// **'Review your active coverage, track policy status, and access claim flows from one place.'**
  String get policyListIntroSubtitle;

  /// Subtitle for the policy list section heading.
  ///
  /// In en, this message translates to:
  /// **'Your available policies are organized below for quick review.'**
  String get policyListSectionSubtitle;

  /// Error message shown when the policy list fails to load.
  ///
  /// In en, this message translates to:
  /// **'We could not load your policies right now.'**
  String get policyListLoadError;

  /// Error message shown when a policy detail cannot be found.
  ///
  /// In en, this message translates to:
  /// **'The selected policy could not be found.'**
  String get policyNotFound;

  /// Loading message for the policy detail screen.
  ///
  /// In en, this message translates to:
  /// **'Loading policy details...'**
  String get loadingPolicyDetails;

  /// Label for the person covered by the policy.
  ///
  /// In en, this message translates to:
  /// **'Policy Holder'**
  String get policyHolder;

  /// Label for the validity period of a policy.
  ///
  /// In en, this message translates to:
  /// **'Policy Term'**
  String get policyTerm;

  /// Section title for policy details.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get policyOverview;

  /// Section subtitle for policy details.
  ///
  /// In en, this message translates to:
  /// **'Review the core coverage details and validity information for this policy.'**
  String get policyOverviewSubtitle;

  /// Headline for the claim call to action on the policy detail screen.
  ///
  /// In en, this message translates to:
  /// **'Need to report an incident?'**
  String get policyClaimCtaTitle;

  /// Supporting copy for the claim call to action on the policy detail screen.
  ///
  /// In en, this message translates to:
  /// **'Start a claim in minutes and keep this policy reference attached automatically.'**
  String get policyClaimCtaSubtitle;

  /// Error message shown when the policy detail fails to load.
  ///
  /// In en, this message translates to:
  /// **'We could not load this policy right now.'**
  String get policyDetailLoadError;

  /// Label for a policy reference identifier.
  ///
  /// In en, this message translates to:
  /// **'Policy Reference'**
  String get policyReference;

  /// Headline shown at the top of the claim form.
  ///
  /// In en, this message translates to:
  /// **'Tell us what happened'**
  String get claimFormIntroTitle;

  /// Supporting copy shown at the top of the claim form.
  ///
  /// In en, this message translates to:
  /// **'Provide the incident date and a concise description so we can review your request quickly.'**
  String get claimFormIntroSubtitle;

  /// Section title for the claim form fields.
  ///
  /// In en, this message translates to:
  /// **'Claim Details'**
  String get claimDetailsSectionTitle;

  /// Helper copy below the claim description field.
  ///
  /// In en, this message translates to:
  /// **'We use these details to begin the first review of your claim.'**
  String get claimReviewNote;

  /// Placeholder text for the claim date selector.
  ///
  /// In en, this message translates to:
  /// **'Choose the date of the incident'**
  String get claimIncidentDateHint;

  /// App bar title for the claim success screen.
  ///
  /// In en, this message translates to:
  /// **'Claim Submitted'**
  String get claimSuccessTitle;

  /// Headline shown on the claim success screen.
  ///
  /// In en, this message translates to:
  /// **'Your claim has been received'**
  String get claimSuccessHeadline;

  /// Supporting copy shown on the claim success screen.
  ///
  /// In en, this message translates to:
  /// **'Our team will review the details and contact you if more information is needed.'**
  String get claimSuccessDescription;

  /// Button label to return to the main policy list.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Generic placeholder message for architecture-only routes.
  ///
  /// In en, this message translates to:
  /// **'This module is scaffolded and ready for implementation.'**
  String get comingSoon;

  /// Reusable retry action label.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
