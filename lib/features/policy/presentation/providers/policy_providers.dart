import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/policy/di/di.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

final policiesControllerProvider =
    AsyncNotifierProvider<PoliciesController, List<Policy>>(
      PoliciesController.new,
    );

final selectedPolicyProvider = Provider.family<AsyncValue<Policy?>, String>((
  ref,
  policyId,
) {
  final policiesAsync = ref.watch(policiesControllerProvider);

  return policiesAsync.whenData((policies) {
    for (final policy in policies) {
      if (policy.id == policyId) {
        return policy;
      }
    }

    return null;
  });
});

class PoliciesController extends AsyncNotifier<List<Policy>> {
  @override
  Future<List<Policy>> build() {
    return _loadPolicies();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadPolicies);
  }

  Future<List<Policy>> _loadPolicies() async {
    final useCase = ref.read(getPoliciesUseCaseProvider);
    final result = await useCase();

    return result.when(
      success: (policies) => policies,
      failure: (failure) => throw failure,
    );
  }
}
