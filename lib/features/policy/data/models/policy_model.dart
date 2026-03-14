import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/core/error/exceptions.dart';
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
    final id = json['id'];
    final startDateValue = json['startDate'] ?? json['effectiveDate'];
    final endDateValue = json['endDate'] ?? json['expiryDate'];
    final typeValue = json['type'] ?? json['productName'];
    final coverageAmount = json['coverageAmount'];

    if (id == null ||
        startDateValue == null ||
        endDateValue == null ||
        coverageAmount is! num) {
      throw const ParsingException(
        'Policy response is missing required fields.',
      );
    }

    return PolicyModel(
      id: id.toString(),
      policyNumber: (json['policyNumber'] as String?) ?? 'POL-${id.toString()}',
      holderName: (json['holderName'] as String?) ?? 'Policy Holder',
      type: (typeValue as String?) ?? PolicyType.vehicle.name,
      coverageAmount: coverageAmount.toDouble(),
      status: (json['status'] as String? ?? 'active').toLowerCase(),
      startDate: DateTime.parse(startDateValue as String),
      endDate: DateTime.parse(endDateValue as String),
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
  final normalizedValue = value.trim().toLowerCase();

  return PolicyType.values.firstWhere(
    (type) => type.name == normalizedValue,
    orElse: () => PolicyType.vehicle,
  );
}
