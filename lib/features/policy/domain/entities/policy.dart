class Policy {
  const Policy({
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
}
