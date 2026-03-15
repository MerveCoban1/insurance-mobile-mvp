import 'package:insurance_mobile/features/policy/data/models/policy_model.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

extension PolicyModelX on PolicyModel {
  Policy toEntity() {
    return Policy(
      id: id,
      policyNumber: policyNumber,
      holderName: holderName,
      type: _policyTypeFromValue(type),
      coverageAmount: coverageAmount,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

extension PolicyX on Policy {
  PolicyModel toModel() {
    return PolicyModel(
      id: id,
      policyNumber: policyNumber,
      holderName: holderName,
      type: type.name,
      coverageAmount: coverageAmount,
      status: status,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

PolicyType _policyTypeFromValue(String value) {
  final normalizedValue = value.trim().toLowerCase();

  return PolicyType.values.firstWhere(
    (type) => type.name == normalizedValue,
    orElse: () => PolicyType.vehicle,
  );
}
