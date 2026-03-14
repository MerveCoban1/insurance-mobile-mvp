import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';

class MockPolicyRepository implements PolicyRepository {
  const MockPolicyRepository();

  static final List<Policy> _policies = [
    Policy(
      id: 'vehicle-policy',
      policyNumber: 'PL-2026-0001',
      holderName: 'Merve Coban',
      type: PolicyType.vehicle,
      coverageAmount: 25000,
      startDate: DateTime(2026, 1, 1),
      endDate: DateTime(2026, 12, 31),
    ),
    Policy(
      id: 'health-policy',
      policyNumber: 'PL-2026-0002',
      holderName: 'Merve Coban',
      type: PolicyType.health,
      coverageAmount: 120000,
      startDate: DateTime(2026, 2, 15),
      endDate: DateTime(2027, 2, 14),
    ),
    Policy(
      id: 'home-policy',
      policyNumber: 'PL-2026-0003',
      holderName: 'Merve Coban',
      type: PolicyType.home,
      coverageAmount: 350000,
      startDate: DateTime(2026, 3, 1),
      endDate: DateTime(2027, 2, 28),
    ),
  ];

  @override
  ResultFuture<List<Policy>> getPolicies() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    return Result.success(List.unmodifiable(_policies));
  }
}
