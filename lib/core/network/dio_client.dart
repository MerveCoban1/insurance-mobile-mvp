import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:insurance_mobile/core/config/app_config.dart';
import 'package:insurance_mobile/core/error/exceptions.dart';
import 'package:insurance_mobile/core/logging/app_logger.dart';
import 'package:insurance_mobile/core/network/api_constants.dart';

typedef TokenProvider = Future<String?> Function();

class DioClient {
  DioClient({
    required AppConfig config,
    required AppLogger logger,
    TokenProvider? tokenProvider,
  }) : _config = config,
       _logger = logger,
       _tokenProvider = tokenProvider;

  final AppConfig _config;
  final AppLogger _logger;
  final TokenProvider? _tokenProvider;

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _config.baseApiUrl,
        connectTimeout: _config.connectTimeout,
        receiveTimeout: _config.receiveTimeout,
        sendTimeout: _config.sendTimeout,
        responseType: ResponseType.json,
        contentType: ApiConstants.jsonMimeType,
        headers: const {
          ApiConstants.contentTypeHeader: ApiConstants.jsonMimeType,
          ApiConstants.acceptHeader: ApiConstants.jsonMimeType,
        },
      ),
    );

    dio.interceptors.add(_AuthInterceptor(tokenProvider: _tokenProvider));
    dio.interceptors.add(_ErrorInterceptor(logger: _logger));

    if (kDebugMode) {
      dio.interceptors.add(const _DebugLoggingInterceptor());
    }

    return dio;
  }
}

class _AuthInterceptor extends QueuedInterceptor {
  _AuthInterceptor({this.tokenProvider});

  final TokenProvider? tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider?.call();

    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] =
          '${ApiConstants.bearerPrefix} $token';
    }

    handler.next(options);
  }
}

class _ErrorInterceptor extends Interceptor {
  _ErrorInterceptor({required AppLogger logger}) : _logger = logger;

  final AppLogger _logger;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapException(err);

    _logger.error(
      'Network request failed: ${exception.message}',
      error: err,
      stackTrace: err.stackTrace,
    );

    handler.next(err.copyWith(error: exception));
  }

  AppException _mapException(DioException error) {
    final statusCode = error.response?.statusCode;

    if (statusCode == 401) {
      return const UnauthorizedException();
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(
          'A network timeout or connectivity issue occurred.',
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        return ServerException(
          'The server returned an invalid response.',
          statusCode: statusCode,
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return UnknownException(
          error.message ?? 'An unexpected network error occurred.',
          statusCode: statusCode,
        );
    }
  }
}

class _DebugLoggingInterceptor extends Interceptor {
  const _DebugLoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[Dio] ${options.method} ${options.baseUrl}${options.path}');

    if (options.data != null) {
      debugPrint('[Dio] Request body: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      '[Dio] Response ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.baseUrl}${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '[Dio] Response ${err.response?.statusCode ?? 'error'} '
      '${err.requestOptions.method} '
      '${err.requestOptions.baseUrl}${err.requestOptions.path}',
    );
    handler.next(err);
  }
}
