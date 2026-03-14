import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';

class GetPolicies {
  const GetPolicies(this._repository);

  final PolicyRepository _repository;

  ResultFuture<List<Policy>> call() {
    return _repository.getPolicies();
  }
}
