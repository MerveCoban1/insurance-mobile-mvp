import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/presentation/providers/policy_list_provider.dart';

final selectedPolicyProvider = Provider.family<AsyncValue<Policy?>, String>((
  ref,
  policyId,
) {
  final policiesAsync = ref.watch(policyListProvider);

  return policiesAsync.whenData((policies) {
    for (final policy in policies) {
      if (policy.id == policyId) {
        return policy;
      }
    }

    return null;
  });
});
