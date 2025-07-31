// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  response: ApiResponseInfo.fromJson(json['response'] as Map<String, dynamic>),
  data: fromJsonT(json['data']),
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'response': instance.response,
  'data': toJsonT(instance.data),
};

_$ApiResponseInfoImpl _$$ApiResponseInfoImplFromJson(
  Map<String, dynamic> json,
) => _$ApiResponseInfoImpl(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$$ApiResponseInfoImplToJson(
  _$ApiResponseInfoImpl instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
