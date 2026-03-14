import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';

class PolicyModel {
  const PolicyModel({
    required this.id,
    required this.policyNumber,
    required this.holderName,
    required this.productName,
    required this.status,
    required this.effectiveDate,
    required this.expiryDate,
  });

  final String id;
  final String policyNumber;
  final String holderName;
  final String productName;
  final String status;
  final DateTime effectiveDate;
  final DateTime expiryDate;

  factory PolicyModel.fromJson(JsonMap json) {
    return PolicyModel(
      id: json['id'] as String,
      policyNumber: json['policyNumber'] as String,
      holderName: json['holderName'] as String,
      productName: json['productName'] as String,
      status: json['status'] as String,
      effectiveDate: DateTime.parse(json['effectiveDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
    );
  }

  JsonMap toJson() {
    return {
      'id': id,
      'policyNumber': policyNumber,
      'holderName': holderName,
      'productName': productName,
      'status': status,
      'effectiveDate': effectiveDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  Policy toEntity() {
    return Policy(
      id: id,
      policyNumber: policyNumber,
      holderName: holderName,
      productName: productName,
      status: status,
      effectiveDate: effectiveDate,
      expiryDate: expiryDate,
    );
  }

  factory PolicyModel.fromEntity(Policy entity) {
    return PolicyModel(
      id: entity.id,
      policyNumber: entity.policyNumber,
      holderName: entity.holderName,
      productName: entity.productName,
      status: entity.status,
      effectiveDate: entity.effectiveDate,
      expiryDate: entity.expiryDate,
    );
  }
}
