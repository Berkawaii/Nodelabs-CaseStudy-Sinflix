import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie_list_response.dart';

part 'api_movie_response.freezed.dart';
part 'api_movie_response.g.dart';

@freezed
class ApiMovieResponse with _$ApiMovieResponse {
  const factory ApiMovieResponse({
    required ApiResponseInfo response,
    required MovieListResponse data,
  }) = _ApiMovieResponse;

  factory ApiMovieResponse.fromJson(Map<String, dynamic> json) => _$ApiMovieResponseFromJson(json);
}

@freezed
class ApiResponseInfo with _$ApiResponseInfo {
  const factory ApiResponseInfo({required int code, required String message}) = _ApiResponseInfo;

  factory ApiResponseInfo.fromJson(Map<String, dynamic> json) => _$ApiResponseInfoFromJson(json);
}
