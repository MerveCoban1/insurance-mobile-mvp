// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Insurance App';

  @override
  String get policies => 'Policies';

  @override
  String get policyDetails => 'Policy Details';

  @override
  String get vehicleInsurance => 'Vehicle Insurance';

  @override
  String get healthInsurance => 'Health Insurance';

  @override
  String get homeInsurance => 'Home Insurance';

  @override
  String get coverageAmount => 'Coverage Amount';

  @override
  String get policyNumber => 'Policy Number';

  @override
  String get status => 'Status';

  @override
  String get policyStatusActive => 'Active';

  @override
  String get policyStatusInactive => 'Inactive';

  @override
  String get policyStatusPending => 'Pending';

  @override
  String get policyStatusExpired => 'Expired';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get submitClaim => 'Submit Claim';

  @override
  String get incidentDate => 'Incident Date';

  @override
  String get incidentDescription => 'Incident Description';

  @override
  String get incidentDescriptionHint => 'Describe what happened';

  @override
  String get descriptionRequired => 'Description is required.';

  @override
  String get incidentDateRequired => 'Incident date is required.';

  @override
  String get selectIncidentDate => 'Select incident date';

  @override
  String get claimFormDescription =>
      'Provide the incident details below to submit your claim.';

  @override
  String get submittingClaim => 'Submitting Claim...';

  @override
  String get claimSubmittedMessage =>
      'Your claim has been submitted successfully.';

  @override
  String get claimSubmissionFailed =>
      'We could not submit your claim right now.';

  @override
  String get policyReferenceRequired =>
      'A policy reference is required to submit a claim.';

  @override
  String get noActivePolicies => 'No active policies found.';

  @override
  String get noPoliciesDescription =>
      'Once policies are issued, they will appear here for quick access.';

  @override
  String get loadingPolicies => 'Loading policies...';

  @override
  String get policyListIntroTitle => 'Protected with confidence';

  @override
  String get policyListIntroSubtitle =>
      'Review your active coverage, track policy status, and access claim flows from one place.';

  @override
  String get policyListSectionSubtitle =>
      'Your available policies are organized below for quick review.';

  @override
  String get policyListLoadError =>
      'We could not load your policies right now.';

  @override
  String get policyNotFound => 'The selected policy could not be found.';

  @override
  String get loadingPolicyDetails => 'Loading policy details...';

  @override
  String get policyHolder => 'Policy Holder';

  @override
  String get policyTerm => 'Policy Term';

  @override
  String get policyOverview => 'Overview';

  @override
  String get policyOverviewSubtitle =>
      'Review the core coverage details and validity information for this policy.';

  @override
  String get policyClaimCtaTitle => 'Need to report an incident?';

  @override
  String get policyClaimCtaSubtitle =>
      'Start a claim in minutes and keep this policy reference attached automatically.';

  @override
  String get policyDetailLoadError =>
      'We could not load this policy right now.';

  @override
  String get policyReference => 'Policy Reference';

  @override
  String get claimFormIntroTitle => 'Tell us what happened';

  @override
  String get claimFormIntroSubtitle =>
      'Provide the incident date and a concise description so we can review your request quickly.';

  @override
  String get claimDetailsSectionTitle => 'Claim Details';

  @override
  String get claimReviewNote =>
      'We use these details to begin the first review of your claim.';

  @override
  String get claimIncidentDateHint => 'Choose the date of the incident';

  @override
  String get claimSuccessTitle => 'Claim Submitted';

  @override
  String get claimSuccessHeadline => 'Your claim has been received';

  @override
  String get claimSuccessDescription =>
      'Our team will review the details and contact you if more information is needed.';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get comingSoon =>
      'This module is scaffolded and ready for implementation.';

  @override
  String get retry => 'Retry';
}
