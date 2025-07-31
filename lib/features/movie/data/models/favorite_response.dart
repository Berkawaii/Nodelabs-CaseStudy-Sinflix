import 'package:json_annotation/json_annotation.dart';

part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse {
  final FavoriteMovieData movie;
  final String action;

  const FavoriteResponse({required this.movie, required this.action});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => _$FavoriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
}

@JsonSerializable()
class FavoriteMovieData {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'Title')
  final String title;
  final bool isFavorite;

  const FavoriteMovieData({required this.id, required this.title, required this.isFavorite});

  factory FavoriteMovieData.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMovieDataToJson(this);
}
