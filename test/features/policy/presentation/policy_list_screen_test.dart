import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_mobile/app/theme/app_theme.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/di/di.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';
import 'package:insurance_mobile/features/policy/presentation/screens/policies_screen.dart';
import 'package:insurance_mobile/features/policy/presentation/widgets/widgets.dart';
import 'package:insurance_mobile/shared/widgets/widgets.dart';
import 'package:insurance_mobile/l10n/app_localizations.dart';

void main() {
  group('PolicyListScreen', () {
    testWidgets('renders loading state before policies resolve', (
      tester,
    ) async {
      final completer = Completer<Result<List<Policy>>>();
      final repository = _FakePolicyRepository(() => completer.future);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            policyRepositoryProvider.overrideWith((ref) => repository),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const PolicyListScreen(),
          ),
        ),
      );

      expect(find.text('Loading policies...'), findsOneWidget);
      expect(find.byType(PolicyCardSkeleton), findsWidgets);

      completer.complete(Result.success(_samplePolicies));
      await tester.pumpAndSettle();
    });

    testWidgets('renders policy cards after loading policies', (tester) async {
      final repository = _FakePolicyRepository(
        () async => Result.success(_samplePolicies),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            policyRepositoryProvider.overrideWith((ref) => repository),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const PolicyListScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Vehicle Insurance'), findsOneWidget);
      expect(find.text('Health Insurance'), findsOneWidget);
      expect(find.text('Home Insurance'), findsOneWidget);
    });

    testWidgets('renders error view when loading fails', (tester) async {
      final completer = Completer<Result<List<Policy>>>();
      final repository = _FakePolicyRepository(() => completer.future);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            policyRepositoryProvider.overrideWith((ref) => repository),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const PolicyListScreen(),
          ),
        ),
      );

      completer.complete(
        const Result.failure(
          NetworkFailure(message: 'Unable to fetch policies'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });
  });
}

class _FakePolicyRepository implements PolicyRepository {
  _FakePolicyRepository(this._getPolicies);

  final ResultFuture<List<Policy>> Function() _getPolicies;

  @override
  ResultFuture<List<Policy>> getPolicies() => _getPolicies();
}

final _samplePolicies = [
  Policy(
    id: 'vehicle-policy',
    policyNumber: 'PL-2026-0001',
    holderName: 'Merve Coban',
    type: PolicyType.vehicle,
    coverageAmount: 25000,
    startDate: DateTime(2026, 1, 1),
    endDate: DateTime(2026, 12, 31),
  ),
  Policy(
    id: 'health-policy',
    policyNumber: 'PL-2026-0002',
    holderName: 'Merve Coban',
    type: PolicyType.health,
    coverageAmount: 120000,
    startDate: DateTime(2026, 2, 15),
    endDate: DateTime(2027, 2, 14),
  ),
  Policy(
    id: 'home-policy',
    policyNumber: 'PL-2026-0003',
    holderName: 'Merve Coban',
    type: PolicyType.home,
    coverageAmount: 350000,
    startDate: DateTime(2026, 3, 1),
    endDate: DateTime(2027, 2, 28),
  ),
];
