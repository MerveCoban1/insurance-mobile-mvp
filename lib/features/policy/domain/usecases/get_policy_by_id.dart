import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';

class GetPolicyById {
  const GetPolicyById(this._repository);

  final PolicyRepository _repository;

  ResultFuture<Policy?> call(String policyId) {
    return _repository.getPolicyById(policyId);
  }
}
