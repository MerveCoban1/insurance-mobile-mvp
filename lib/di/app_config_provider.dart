import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/core/config/app_config.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});
