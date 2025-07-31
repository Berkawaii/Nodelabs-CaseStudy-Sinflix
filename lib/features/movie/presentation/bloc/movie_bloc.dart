import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies_usecase.dart';

part 'movie_bloc.freezed.dart';
part 'movie_event.dart';
part 'movie_state.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;

  MovieBloc(this.getMoviesUseCase) : super(const MovieState.initial()) {
    on<_LoadMovies>(_onLoadMovies);
    on<_LoadMoreMovies>(_onLoadMoreMovies);
    on<_RefreshMovies>(_onRefreshMovies);
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
    if (currentState is _Loaded && !currentState.hasReachedMax) {
      emit(const MovieState.loadingMore());

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

  Future<void> _onRefreshMovies(_RefreshMovies event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading());

    final result = await getMoviesUseCase(GetMoviesParams(page: 1));

    result.fold(
      (failure) => emit(MovieState.error(message: failure.message)),
      (movies) =>
          emit(MovieState.loaded(movies: movies, hasReachedMax: movies.length < 5, currentPage: 1)),
    );
  }
}
