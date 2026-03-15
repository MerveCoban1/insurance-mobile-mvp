enum ClaimStatus { submitted, inReview, approved, rejected }

class Claim {
  const Claim({
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
  final ClaimStatus status;
}
