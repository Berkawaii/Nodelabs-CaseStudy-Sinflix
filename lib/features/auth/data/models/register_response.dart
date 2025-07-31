import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({required ResponseStatus response, required UserData data}) =
      _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
}

@freezed
class ResponseStatus with _$ResponseStatus {
  const factory ResponseStatus({required int code, required String message}) = _ResponseStatus;

  factory ResponseStatus.fromJson(Map<String, dynamic> json) => _$ResponseStatusFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
    required String photoUrl,
    required String token,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
