import 'package:dio/dio.dart';

import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/features/claim/data/models/claim_model.dart';

abstract class ClaimRemoteDataSource {
  Future<void> submitClaim(ClaimModel claim);
}

class ClaimRemoteDataSourceImpl implements ClaimRemoteDataSource {
  ClaimRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> submitClaim(ClaimModel claim) async {
    try {
      if (_dio.options.baseUrl.isEmpty) {
        throw const NetworkException('Base API URL is not configured.');
      }

      if (claim.policyId.trim().isEmpty) {
        throw const AppException('Claim requires a policy reference.');
      }

      await Future<void>.delayed(const Duration(milliseconds: 700));
    } catch (error) {
      throw normalizeException(error);
    }
  }
}
