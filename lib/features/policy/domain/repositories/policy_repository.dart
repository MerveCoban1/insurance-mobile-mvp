import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

abstract class PolicyRepository {
  ResultFuture<List<Policy>> getPolicies();
}
