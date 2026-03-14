import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_mobile/app/theme/app_theme.dart';
import 'package:insurance_mobile/features/claim/presentation/screens/screens.dart';
import 'package:insurance_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('renders success content without app bar back button', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ClaimSubmissionSuccessScreen(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Claim Submitted'), findsOneWidget);
    expect(find.text('Your claim has been received'), findsOneWidget);
    expect(find.text('Back to Home'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
  });
}
