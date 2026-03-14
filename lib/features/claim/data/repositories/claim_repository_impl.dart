import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/error/failure_mapper.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/claim/data/datasources/claim_remote_datasource.dart';
import 'package:insurance_mobile/features/claim/data/models/claim_model.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';

class ClaimRepositoryImpl implements ClaimRepository {
  const ClaimRepositoryImpl(this._remoteDataSource);

  final ClaimRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> submitClaim(Claim claim) async {
    try {
      await _remoteDataSource.submitClaim(ClaimModel.fromEntity(claim));

      return const Result.success(null);
    } on AppException catch (exception, stackTrace) {
      return Result.failure(
        FailureMapper.fromException(exception, stackTrace: stackTrace),
      );
    } catch (error, stackTrace) {
      return Result.failure(
        UnexpectedFailure(message: error.toString(), stackTrace: stackTrace),
      );
    }
  }
}
