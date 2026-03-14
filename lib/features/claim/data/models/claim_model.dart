import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';

class ClaimModel {
  const ClaimModel({
    required this.id,
    required this.policyId,
    required this.incidentDate,
    required this.incidentDescription,
    required this.status,
  });

  final String id;
  final String policyId;
  final DateTime incidentDate;
  final String incidentDescription;
  final String status;

  factory ClaimModel.fromJson(JsonMap json) {
    return ClaimModel(
      id: json['id'] as String,
      policyId: json['policyId'] as String,
      incidentDate: DateTime.parse(json['incidentDate'] as String),
      incidentDescription: json['incidentDescription'] as String,
      status: json['status'] as String,
    );
  }

  JsonMap toJson() {
    return {
      'id': id,
      'policyId': policyId,
      'incidentDate': incidentDate.toIso8601String(),
      'incidentDescription': incidentDescription,
      'status': status,
    };
  }

  Claim toEntity() {
    return Claim(
      id: id,
      policyId: policyId,
      incidentDate: incidentDate,
      incidentDescription: incidentDescription,
      status: status,
    );
  }

  factory ClaimModel.fromEntity(Claim entity) {
    return ClaimModel(
      id: entity.id,
      policyId: entity.policyId,
      incidentDate: entity.incidentDate,
      incidentDescription: entity.incidentDescription,
      status: entity.status,
    );
  }
}
