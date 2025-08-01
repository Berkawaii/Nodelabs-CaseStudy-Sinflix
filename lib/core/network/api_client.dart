import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../logger/app_logger.dart';
import '../storage/token_storage.dart';

@singleton
class ApiClient {
  static const String baseUrl = 'https://caseapi.servicelabs.tech/';

  late final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiClient(this._tokenStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    // Token interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.getToken();
          if (token != null) {
            // API requires token without Bearer prefix
            options.headers['Authorization'] = token;
          }
          handler.next(options);
        },
      ),
    );

    // Custom logging interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          appLogger.logRequest(
            options.method,
            options.uri.toString(),
            options.headers,
            options.data,
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          appLogger.logResponse(
            response.requestOptions.method,
            response.requestOptions.uri.toString(),
            response.statusCode ?? 0,
            response.data,
          );
          handler.next(response);
        },
        onError: (error, handler) {
          appLogger.logError(
            error.requestOptions.method,
            error.requestOptions.uri.toString(),
            error.message,
          );
          handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
