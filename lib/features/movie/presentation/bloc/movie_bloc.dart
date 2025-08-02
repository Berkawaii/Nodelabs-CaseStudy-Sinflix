import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/firebase/analytics_service.dart';
import '../../../../core/firebase/crashlytics_service.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

part 'movie_bloc.freezed.dart';
part 'movie_event.dart';
part 'movie_state.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final AnalyticsService _analyticsService;
  final CrashlyticsService _crashlyticsService;

  MovieBloc(
    this.getMoviesUseCase,
    this.toggleFavoriteUseCase,
    this._analyticsService,
    this._crashlyticsService,
  ) : super(const MovieState.initial()) {
    on<_LoadMovies>(_onLoadMovies);
    on<_LoadMoreMovies>(_onLoadMoreMovies);
    on<_RefreshMovies>(_onRefreshMovies);
    on<_ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(_LoadMovies event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading());

    try {
      final result = await getMoviesUseCase(GetMoviesParams(page: event.page));

      result.fold(
        (failure) {
          // Firebase Analytics - movie load failure
          _analyticsService.logCustomEvent(
            name: 'movie_load_failed',
            parameters: {'page': event.page, 'error_message': failure.message},
          );
          // Firebase Crashlytics - movie error
          _crashlyticsService.logMovieError(action: 'load_movies', errorMessage: failure.message);
          emit(MovieState.error(message: failure.message));
        },
        (movies) {
          // Firebase Analytics - successful movie load
          _analyticsService.logCustomEvent(
            name: 'movies_loaded',
            parameters: {
              'page': event.page,
              'movie_count': movies.length,
              'has_reached_max': movies.length < 5,
            },
          );
          emit(
            MovieState.loaded(
              movies: movies,
              hasReachedMax: movies.length < 5, // API returns 5 items per page
              currentPage: event.page,
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      // Firebase Crashlytics - unexpected error
      _crashlyticsService.recordError(
        exception: error,
        stackTrace: stackTrace,
        reason: 'Unexpected error during movie loading',
        fatal: false,
      );
      emit(MovieState.error(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onLoadMoreMovies(_LoadMoreMovies event, Emitter<MovieState> emit) async {
    final currentState = state;

    if (currentState is _Loaded) {
      if (!currentState.hasReachedMax) {
        try {
          final nextPage = currentState.currentPage + 1;
          final result = await getMoviesUseCase(GetMoviesParams(page: nextPage));

          result.fold(
            (failure) {
              // Firebase Analytics - load more failure
              _analyticsService.logCustomEvent(
                name: 'load_more_movies_failed',
                parameters: {
                  'page': nextPage,
                  'current_movie_count': currentState.movies.length,
                  'error_message': failure.message,
                },
              );
              // Firebase Crashlytics - load more error
              _crashlyticsService.logMovieError(
                action: 'load_more_movies',
                errorMessage: failure.message,
              );
              emit(MovieState.error(message: failure.message));
            },
            (newMovies) {
              final allMovies = [...currentState.movies, ...newMovies];
              // Firebase Analytics - successful load more
              _analyticsService.logCustomEvent(
                name: 'more_movies_loaded',
                parameters: {
                  'page': nextPage,
                  'new_movie_count': newMovies.length,
                  'total_movie_count': allMovies.length,
                  'has_reached_max': newMovies.length < 5,
                },
              );
              emit(
                MovieState.loaded(
                  movies: allMovies,
                  hasReachedMax: newMovies.length < 5,
                  currentPage: nextPage,
                ),
              );
            },
          );
        } catch (error, stackTrace) {
          // Firebase Crashlytics - unexpected error
          _crashlyticsService.recordError(
            exception: error,
            stackTrace: stackTrace,
            reason: 'Unexpected error during load more movies',
            fatal: false,
          );
          emit(MovieState.error(message: 'An unexpected error occurred'));
        }
      }
    }
  }

  Future<void> _onRefreshMovies(_RefreshMovies event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading());

    try {
      // Firebase Analytics - refresh action
      _analyticsService.logCustomEvent(
        name: 'movies_refresh_initiated',
        parameters: {'refresh_type': 'pull_to_refresh'},
      );

      final result = await getMoviesUseCase(GetMoviesParams(page: 1));

      result.fold(
        (failure) {
          // Firebase Analytics - refresh failure
          _analyticsService.logCustomEvent(
            name: 'movies_refresh_failed',
            parameters: {'error_message': failure.message},
          );
          // Firebase Crashlytics - refresh error
          _crashlyticsService.logMovieError(
            action: 'refresh_movies',
            errorMessage: failure.message,
          );
          emit(MovieState.error(message: failure.message));
        },
        (movies) {
          // Firebase Analytics - successful refresh
          _analyticsService.logCustomEvent(
            name: 'movies_refreshed',
            parameters: {'movie_count': movies.length, 'has_reached_max': movies.length < 5},
          );
          emit(MovieState.loaded(movies: movies, hasReachedMax: movies.length < 5, currentPage: 1));
        },
      );
    } catch (error, stackTrace) {
      // Firebase Crashlytics - unexpected error
      _crashlyticsService.recordError(
        exception: error,
        stackTrace: stackTrace,
        reason: 'Unexpected error during movies refresh',
        fatal: false,
      );
      emit(MovieState.error(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onToggleFavorite(_ToggleFavorite event, Emitter<MovieState> emit) async {
    final currentState = state;

    if (currentState is _Loaded) {
      // Find the movie to get its details for analytics
      final movie = currentState.movies.firstWhere((m) => m.id == event.movieId);
      final willBeFavorite = !movie.isFavorite;

      // Optimistic update - immediately update UI
      final updatedMovies = currentState.movies.map((movie) {
        if (movie.id == event.movieId) {
          return movie.copyWith(isFavorite: !movie.isFavorite);
        }
        return movie;
      }).toList();

      emit(
        MovieState.loaded(
          movies: updatedMovies,
          hasReachedMax: currentState.hasReachedMax,
          currentPage: currentState.currentPage,
        ),
      );

      try {
        // Make API call
        final result = await toggleFavoriteUseCase(ToggleFavoriteParams(movieId: event.movieId));

        result.fold(
          (failure) {
            // Firebase Analytics - favorite toggle failure
            _analyticsService.logCustomEvent(
              name: 'favorite_toggle_failed',
              parameters: {
                'movie_id': event.movieId,
                'movie_title': movie.title,
                'action': willBeFavorite ? 'add' : 'remove',
                'error_message': failure.message,
              },
            );
            // Firebase Crashlytics - favorite error
            _crashlyticsService.logMovieError(
              action: 'toggle_favorite',
              movieId: event.movieId,
              errorMessage: failure.message,
            );
            // Revert optimistic update on failure
            emit(
              MovieState.loaded(
                movies: currentState.movies,
                hasReachedMax: currentState.hasReachedMax,
                currentPage: currentState.currentPage,
              ),
            );
          },
          (success) {
            // Firebase Analytics - successful favorite toggle
            if (willBeFavorite) {
              _analyticsService.logMovieAddToFavorites(
                movieId: event.movieId,
                movieTitle: movie.title,
              );
            } else {
              _analyticsService.logMovieRemoveFromFavorites(
                movieId: event.movieId,
                movieTitle: movie.title,
              );
            }
            // API call succeeded, keep the updated state
          },
        );
      } catch (error, stackTrace) {
        // Firebase Crashlytics - unexpected error
        _crashlyticsService.recordError(
          exception: error,
          stackTrace: stackTrace,
          reason: 'Unexpected error during favorite toggle',
          information: [
            'Movie ID: ${event.movieId}',
            'Movie Title: ${movie.title}',
            'Action: ${willBeFavorite ? 'add' : 'remove'}',
          ],
          fatal: false,
        );
        // Revert optimistic update on unexpected error
        emit(
          MovieState.loaded(
            movies: currentState.movies,
            hasReachedMax: currentState.hasReachedMax,
            currentPage: currentState.currentPage,
          ),
        );
      }
    }
  }
}
