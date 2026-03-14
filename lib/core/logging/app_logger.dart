import 'package:flutter/foundation.dart';

class AppLogger {
  const AppLogger();

  void info(String message) => _log('INFO', message);

  void warning(String message) => _log('WARNING', message);

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log('ERROR', message);

    if (error != null) {
      debugPrint('[ERROR] details: $error');
    }

    if (stackTrace != null) {
      debugPrint('[ERROR] stackTrace: $stackTrace');
    }
  }

  void _log(String level, String message) {
    debugPrint('[$level] $message');
  }
}
