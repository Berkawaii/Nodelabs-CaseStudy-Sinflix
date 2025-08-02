import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@singleton
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get analytics => _analytics;
  FirebaseAnalyticsObserver get observer => FirebaseAnalyticsObserver(analytics: _analytics);

  // Custom Events
  Future<void> logScreenView({required String screenName, String? screenClass}) async {
    await _analytics.logScreenView(screenName: screenName, screenClass: screenClass);
  }

  Future<void> logLogin({String? loginMethod}) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> logSignUp({String? signUpMethod}) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod ?? 'unknown');
  }

  Future<void> logSearch({required String searchTerm}) async {
    await _analytics.logSearch(searchTerm: searchTerm);
  }

  Future<void> logSelectContent({required String contentType, required String itemId}) async {
    await _analytics.logSelectContent(contentType: contentType, itemId: itemId);
  }

  Future<void> logShare({
    required String contentType,
    required String itemId,
    String? method,
  }) async {
    await _analytics.logShare(
      contentType: contentType,
      itemId: itemId,
      method: method ?? 'unknown',
    );
  }

  Future<void> logCustomEvent({required String name, Map<String, Object>? parameters}) async {
    // Convert boolean values to strings for Firebase Analytics compatibility
    final convertedParameters = parameters?.map((key, value) {
      if (value is bool) {
        return MapEntry(key, value.toString());
      }
      return MapEntry(key, value);
    });

    await _analytics.logEvent(name: name, parameters: convertedParameters);
  }

  // User Properties
  Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty({required String name, required String? value}) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  // Movie specific events
  Future<void> logMovieView({
    required String movieId,
    required String movieTitle,
    String? genre,
  }) async {
    await logCustomEvent(
      name: 'movie_view',
      parameters: {
        'movie_id': movieId,
        'movie_title': movieTitle,
        if (genre != null) 'genre': genre,
      },
    );
  }

  Future<void> logMovieSearch({required String query, int? resultCount}) async {
    await logCustomEvent(
      name: 'movie_search',
      parameters: {'search_query': query, if (resultCount != null) 'result_count': resultCount},
    );
  }

  Future<void> logMovieAddToFavorites({required String movieId, required String movieTitle}) async {
    await logCustomEvent(
      name: 'movie_add_to_favorites',
      parameters: {'movie_id': movieId, 'movie_title': movieTitle},
    );
  }

  Future<void> logMovieRemoveFromFavorites({
    required String movieId,
    required String movieTitle,
  }) async {
    await logCustomEvent(
      name: 'movie_remove_from_favorites',
      parameters: {'movie_id': movieId, 'movie_title': movieTitle},
    );
  }
}
