import 'package:logger/logger.dart';

/// Centralized logger for the app.
///
/// Usage:
///   AppLogger.d('Debug message');
///   AppLogger.i('Info message');
///   AppLogger.w('Warning message');
///   AppLogger.e('Error message', error: e, stackTrace: st);
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.debug,
  );

  /// Log a debug message. 🐛
  static void d(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log an info message. ℹ️
  static void i(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message. ⚠️
  static void w(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message. 🚨
  static void e(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
