enum AppEnvironment { dev, prod }

class AppConfig {
  const AppConfig({
    required this.appName,
    required this.baseApiUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.sendTimeout,
    required this.environment,
  });

  final String appName;
  final String baseApiUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Duration sendTimeout;
  final AppEnvironment environment;

  bool get isDev => environment == AppEnvironment.dev;
  bool get isProd => environment == AppEnvironment.prod;

  static const AppConfig dev = AppConfig(
    appName: 'Insurance App',
    baseApiUrl: 'https://dev.api.insurance-app.com',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
    environment: AppEnvironment.dev,
  );

  static const AppConfig prod = AppConfig(
    appName: 'Insurance App',
    baseApiUrl: 'https://api.insurance-app.com',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
    environment: AppEnvironment.prod,
  );

  factory AppConfig.fromEnvironment() {
    const environment = String.fromEnvironment('APP_ENV', defaultValue: 'dev');

    switch (environment) {
      case 'prod':
        return prod;
      case 'dev':
      default:
        return dev;
    }
  }

  AppConfig copyWith({
    String? appName,
    String? baseApiUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    AppEnvironment? environment,
  }) {
    return AppConfig(
      appName: appName ?? this.appName,
      baseApiUrl: baseApiUrl ?? this.baseApiUrl,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      environment: environment ?? this.environment,
    );
  }
}
