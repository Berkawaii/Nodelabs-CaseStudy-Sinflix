import 'package:json_annotation/json_annotation.dart';

part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse {
  final bool success;
  final String message;

  const FavoriteResponse({required this.success, required this.message});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => _$FavoriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
}
