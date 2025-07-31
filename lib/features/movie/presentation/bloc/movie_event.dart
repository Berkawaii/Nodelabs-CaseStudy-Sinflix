part of 'movie_bloc.dart';

@freezed
class MovieEvent with _$MovieEvent {
  const factory MovieEvent.loadMovies({@Default(1) int page}) = _LoadMovies;
  const factory MovieEvent.loadMoreMovies() = _LoadMoreMovies;
  const factory MovieEvent.refreshMovies() = _RefreshMovies;
}
