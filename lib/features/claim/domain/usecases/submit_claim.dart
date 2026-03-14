import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';
import 'package:insurance_mobile/features/claim/domain/repositories/claim_repository.dart';

class SubmitClaim {
  const SubmitClaim(this._repository);

  final ClaimRepository _repository;

  ResultFuture<void> call(Claim claim) {
    return _repository.submitClaim(claim);
  }
}
