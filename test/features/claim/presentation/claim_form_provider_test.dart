import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/claim/di/di.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';
import 'package:insurance_mobile/features/claim/presentation/providers/claim_form_provider.dart';

void main() {
  group('claimFormProvider', () {
    test('marks missing policy reference as validation error', () async {
      final container = ProviderContainer(
        overrides: [
          claimRepositoryProvider.overrideWith((ref) => _FakeClaimRepository()),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(claimFormProvider.notifier);
      notifier.updateIncidentDate(DateTime(2026, 3, 14));
      notifier.updateIncidentDescription('Broken windshield');

      final didSubmit = await notifier.submit();
      final state = container.read(claimFormProvider);

      expect(didSubmit, isFalse);
      expect(state.hasAttemptedSubmit, isTrue);
      expect(
        state.submissionError,
        ClaimFormSubmissionError.missingPolicyReference,
      );
    });

    test('marks empty date and description as attempted validation', () async {
      final container = ProviderContainer(
        overrides: [
          claimRepositoryProvider.overrideWith((ref) => _FakeClaimRepository()),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(claimFormProvider.notifier);
      notifier.initialize('policy-1');

      final didSubmit = await notifier.submit();
      final state = container.read(claimFormProvider);

      expect(didSubmit, isFalse);
      expect(state.hasAttemptedSubmit, isTrue);
      expect(state.submissionError, ClaimFormSubmissionError.none);
    });

    test('reinitialize clears stale form state', () {
      final container = ProviderContainer(
        overrides: [
          claimRepositoryProvider.overrideWith((ref) => _FakeClaimRepository()),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(claimFormProvider.notifier);
      notifier.initialize('policy-1');
      notifier.updateIncidentDate(DateTime(2026, 3, 14));
      notifier.updateIncidentDescription('Broken windshield');
      notifier.reset();

      final state = container.read(claimFormProvider);

      expect(state.policyId, isNull);
      expect(state.incidentDate, isNull);
      expect(state.incidentDescription, isEmpty);
      expect(state.hasAttemptedSubmit, isFalse);
      expect(state.hasSubmitted, isFalse);
      expect(state.submissionError, ClaimFormSubmissionError.none);
    });

    test('submits successfully and stores submitted state', () async {
      Claim? submittedClaim;
      final container = ProviderContainer(
        overrides: [
          claimRepositoryProvider.overrideWith(
            (ref) => _FakeClaimRepository(
              onSubmit: (claim) => submittedClaim = claim,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(claimFormProvider.notifier);
      notifier.initialize('policy-1');
      notifier.updateIncidentDate(DateTime(2026, 3, 14));
      notifier.updateIncidentDescription('Broken windshield');

      final didSubmit = await notifier.submit();
      final state = container.read(claimFormProvider);

      expect(didSubmit, isTrue);
      expect(state.hasSubmitted, isTrue);
      expect(state.isSubmitting, isFalse);
      expect(state.submissionError, ClaimFormSubmissionError.none);
      expect(submittedClaim, isNotNull);
      expect(submittedClaim!.policyId, 'policy-1');
      expect(submittedClaim!.incidentDescription, 'Broken windshield');
    });

    test('surfaces repository failures as submission error', () async {
      final container = ProviderContainer(
        overrides: [
          claimRepositoryProvider.overrideWith(
            (ref) => _FakeClaimRepository(
              result: const Result.failure(
                UnexpectedFailure(message: 'Submission failed'),
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(claimFormProvider.notifier);
      notifier.initialize('policy-1');
      notifier.updateIncidentDate(DateTime(2026, 3, 14));
      notifier.updateIncidentDescription('Broken windshield');

      final didSubmit = await notifier.submit();
      final state = container.read(claimFormProvider);

      expect(didSubmit, isFalse);
      expect(state.hasSubmitted, isFalse);
      expect(state.isSubmitting, isFalse);
      expect(state.submissionError, ClaimFormSubmissionError.submissionFailed);
    });
  });
}

class _FakeClaimRepository implements ClaimRepository {
  _FakeClaimRepository({
    this.result = const Result.success(null),
    this.onSubmit,
  });

  final Result<void> result;
  final void Function(Claim claim)? onSubmit;

  @override
  ResultFuture<void> submitClaim(Claim claim) async {
    onSubmit?.call(claim);
    return result;
  }
}
