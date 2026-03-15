import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/di/di.dart';
import 'package:insurance_mobile/features/policy/data/datasources/policy_remote_datasource.dart';
import 'package:insurance_mobile/features/policy/data/repositories/policy_repository_impl.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';
import 'package:insurance_mobile/features/policy/domain/usecases/get_policy_by_id.dart';
import 'package:insurance_mobile/features/policy/domain/usecases/get_policies.dart';

final policyRemoteDatasourceProvider = Provider<PolicyRemoteDataSource>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  final dio = ref.watch(dioProvider);

  return PolicyRemoteDataSourceImpl(dio, useMockApi: appConfig.useMockApi);
});

final policyRepositoryProvider = Provider<PolicyRepository>((ref) {
  final remoteDatasource = ref.watch(policyRemoteDatasourceProvider);

  return PolicyRepositoryImpl(remoteDatasource);
});

final getPoliciesUseCaseProvider = Provider<GetPolicies>((ref) {
  final repository = ref.watch(policyRepositoryProvider);

  return GetPolicies(repository);
});

final getPolicyByIdUseCaseProvider = Provider<GetPolicyById>((ref) {
  final repository = ref.watch(policyRepositoryProvider);

  return GetPolicyById(repository);
});
