import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/claim/data/models/claim_json_keys.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';

part 'claim_model.freezed.dart';

@freezed
abstract class ClaimModel with _$ClaimModel {
  const ClaimModel._();

  const factory ClaimModel({
    required String id,
    required String policyId,
    required DateTime incidentDate,
    required String incidentDescription,
    required ClaimStatus status,
  }) = _ClaimModel;

  factory ClaimModel.fromJson(JsonMap json) {
    final id = json[ClaimJsonKeys.id];
    final policyId = json[ClaimJsonKeys.policyId];
    final incidentDate = json[ClaimJsonKeys.incidentDate];
    final incidentDescription = json[ClaimJsonKeys.incidentDescription];
    final status = json[ClaimJsonKeys.status];

    if (id == null ||
        policyId == null ||
        incidentDate == null ||
        incidentDescription == null ||
        status == null) {
      throw const ParsingException(
        'Claim response is missing required fields.',
      );
    }

    return ClaimModel(
      id: id.toString(),
      policyId: policyId.toString(),
      incidentDate: DateTime.parse(incidentDate as String),
      incidentDescription: incidentDescription as String,
      status: _claimStatusFromJson(status),
    );
  }

  JsonMap toJson() {
    return {
      ClaimJsonKeys.id: id,
      ClaimJsonKeys.policyId: policyId,
      ClaimJsonKeys.incidentDate: incidentDate.toIso8601String(),
      ClaimJsonKeys.incidentDescription: incidentDescription,
      ClaimJsonKeys.status: status.name,
    };
  }
}

ClaimStatus _claimStatusFromJson(Object? value) {
  final normalized = (value as String? ?? 'submitted').trim().toLowerCase();

  return ClaimStatus.values.firstWhere(
    (s) => s.name == normalized,
    orElse: () => ClaimStatus.submitted,
  );
}
