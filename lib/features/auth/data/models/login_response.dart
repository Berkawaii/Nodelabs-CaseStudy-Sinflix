import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required ResponseInfo response,
    required LoginData data,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class ResponseInfo with _$ResponseInfo {
  const factory ResponseInfo({required int code, required String message}) =
      _ResponseInfo;

  factory ResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseInfoFromJson(json);
}

@freezed
class LoginData with _$LoginData {
  const factory LoginData({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
    String? photoUrl,
    required String token,
  }) = _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
}
