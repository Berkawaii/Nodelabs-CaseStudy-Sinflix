part of 'movie_bloc.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.initial() = _Initial;
  const factory MovieState.loading() = _Loading;
  const factory MovieState.loaded({
    required List<Movie> movies,
    required bool hasReachedMax,
    required int currentPage,
  }) = _Loaded;
  const factory MovieState.error({required String message}) = _Error;
}
