import 'package:insurance_mobile/core/result/result.dart';
import 'package:insurance_mobile/features/claim/domain/entities/claim.dart';

abstract class ClaimRepository {
  ResultFuture<void> submitClaim(Claim claim);
}
