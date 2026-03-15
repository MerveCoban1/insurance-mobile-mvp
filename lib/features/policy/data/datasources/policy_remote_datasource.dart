import 'package:dio/dio.dart';

import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/network/api_constants.dart';
import 'package:insurance_mobile/core/types/json_map.dart';
import 'package:insurance_mobile/features/policy/data/models/policy_model.dart';

abstract class PolicyRemoteDataSource {
  Future<List<PolicyModel>> getPolicies();
}

class PolicyRemoteDataSourceImpl implements PolicyRemoteDataSource {
  PolicyRemoteDataSourceImpl(this._dio, {required bool useMockApi})
    : _useMockApi = useMockApi;

  final Dio _dio;
  final bool _useMockApi;

  static const List<JsonMap> _mockPoliciesResponse = [
    {
      'id': 'vehicle-policy',
      'policyNumber': 'PL-2026-0001',
      'holderName': 'Merve Coban',
      'type': 'Vehicle',
      'coverageAmount': 25000,
      'status': 'active',
      'startDate': '2026-01-01T00:00:00.000',
      'endDate': '2026-12-31T23:59:59.000',
    },
    {
      'id': 'health-policy',
      'policyNumber': 'PL-2026-0002',
      'holderName': 'Merve Coban',
      'type': 'Health',
      'coverageAmount': 120000,
      'status': 'active',
      'startDate': '2026-02-15T00:00:00.000',
      'endDate': '2027-02-14T23:59:59.000',
    },
    {
      'id': 'home-policy',
      'policyNumber': 'PL-2026-0003',
      'holderName': 'Merve Coban',
      'type': 'Home',
      'coverageAmount': 350000,
      'status': 'active',
      'startDate': '2026-03-01T00:00:00.000',
      'endDate': '2027-02-28T23:59:59.000',
    },
  ];

  @override
  Future<List<PolicyModel>> getPolicies() async {
    try {
      if (_dio.options.baseUrl.isEmpty) {
        throw const NetworkException('Base API URL is not configured.');
      }

      if (_shouldUseMockResponse) {
        await Future<void>.delayed(const Duration(milliseconds: 700));

        return _mockPoliciesResponse
            .map(PolicyModel.fromJson)
            .toList(growable: false);
      }

      final response = await _dio.get<dynamic>(ApiConstants.policies);
      final responseData = response.data;

      if (responseData is! List) {
        throw const ParsingException(
          'Policies response must be returned as a JSON array.',
        );
      }

      return responseData
          .map<PolicyModel>((policyJson) {
            if (policyJson is! JsonMap) {
              throw const ParsingException(
                'Policy response items must be valid JSON objects.',
              );
            }

            return PolicyModel.fromJson(policyJson);
          })
          .toList(growable: false);
    } on AppException {
      rethrow;
    } catch (error) {
      throw normalizeException(error);
    }
  }

  bool get _shouldUseMockResponse {
    return _useMockApi;
  }
}
