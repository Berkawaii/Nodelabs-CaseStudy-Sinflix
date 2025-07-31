import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

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

  MovieBloc(this.getMoviesUseCase, this.toggleFavoriteUseCase) : super(const MovieState.initial()) {
    on<_LoadMovies>(_onLoadMovies);
    on<_LoadMoreMovies>(_onLoadMoreMovies);
    on<_RefreshMovies>(_onRefreshMovies);
    on<_ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(_LoadMovies event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading());

    final result = await getMoviesUseCase(GetMoviesParams(page: event.page));

    result.fold(
      (failure) => emit(MovieState.error(message: failure.message)),
      (movies) => emit(
        MovieState.loaded(
          movies: movies,
          hasReachedMax: movies.length < 5, // API returns 5 items per page
          currentPage: event.page,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreMovies(_LoadMoreMovies event, Emitter<MovieState> emit) async {
    final currentState = state;

    if (currentState is _Loaded) {
      if (!currentState.hasReachedMax) {
        final nextPage = currentState.currentPage + 1;
        final result = await getMoviesUseCase(GetMoviesParams(page: nextPage));

        result.fold((failure) => emit(MovieState.error(message: failure.message)), (newMovies) {
          final allMovies = [...currentState.movies, ...newMovies];
          emit(
            MovieState.loaded(
              movies: allMovies,
              hasReachedMax: newMovies.length < 5,
              currentPage: nextPage,
            ),
          );
        });
      }
    }
  }

  Future<void> _onRefreshMovies(_RefreshMovies event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading());

    final result = await getMoviesUseCase(GetMoviesParams(page: 1));

    result.fold(
      (failure) => emit(MovieState.error(message: failure.message)),
      (movies) =>
          emit(MovieState.loaded(movies: movies, hasReachedMax: movies.length < 5, currentPage: 1)),
    );
  }

  Future<void> _onToggleFavorite(_ToggleFavorite event, Emitter<MovieState> emit) async {
    final currentState = state;

    if (currentState is _Loaded) {
      // Optimistic update - immediately update UI
      final updatedMovies = currentState.movies.map((movie) {
        if (movie.id == event.movieId) {
          return Movie(
            id: movie.id,
            title: movie.title,
            year: movie.year,
            rated: movie.rated,
            released: movie.released,
            runtime: movie.runtime,
            genre: movie.genre,
            director: movie.director,
            writer: movie.writer,
            actors: movie.actors,
            plot: movie.plot,
            language: movie.language,
            country: movie.country,
            awards: movie.awards,
            poster: movie.poster,
            metascore: movie.metascore,
            imdbRating: movie.imdbRating,
            imdbVotes: movie.imdbVotes,
            imdbID: movie.imdbID,
            type: movie.type,
            images: movie.images,
            comingSoon: movie.comingSoon,
            isFavorite: !movie.isFavorite, // Toggle favorite status
          );
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

      // Make API call
      final result = await toggleFavoriteUseCase(ToggleFavoriteParams(movieId: event.movieId));

      result.fold(
        (failure) {
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
          // API call succeeded, keep the updated state
        },
      );
    }
  }
}
