import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/di/di.dart';
import 'package:insurance_mobile/features/claim/data/datasources/claim_remote_datasource.dart';
import 'package:insurance_mobile/features/claim/data/repositories/claim_repository_impl.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';
import 'package:insurance_mobile/features/claim/domain/usecases/submit_claim.dart';

final claimRemoteDataSourceProvider = Provider<ClaimRemoteDataSource>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  final dio = ref.watch(dioProvider);

  return ClaimRemoteDataSourceImpl(dio, useMockApi: appConfig.useMockApi);
});

final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  final remoteDataSource = ref.watch(claimRemoteDataSourceProvider);

  return ClaimRepositoryImpl(remoteDataSource);
});

final submitClaimUseCaseProvider = Provider<SubmitClaim>((ref) {
  final repository = ref.watch(claimRepositoryProvider);

  return SubmitClaim(repository);
});
