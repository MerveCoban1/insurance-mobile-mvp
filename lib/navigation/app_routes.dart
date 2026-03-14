abstract final class AppRoutes {
  static const String policiesName = 'policies';
  static const String policyDetailName = 'policyDetail';
  static const String claimFormName = 'claimForm';
  static const String claimSuccessName = 'claimSuccess';

  static const String policiesPath = '/policies';
  static const String policyDetailPath = '/policies/:policyId';
  static const String claimFormPath = '/claims/new';
  static const String claimSuccessPath = '/claims/success';

  static String policyDetailLocation(String policyId) => '/policies/$policyId';

  static String claimFormLocation({String? policyId}) {
    return Uri(
      path: claimFormPath,
      queryParameters: policyId == null ? null : {'policyId': policyId},
    ).toString();
  }

  static String claimSuccessLocation() => claimSuccessPath;
}
