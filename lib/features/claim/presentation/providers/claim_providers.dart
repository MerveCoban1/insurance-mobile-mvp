import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/claim/di/di.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';

final claimFormControllerProvider =
    NotifierProvider<ClaimFormController, ClaimFormState>(
      ClaimFormController.new,
    );

class ClaimFormController extends Notifier<ClaimFormState> {
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
    state = state.copyWith(incidentDate: value, submissionError: null);
  }

  void updateIncidentDescription(String value) {
    state = state.copyWith(
      incidentDescription: value,
      submissionError: null,
      hasSubmitted: false,
    );
  }

  String? validateIncidentDate() {
    if (state.incidentDate == null) {
      return 'Incident date is required.';
    }

    return null;
  }

  String? validateIncidentDescription() {
    if (state.incidentDescription.trim().isEmpty) {
      return 'Incident description is required.';
    }

    return null;
  }

  Future<bool> submit() async {
    final validationError =
        _validatePolicyId() ??
        validateIncidentDate() ??
        validateIncidentDescription();

    if (validationError != null) {
      state = state.copyWith(
        submissionError: validationError,
        hasSubmitted: false,
      );
      return false;
    }

    state = state.copyWith(
      isSubmitting: true,
      submissionError: null,
      hasSubmitted: false,
    );

    final useCase = ref.read(submitClaimUseCaseProvider);
    final claim = Claim(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      policyId: state.policyId!,
      incidentDate: state.incidentDate!,
      incidentDescription: state.incidentDescription.trim(),
      status: 'submitted',
    );
    final result = await useCase(claim);

    return result.when(
      success: (_) {
        state = state.copyWith(
          isSubmitting: false,
          submissionError: null,
          hasSubmitted: true,
        );
        return true;
      },
      failure: (failure) {
        state = state.copyWith(
          isSubmitting: false,
          submissionError: failure.message,
          hasSubmitted: false,
        );
        return false;
      },
    );
  }

  String? _validatePolicyId() {
    final policyId = state.policyId;

    if (policyId == null || policyId.trim().isEmpty) {
      return 'Policy reference is required.';
    }

    return null;
  }
}

class ClaimFormState {
  const ClaimFormState({
    this.policyId,
    this.incidentDate,
    this.incidentDescription = '',
    this.isSubmitting = false,
    this.submissionError,
    this.hasSubmitted = false,
  });

  final String? policyId;
  final DateTime? incidentDate;
  final String incidentDescription;
  final bool isSubmitting;
  final String? submissionError;
  final bool hasSubmitted;

  ClaimFormState copyWith({
    String? policyId,
    Object? incidentDate = _unset,
    String? incidentDescription,
    bool? isSubmitting,
    Object? submissionError = _unset,
    bool? hasSubmitted,
  }) {
    return ClaimFormState(
      policyId: policyId ?? this.policyId,
      incidentDate: incidentDate == _unset
          ? this.incidentDate
          : incidentDate as DateTime?,
      incidentDescription: incidentDescription ?? this.incidentDescription,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionError: submissionError == _unset
          ? this.submissionError
          : submissionError as String?,
      hasSubmitted: hasSubmitted ?? this.hasSubmitted,
    );
  }
}

const _unset = Object();
