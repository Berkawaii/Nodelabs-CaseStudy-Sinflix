import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class CrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  FirebaseCrashlytics get crashlytics => _crashlytics;

  // Record non-fatal errors
  Future<void> recordError({
    required dynamic exception,
    StackTrace? stackTrace,
    String? reason,
    Iterable<Object> information = const [],
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      exception,
      stackTrace,
      reason: reason,
      information: information,
      fatal: fatal,
    );
  }

  // Record Flutter errors
  Future<void> recordFlutterError(FlutterErrorDetails errorDetails) async {
    await _crashlytics.recordFlutterFatalError(errorDetails);
  }

  // Log custom messages
  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  // Set user identifier
  Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  // Set custom key-value pairs
  Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  // Set user information
  Future<void> setUserInformation({required String userId, String? email, String? name}) async {
    await setUserId(userId);
    if (email != null) {
      await setCustomKey('user_email', email);
    }
    if (name != null) {
      await setCustomKey('user_name', name);
    }
  }

  // Enable/disable crashlytics collection
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }

  // Check if crashlytics is enabled
  bool isCrashlyticsCollectionEnabled() {
    return _crashlytics.isCrashlyticsCollectionEnabled;
  }

  // App-specific error logging
  Future<void> logNetworkError({
    required String endpoint,
    required int statusCode,
    String? errorMessage,
  }) async {
    await log('Network Error: $endpoint - Status: $statusCode');
    await setCustomKey('last_network_error_endpoint', endpoint);
    await setCustomKey('last_network_error_status', statusCode);

    if (errorMessage != null) {
      await recordError(
        exception: 'Network Error',
        reason: 'API call failed: $endpoint',
        information: ['Status Code: $statusCode', 'Error Message: $errorMessage'],
        fatal: false,
      );
    }
  }

  Future<void> logAuthError({required String action, required String errorMessage}) async {
    await log('Auth Error: $action - $errorMessage');
    await recordError(
      exception: 'Authentication Error',
      reason: 'Auth operation failed: $action',
      information: ['Action: $action', 'Error: $errorMessage'],
      fatal: false,
    );
  }

  Future<void> logMovieError({
    required String action,
    String? movieId,
    required String errorMessage,
  }) async {
    await log('Movie Error: $action - $errorMessage');
    await recordError(
      exception: 'Movie Operation Error',
      reason: 'Movie operation failed: $action',
      information: [
        'Action: $action',
        if (movieId != null) 'Movie ID: $movieId',
        'Error: $errorMessage',
      ],
      fatal: false,
    );
  }
}
