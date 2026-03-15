import 'package:dio/dio.dart';

import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/network/api_constants.dart';
import 'package:insurance_mobile/features/claim/data/models/claim_model.dart';

abstract class ClaimRemoteDataSource {
  Future<void> submitClaim(ClaimModel claim);
}

class ClaimRemoteDataSourceImpl implements ClaimRemoteDataSource {
  ClaimRemoteDataSourceImpl(this._dio, {required bool useMockApi})
    : _useMockApi = useMockApi;

  final Dio _dio;
  final bool _useMockApi;

  @override
  Future<void> submitClaim(ClaimModel claim) async {
    try {
      if (_dio.options.baseUrl.isEmpty) {
        throw const NetworkException('Base API URL is not configured.');
      }

      if (claim.policyId.trim().isEmpty) {
        throw const AppException('Claim requires a policy reference.');
      }

      if (_shouldUseMockResponse) {
        await Future<void>.delayed(const Duration(milliseconds: 700));
        return;
      }

      await _dio.post<void>(ApiConstants.claims, data: claim.toJson());
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
