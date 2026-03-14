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
  String get submitClaim => 'Submit Claim';

  @override
  String get incidentDate => 'Incident Date';

  @override
  String get incidentDescription => 'Incident Description';

  @override
  String get comingSoon =>
      'This module is scaffolded and ready for implementation.';

  @override
  String get retry => 'Retry';
}
