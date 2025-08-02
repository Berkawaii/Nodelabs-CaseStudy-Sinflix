import 'package:injectable/injectable.dart';

import '../firebase/analytics_service.dart';
import '../firebase/crashlytics_service.dart';

/// Firebase servislerinin nasıl kullanılacağını gösteren örnek service
@injectable
class FirebaseExampleService {
  final AnalyticsService _analyticsService;
  final CrashlyticsService _crashlyticsService;

  FirebaseExampleService(this._analyticsService, this._crashlyticsService);

  // Analytics kullanım örnekleri
  Future<void> trackUserLogin(String method) async {
    await _analyticsService.logLogin(loginMethod: method);
  }

  Future<void> trackScreenView(String screenName) async {
    await _analyticsService.logScreenView(screenName: screenName);
  }

  Future<void> trackMovieView(String movieId, String title) async {
    await _analyticsService.logMovieView(movieId: movieId, movieTitle: title);
  }

  Future<void> trackSearch(String query, int resultCount) async {
    await _analyticsService.logMovieSearch(query: query, resultCount: resultCount);
  }

  // Crashlytics kullanım örnekleri
  Future<void> logError(dynamic error, StackTrace stackTrace) async {
    await _crashlyticsService.recordError(
      exception: error,
      stackTrace: stackTrace,
      reason: 'Example error logging',
      fatal: false,
    );
  }

  Future<void> setUserInfo(String userId, String? email) async {
    await _crashlyticsService.setUserInformation(userId: userId, email: email);
  }

  Future<void> logCustomMessage(String message) async {
    await _crashlyticsService.log(message);
  }

  // Network error örneği
  Future<void> handleNetworkError(String endpoint, int statusCode, String error) async {
    await _crashlyticsService.logNetworkError(
      endpoint: endpoint,
      statusCode: statusCode,
      errorMessage: error,
    );
  }
}
