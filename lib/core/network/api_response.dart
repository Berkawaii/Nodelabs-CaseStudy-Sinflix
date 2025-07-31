import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({required ApiResponseInfo response, required T data}) = _ApiResponse<T>;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

@freezed
class ApiResponseInfo with _$ApiResponseInfo {
  const factory ApiResponseInfo({required int code, required String message}) = _ApiResponseInfo;

  factory ApiResponseInfo.fromJson(Map<String, dynamic> json) => _$ApiResponseInfoFromJson(json);
}
