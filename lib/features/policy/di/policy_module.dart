import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/di/di.dart';
import 'package:insurance_mobile/features/policy/data/datasources/policy_remote_datasource.dart';
import 'package:insurance_mobile/features/policy/data/repositories/policy_repository_impl.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';
import 'package:insurance_mobile/features/policy/domain/usecases/get_policies.dart';

final policyRemoteDatasourceProvider = Provider<PolicyRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);

  return PolicyRemoteDataSourceImpl(dio);
});

final policyRepositoryProvider = Provider<PolicyRepository>((ref) {
  final remoteDatasource = ref.watch(policyRemoteDatasourceProvider);

  return PolicyRepositoryImpl(remoteDatasource);
});

final getPoliciesUseCaseProvider = Provider<GetPolicies>((ref) {
  final repository = ref.watch(policyRepositoryProvider);

  return GetPolicies(repository);
});
