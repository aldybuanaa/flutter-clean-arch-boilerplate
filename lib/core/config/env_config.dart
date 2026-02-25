/// Environment configuration loaded via `--dart-define` flags.
///
/// Usage when running:
///   flutter run --dart-define=ENV=dev --dart-define=BASE_URL=https://api.dev.example.com
///
/// Available environments: dev, staging, prod
class EnvConfig {
  EnvConfig._();

  /// Current environment: 'dev' | 'staging' | 'prod'
  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

  /// Base URL for API calls.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.dev.example.com',
  );

  /// App display name (can differ per environment).
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter App (Dev)',
  );

  static bool get isDev => env == 'dev';
  static bool get isStaging => env == 'staging';
  static bool get isProd => env == 'prod';
}
