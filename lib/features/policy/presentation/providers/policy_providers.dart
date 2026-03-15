import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/features/policy/di/di.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

final policyDetailProvider = FutureProvider.family<Policy?, String>((
  ref,
  policyId,
) async {
  final getPolicyById = ref.watch(getPolicyByIdUseCaseProvider);
  final result = await getPolicyById(policyId);

  return result.when(
    success: (policy) => policy,
    failure: (failure) => throw PolicyDetailFailureException(failure),
  );
}, retry: (retryCount, error) => null);

class PolicyDetailFailureException implements Exception {
  const PolicyDetailFailureException(this.failure);

  final Failure failure;

  @override
  String toString() => failure.message;
}
