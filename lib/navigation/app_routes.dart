abstract final class AppRoutes {
  static const String policiesName = 'policies';
  static const String policyDetailName = 'policyDetail';
  static const String claimFormName = 'claimForm';
  static const String claimSuccessName = 'claimSuccess';

  static const String policiesPath = '/policies';
  static const String policyDetailPath = '/policies/:policyId';
  static const String claimFormPath = '/claims/new/:policyId';
  static const String claimSuccessPath = '/claims/success';

  static String policyDetailLocation(String policyId) => '/policies/$policyId';

  static String claimFormLocation(String policyId) {
    assert(policyId.trim().isNotEmpty, 'policyId cannot be empty.');

    return '/claims/new/$policyId';
  }

  static String claimSuccessLocation() => claimSuccessPath;
}
