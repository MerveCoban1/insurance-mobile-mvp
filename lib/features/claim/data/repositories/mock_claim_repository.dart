import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';

class MockClaimRepository implements ClaimRepository {
  const MockClaimRepository();

  @override
  ResultFuture<void> submitClaim(Claim claim) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return const Result.success(null);
  }
}
