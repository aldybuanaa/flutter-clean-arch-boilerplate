import 'package:dio/dio.dart';

import '../storage/local_storage.dart';
import '../utils/app_logger.dart';

/// Interceptor that injects the Authorization token into every request.
class AuthInterceptor extends Interceptor {
  final LocalStorage storage;

  AuthInterceptor({required this.storage});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.getString(StorageKeys.authToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AppLogger.w('401 Unauthorized – token may be expired');
      // TODO: Implement token refresh logic here
    }
    handler.next(err);
  }
}

/// Interceptor that logs all HTTP requests and responses.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d(
      '→ [${options.method}] ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Body: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i(
      '← [${response.statusCode}] ${response.requestOptions.uri}\n'
      'Data: ${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e(
      '✗ [${err.response?.statusCode}] ${err.requestOptions.uri}\n'
      'Error: ${err.message}',
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}

/// Interceptor for global error handling (e.g. 500, network failure).
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    switch (statusCode) {
      case 400:
        AppLogger.w('Bad Request (400): ${err.requestOptions.uri}');
        break;
      case 401:
        AppLogger.w('Unauthorized (401): ${err.requestOptions.uri}');
        break;
      case 403:
        AppLogger.w('Forbidden (403): ${err.requestOptions.uri}');
        break;
      case 404:
        AppLogger.w('Not Found (404): ${err.requestOptions.uri}');
        break;
      case 500:
        AppLogger.e('Server Error (500): ${err.requestOptions.uri}');
        break;
      default:
        if (err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout) {
          AppLogger.e('Connection Timeout: ${err.requestOptions.uri}');
        } else if (err.type == DioExceptionType.connectionError) {
          AppLogger.e('No internet connection');
        }
        break;
    }

    handler.next(err);
  }
}
