import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/core/network/dio_client.dart';
import 'package:insurance_mobile/di/app_config_provider.dart';
import 'package:insurance_mobile/di/app_logger_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final appConfig = ref.watch(appConfigProvider);
  final logger = ref.watch(appLoggerProvider);

  return DioClient(config: appConfig, logger: logger).create();
});
