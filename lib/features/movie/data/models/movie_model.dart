import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    @JsonKey(name: '_id') required String mongoId,
    required String id,
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Year') required String year,
    @JsonKey(name: 'Rated') required String rated,
    @JsonKey(name: 'Released') required String released,
    @JsonKey(name: 'Runtime') required String runtime,
    @JsonKey(name: 'Genre') required String genre,
    @JsonKey(name: 'Director') required String director,
    @JsonKey(name: 'Writer') required String writer,
    @JsonKey(name: 'Actors') required String actors,
    @JsonKey(name: 'Plot') required String plot,
    @JsonKey(name: 'Language') required String language,
    @JsonKey(name: 'Country') required String country,
    @JsonKey(name: 'Awards') required String awards,
    @JsonKey(name: 'Poster') required String poster,
    @JsonKey(name: 'Metascore') required String metascore,
    @JsonKey(name: 'imdbRating') required String imdbRating,
    @JsonKey(name: 'imdbVotes') required String imdbVotes,
    @JsonKey(name: 'imdbID') required String imdbID,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'Response') required String response,
    @JsonKey(name: 'Images') required List<String> images,
    @JsonKey(name: 'ComingSoon') required bool comingSoon,
    @JsonKey(name: 'isFavorite') required bool isFavorite,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
}

extension MovieModelX on MovieModel {
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      year: year,
      rated: rated,
      released: released,
      runtime: runtime,
      genre: genre,
      director: director,
      writer: writer,
      actors: actors,
      plot: plot,
      language: language,
      country: country,
      awards: awards,
      poster: poster,
      metascore: metascore,
      imdbRating: imdbRating,
      imdbVotes: imdbVotes,
      imdbID: imdbID,
      type: type,
      images: images,
      comingSoon: comingSoon,
      isFavorite: isFavorite,
    );
  }
}
