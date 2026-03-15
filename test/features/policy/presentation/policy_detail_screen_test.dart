import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_mobile/app/theme/app_theme.dart';
import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/di/di.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';
import 'package:insurance_mobile/features/policy/presentation/screens/policy_detail_screen.dart';
import 'package:insurance_mobile/l10n/app_localizations.dart';

void main() {
  group('PolicyDetailScreen', () {
    testWidgets('renders policy details from getPolicyById provider', (
      tester,
    ) async {
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
            home: const PolicyDetailScreen(policyId: 'vehicle-policy'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Vehicle Insurance'), findsOneWidget);
      expect(find.text('Policy Holder'), findsOneWidget);
      expect(find.text('Submit Claim'), findsOneWidget);
    });

    testWidgets('renders not found view when policy is missing', (
      tester,
    ) async {
      final repository = _FakePolicyRepository(
        () async => const Result.success([]),
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
            home: const PolicyDetailScreen(policyId: 'missing-policy'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('The selected policy could not be found.'),
        findsOneWidget,
      );
    });
  });
}

class _FakePolicyRepository implements PolicyRepository {
  _FakePolicyRepository(this._getPolicies);

  final ResultFuture<List<Policy>> Function() _getPolicies;

  @override
  ResultFuture<List<Policy>> getPolicies() => _getPolicies();

  @override
  ResultFuture<Policy?> getPolicyById(String policyId) async {
    final result = await _getPolicies();

    return result.when(
      success: (policies) {
        for (final policy in policies) {
          if (policy.id == policyId) {
            return Result.success(policy);
          }
        }

        return const Result<Policy?>.success(null);
      },
      failure: Result.failure,
    );
  }
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
];
