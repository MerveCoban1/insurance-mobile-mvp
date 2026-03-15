enum PolicyType { vehicle, health, home }

enum PolicyStatus { active, inactive, pending, expired }

class Policy {
  const Policy({
    required this.id,
    required this.policyNumber,
    required this.holderName,
    required this.type,
    required this.coverageAmount,
    required this.startDate,
    required this.endDate,
    this.status = PolicyStatus.active,
  });

  final String id;
  final String policyNumber;
  final String holderName;
  final PolicyType type;
  final double coverageAmount;
  final DateTime startDate;
  final DateTime endDate;
  final PolicyStatus status;
}
