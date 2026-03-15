import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_mobile/app/theme/app_theme.dart';
import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/claim/di/di.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';
import 'package:insurance_mobile/features/claim/presentation/providers/claim_form_provider.dart';
import 'package:insurance_mobile/features/claim/presentation/screens/claim_form_screen.dart';
import 'package:insurance_mobile/l10n/app_localizations.dart';

void main() {
  group('ClaimFormScreen', () {
    testWidgets('shows validation errors when submitting empty form', (
      tester,
    ) async {
      final container = ProviderContainer(
        overrides: [
          claimRepositoryProvider.overrideWith((ref) => _FakeClaimRepository()),
        ],
      );
      addTearDown(container.dispose);
      container.read(claimFormProvider.notifier).initialize('policy-1');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: ClaimFormScreen(policyId: 'policy-1'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final submitButton = find.byType(FilledButton);

      await tester.ensureVisible(submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Incident date is required.'), findsOneWidget);
      expect(find.text('Description is required.'), findsOneWidget);
    });

    test('requires a non-empty policy id', () {
      expect(
        () => ClaimFormScreen(policyId: ''),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}

class _FakeClaimRepository implements ClaimRepository {
  @override
  ResultFuture<void> submitClaim(Claim claim) async {
    return const Result.success(null);
  }
}
