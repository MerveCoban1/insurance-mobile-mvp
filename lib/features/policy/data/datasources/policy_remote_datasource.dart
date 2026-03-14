import 'package:dio/dio.dart';

import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/policy/data/models/policy_model.dart';

abstract class PolicyRemoteDataSource {
  Future<List<PolicyModel>> getPolicies();
}

class PolicyRemoteDataSourceImpl implements PolicyRemoteDataSource {
  PolicyRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  static const List<JsonMap> _mockPoliciesResponse = [
    {
      'id': 'vehicle-policy',
      'policyNumber': 'PL-2026-0001',
      'holderName': 'Merve Coban',
      'productName': 'Vehicle Insurance',
      'status': 'Active',
      'effectiveDate': '2026-01-01T00:00:00.000',
      'expiryDate': '2026-12-31T23:59:59.000',
    },
    {
      'id': 'health-policy',
      'policyNumber': 'PL-2026-0002',
      'holderName': 'Merve Coban',
      'productName': 'Health Insurance',
      'status': 'Active',
      'effectiveDate': '2026-02-15T00:00:00.000',
      'expiryDate': '2027-02-14T23:59:59.000',
    },
    {
      'id': 'home-policy',
      'policyNumber': 'PL-2026-0003',
      'holderName': 'Merve Coban',
      'productName': 'Home Insurance',
      'status': 'Active',
      'effectiveDate': '2026-03-01T00:00:00.000',
      'expiryDate': '2027-02-28T23:59:59.000',
    },
  ];

  @override
  Future<List<PolicyModel>> getPolicies() async {
    try {
      if (_dio.options.baseUrl.isEmpty) {
        throw const NetworkException('Base API URL is not configured.');
      }

      await Future<void>.delayed(const Duration(milliseconds: 800));

      return _mockPoliciesResponse
          .map(PolicyModel.fromJson)
          .toList(growable: false);
    } catch (error) {
      throw normalizeException(error);
    }
  }
}
