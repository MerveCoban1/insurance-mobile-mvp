import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/claim/di/di.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';
import 'package:insurance_mobile/features/claim/domain/usecases/submit_claim.dart';

final claimFormProvider = NotifierProvider<ClaimFormNotifier, ClaimFormState>(
  ClaimFormNotifier.new,
);

class ClaimFormNotifier extends Notifier<ClaimFormState> {
  late final SubmitClaim _submitClaim = ref.read(submitClaimUseCaseProvider);

  @override
  ClaimFormState build() {
    return const ClaimFormState();
  }

  void initialize({String? policyId}) {
    if (policyId == null || policyId == state.policyId) {
      return;
    }

    state = state.copyWith(policyId: policyId);
  }

  void updateIncidentDate(DateTime? value) {
    state = state.copyWith(
      incidentDate: value,
      hasAttemptedSubmit: false,
      submissionError: ClaimFormSubmissionError.none,
    );
  }

  void updateIncidentDescription(String value) {
    state = state.copyWith(
      incidentDescription: value,
      hasAttemptedSubmit: false,
      submissionError: ClaimFormSubmissionError.none,
    );
  }

  Future<bool> submit() async {
    final isDateValid = state.incidentDate != null;
    final isDescriptionValid = state.incidentDescription.trim().isNotEmpty;

    if (!isDateValid || !isDescriptionValid || state.policyId == null) {
      state = state.copyWith(
        hasAttemptedSubmit: true,
        submissionError: state.policyId == null
            ? ClaimFormSubmissionError.missingPolicyReference
            : ClaimFormSubmissionError.none,
      );
      return false;
    }

    state = state.copyWith(
      isSubmitting: true,
      hasAttemptedSubmit: false,
      submissionError: ClaimFormSubmissionError.none,
      hasSubmitted: false,
    );

    final result = await _submitClaim(
      Claim(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        policyId: state.policyId!,
        incidentDate: state.incidentDate!,
        incidentDescription: state.incidentDescription.trim(),
        status: 'submitted',
      ),
    );

    return result.when(
      success: (_) {
        state = state.copyWith(
          isSubmitting: false,
          hasSubmitted: true,
          submissionError: ClaimFormSubmissionError.none,
        );
        return true;
      },
      failure: (_) {
        state = state.copyWith(
          isSubmitting: false,
          hasSubmitted: false,
          submissionError: ClaimFormSubmissionError.submissionFailed,
        );
        return false;
      },
    );
  }
}

enum ClaimFormSubmissionError { none, missingPolicyReference, submissionFailed }

class ClaimFormState {
  const ClaimFormState({
    this.policyId,
    this.incidentDate,
    this.incidentDescription = '',
    this.isSubmitting = false,
    this.hasAttemptedSubmit = false,
    this.hasSubmitted = false,
    this.submissionError = ClaimFormSubmissionError.none,
  });

  final String? policyId;
  final DateTime? incidentDate;
  final String incidentDescription;
  final bool isSubmitting;
  final bool hasAttemptedSubmit;
  final bool hasSubmitted;
  final ClaimFormSubmissionError submissionError;

  ClaimFormState copyWith({
    String? policyId,
    Object? incidentDate = _unset,
    String? incidentDescription,
    bool? isSubmitting,
    bool? hasAttemptedSubmit,
    bool? hasSubmitted,
    ClaimFormSubmissionError? submissionError,
  }) {
    return ClaimFormState(
      policyId: policyId ?? this.policyId,
      incidentDate: incidentDate == _unset
          ? this.incidentDate
          : incidentDate as DateTime?,
      incidentDescription: incidentDescription ?? this.incidentDescription,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      hasAttemptedSubmit: hasAttemptedSubmit ?? this.hasAttemptedSubmit,
      hasSubmitted: hasSubmitted ?? this.hasSubmitted,
      submissionError: submissionError ?? this.submissionError,
    );
  }
}

const _unset = Object();
