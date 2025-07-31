// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieListResponseImpl _$$MovieListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MovieListResponseImpl(
  movies: (json['movies'] as List<dynamic>)
      .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: PaginationModel.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$MovieListResponseImplToJson(
  _$MovieListResponseImpl instance,
) => <String, dynamic>{
  'movies': instance.movies,
  'pagination': instance.pagination,
};
