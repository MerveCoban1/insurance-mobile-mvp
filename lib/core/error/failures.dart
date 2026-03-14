sealed class Failure {
  const Failure({required this.message, this.statusCode, this.stackTrace});

  final String message;
  final int? statusCode;
  final StackTrace? stackTrace;
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.statusCode,
    super.stackTrace,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
    super.stackTrace,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized',
    super.statusCode = 401,
    super.stackTrace,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.statusCode,
    super.stackTrace,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.statusCode,
    super.stackTrace,
  });
}

class UnexpectedFailure extends UnknownFailure {
  const UnexpectedFailure({
    required super.message,
    super.statusCode,
    super.stackTrace,
  });
}
