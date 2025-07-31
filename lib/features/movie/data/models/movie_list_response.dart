import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie_model.dart';
import 'pagination_model.dart';

part 'movie_list_response.freezed.dart';
part 'movie_list_response.g.dart';

@freezed
class MovieListResponse with _$MovieListResponse {
  const factory MovieListResponse({
    required List<MovieModel> movies,
    required PaginationModel pagination,
  }) = _MovieListResponse;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);
}
