// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    FavoriteResponse(
      movie: FavoriteMovieData.fromJson(json['movie'] as Map<String, dynamic>),
      action: json['action'] as String,
    );

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{'movie': instance.movie, 'action': instance.action};

FavoriteMovieData _$FavoriteMovieDataFromJson(Map<String, dynamic> json) =>
    FavoriteMovieData(
      id: json['_id'] as String,
      title: json['Title'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$FavoriteMovieDataToJson(FavoriteMovieData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'Title': instance.title,
      'isFavorite': instance.isFavorite,
    };
