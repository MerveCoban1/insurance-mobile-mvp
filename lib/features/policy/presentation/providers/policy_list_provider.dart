import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/di/di.dart';

final policyListProvider = FutureProvider<List<Policy>>((ref) async {
  final getPolicies = ref.watch(getPoliciesUseCaseProvider);
  final result = await getPolicies();

  return result.when(
    success: (policies) => policies,
    failure: (failure) => throw PolicyListFailureException(failure),
  );
}, retry: (retryCount, error) => null);

class PolicyListFailureException implements Exception {
  const PolicyListFailureException(this.failure);

  final Failure failure;

  @override
  String toString() => failure.message;
}
