import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/policy/data/repositories/mock_policy_repository.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';
import 'package:insurance_mobile/features/policy/domain/usecases/get_policies.dart';

final policyRepositoryProvider = Provider<PolicyRepository>((ref) {
  return const MockPolicyRepository();
});

final getPoliciesUseCaseProvider = Provider<GetPolicies>((ref) {
  final repository = ref.watch(policyRepositoryProvider);

  return GetPolicies(repository);
});
