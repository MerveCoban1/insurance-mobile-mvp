import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_mobile/app/app.dart';
import 'package:insurance_mobile/core/core.dart';

void main() {
  const logger = AppLogger();

  FlutterError.onError = (FlutterErrorDetails details) {
    logger.error(
      'FlutterError: ${details.exceptionAsString()}',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const ProviderScope(child: InsuranceApp()));
    },
    (Object error, StackTrace stackTrace) {
      logger.error(
        'Uncaught async error',
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}
