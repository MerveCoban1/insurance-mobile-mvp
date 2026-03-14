import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/policy/di/di.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

final policyListProvider = FutureProvider<List<Policy>>((ref) async {
  final repository = ref.read(policyRepositoryProvider);
  final result = await repository.getPolicies();

  return result.when(
    success: (policies) => policies,
    failure: (failure) => throw Exception(failure.message),
  );
}, retry: (retryCount, error) => null);
