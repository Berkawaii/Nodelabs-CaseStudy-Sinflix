// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiMovieResponseImpl _$$ApiMovieResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ApiMovieResponseImpl(
  response: ApiResponseInfo.fromJson(json['response'] as Map<String, dynamic>),
  data: MovieListResponse.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ApiMovieResponseImplToJson(
  _$ApiMovieResponseImpl instance,
) => <String, dynamic>{'response': instance.response, 'data': instance.data};

_$ApiResponseInfoImpl _$$ApiResponseInfoImplFromJson(
  Map<String, dynamic> json,
) => _$ApiResponseInfoImpl(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$$ApiResponseInfoImplToJson(
  _$ApiResponseInfoImpl instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
