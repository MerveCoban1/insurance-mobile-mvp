import 'package:insurance_mobile/core/error/failures.dart';

typedef ResultFuture<T> = Future<Result<T>>;

sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(Failure failure) = FailureResult<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    final result = this;

    if (result is Success<T>) {
      return success(result.data);
    }

    return failure((result as FailureResult<T>).failure);
  }
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;
}
