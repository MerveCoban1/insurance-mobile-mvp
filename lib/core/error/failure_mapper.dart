import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/error/failures.dart';

abstract final class FailureMapper {
  static Failure fromException(
    AppException exception, {
    StackTrace? stackTrace,
  }) {
    return switch (exception) {
      NetworkException() => NetworkFailure(
        message: exception.message,
        statusCode: exception.statusCode,
        stackTrace: stackTrace,
      ),
      ServerException() => ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
        stackTrace: stackTrace,
      ),
      UnauthorizedException() => UnauthorizedFailure(
        message: exception.message,
        stackTrace: stackTrace,
      ),
      ParsingException() => UnexpectedFailure(
        message: exception.message,
        statusCode: exception.statusCode,
        stackTrace: stackTrace,
      ),
      _ => UnexpectedFailure(
        message: exception.message,
        statusCode: exception.statusCode,
        stackTrace: stackTrace,
      ),
    };
  }
}
