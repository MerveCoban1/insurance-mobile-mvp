import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

class PolicyModel {
  const PolicyModel({
    required this.id,
    required this.policyNumber,
    required this.holderName,
    required this.type,
    required this.coverageAmount,
    required this.startDate,
    required this.endDate,
    this.status = 'active',
  });

  final String id;
  final String policyNumber;
  final String holderName;
  final String type;
  final double coverageAmount;
  final String status;
  final DateTime startDate;
  final DateTime endDate;

  factory PolicyModel.fromJson(JsonMap json) {
    return PolicyModel(
      id: json['id'] as String,
      policyNumber: json['policyNumber'] as String,
      holderName: json['holderName'] as String,
      type: json['type'] as String,
      coverageAmount: (json['coverageAmount'] as num).toDouble(),
      status: json['status'] as String? ?? 'active',
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  JsonMap toJson() {
    return {
      'id': id,
      'policyNumber': policyNumber,
      'holderName': holderName,
      'type': type,
      'coverageAmount': coverageAmount,
      'status': status,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

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

  factory PolicyModel.fromEntity(Policy entity) {
    return PolicyModel(
      id: entity.id,
      policyNumber: entity.policyNumber,
      holderName: entity.holderName,
      type: entity.type.name,
      coverageAmount: entity.coverageAmount,
      status: entity.status,
      startDate: entity.startDate,
      endDate: entity.endDate,
    );
  }
}

PolicyType _policyTypeFromValue(String value) {
  return PolicyType.values.firstWhere(
    (type) => type.name == value,
    orElse: () => PolicyType.vehicle,
  );
}
