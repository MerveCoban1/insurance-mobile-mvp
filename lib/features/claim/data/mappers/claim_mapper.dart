import 'package:insurance_mobile/features/claim/data/models/claim_model.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';

extension ClaimModelX on ClaimModel {
  Claim toEntity() {
    return Claim(
      id: id,
      policyId: policyId,
      incidentDate: incidentDate,
      incidentDescription: incidentDescription,
      status: status,
    );
  }
}

extension ClaimX on Claim {
  ClaimModel toModel() {
    return ClaimModel(
      id: id,
      policyId: policyId,
      incidentDate: incidentDate,
      incidentDescription: incidentDescription,
      status: status,
    );
  }
}
