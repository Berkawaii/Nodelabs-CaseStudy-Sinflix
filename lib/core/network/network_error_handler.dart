import 'package:dio/dio.dart';
import '../error/failures.dart';

class NetworkErrorHandler {
  static Failure handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ConnectionFailure('Connection timeout');

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode ?? 0,
          error.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('Request cancelled');

      case DioExceptionType.connectionError:
        return const ConnectionFailure('No internet connection');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Certificate error');

      case DioExceptionType.unknown:
        return const ServerFailure('An unexpected error occurred');
    }
  }

  static Failure _handleStatusCode(int statusCode, dynamic responseData) {
    String message = 'Server error';

    // API'den gelen hata mesajını parse et
    if (responseData is Map<String, dynamic>) {
      message =
          responseData['message'] ??
          responseData['error'] ??
          responseData['detail'] ??
          message;
    }

    switch (statusCode) {
      case 400:
        return ValidationFailure(message);
      case 401:
        return ServerFailure('Unauthorized: $message');
      case 403:
        return ServerFailure('Forbidden: $message');
      case 404:
        return ServerFailure('Not found: $message');
      case 500:
        return ServerFailure('Internal server error: $message');
      default:
        return ServerFailure('Server error ($statusCode): $message');
    }
  }
}
