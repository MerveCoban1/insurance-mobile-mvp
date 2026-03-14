import 'package:dio/dio.dart';

class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() {
    return 'AppException(message: $message, statusCode: $statusCode)';
  }
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.statusCode});
}

class ServerException extends AppException {
  const ServerException(super.message, {super.statusCode});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized'])
    : super(statusCode: 401);
}

class ParsingException extends AppException {
  const ParsingException(super.message);
}

class UnknownException extends AppException {
  const UnknownException(super.message, {super.statusCode});
}

AppException normalizeException(Object error) {
  if (error is AppException) {
    return error;
  }

  if (error is DioException && error.error is AppException) {
    return error.error! as AppException;
  }

  if (error is FormatException) {
    return ParsingException(error.message);
  }

  return UnknownException(error.toString());
}
