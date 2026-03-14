import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/features/claim/data/repositories/mock_claim_repository.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';
import 'package:insurance_mobile/features/claim/domain/usecases/submit_claim.dart';

final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  return const MockClaimRepository();
});

final submitClaimUseCaseProvider = Provider<SubmitClaim>((ref) {
  final repository = ref.watch(claimRepositoryProvider);

  return SubmitClaim(repository);
});
