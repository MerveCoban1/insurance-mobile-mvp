import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/error/failure_mapper.dart';
import 'package:insurance_mobile/core/error/failures.dart';
import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/policy/data/datasources/policy_remote_datasource.dart';
import 'package:insurance_mobile/features/policy/data/mappers/policy_mapper.dart';
import 'package:insurance_mobile/features/policy/domain/entities/policy.dart';
import 'package:insurance_mobile/features/policy/domain/repositories/policy_repository.dart';

class PolicyRepositoryImpl implements PolicyRepository {
  const PolicyRepositoryImpl(this._remoteDataSource);

  final PolicyRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Policy>> getPolicies() async {
    try {
      final models = await _remoteDataSource.getPolicies();

      return Result.success(
        models.map((model) => model.toEntity()).toList(growable: false),
      );
    } on AppException catch (exception, stackTrace) {
      return Result.failure(
        FailureMapper.fromException(exception, stackTrace: stackTrace),
      );
    } catch (error, stackTrace) {
      return Result.failure(
        UnknownFailure(message: error.toString(), stackTrace: stackTrace),
      );
    }
  }

  @override
  ResultFuture<Policy?> getPolicyById(String policyId) async {
    if (policyId.trim().isEmpty) {
      return const Result.failure(
        ValidationFailure(message: 'Policy id is required.'),
      );
    }

    try {
      final models = await _remoteDataSource.getPolicies();

      for (final model in models) {
        if (model.id == policyId) {
          return Result.success(model.toEntity());
        }
      }

      return const Result<Policy?>.success(null);
    } on AppException catch (exception, stackTrace) {
      return Result.failure(
        FailureMapper.fromException(exception, stackTrace: stackTrace),
      );
    } catch (error, stackTrace) {
      return Result.failure(
        UnknownFailure(message: error.toString(), stackTrace: stackTrace),
      );
    }
  }
}
