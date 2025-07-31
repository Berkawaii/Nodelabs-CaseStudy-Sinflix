// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_movie_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiMovieResponse _$ApiMovieResponseFromJson(Map<String, dynamic> json) {
  return _ApiMovieResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiMovieResponse {
  ApiResponseInfo get response => throw _privateConstructorUsedError;
  MovieListResponse get data => throw _privateConstructorUsedError;

  /// Serializes this ApiMovieResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiMovieResponseCopyWith<ApiMovieResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiMovieResponseCopyWith<$Res> {
  factory $ApiMovieResponseCopyWith(
    ApiMovieResponse value,
    $Res Function(ApiMovieResponse) then,
  ) = _$ApiMovieResponseCopyWithImpl<$Res, ApiMovieResponse>;
  @useResult
  $Res call({ApiResponseInfo response, MovieListResponse data});

  $ApiResponseInfoCopyWith<$Res> get response;
  $MovieListResponseCopyWith<$Res> get data;
}

/// @nodoc
class _$ApiMovieResponseCopyWithImpl<$Res, $Val extends ApiMovieResponse>
    implements $ApiMovieResponseCopyWith<$Res> {
  _$ApiMovieResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? response = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            response: null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as ApiResponseInfo,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as MovieListResponse,
          )
          as $Val,
    );
  }

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiResponseInfoCopyWith<$Res> get response {
    return $ApiResponseInfoCopyWith<$Res>(_value.response, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MovieListResponseCopyWith<$Res> get data {
    return $MovieListResponseCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiMovieResponseImplCopyWith<$Res>
    implements $ApiMovieResponseCopyWith<$Res> {
  factory _$$ApiMovieResponseImplCopyWith(
    _$ApiMovieResponseImpl value,
    $Res Function(_$ApiMovieResponseImpl) then,
  ) = __$$ApiMovieResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ApiResponseInfo response, MovieListResponse data});

  @override
  $ApiResponseInfoCopyWith<$Res> get response;
  @override
  $MovieListResponseCopyWith<$Res> get data;
}

/// @nodoc
class __$$ApiMovieResponseImplCopyWithImpl<$Res>
    extends _$ApiMovieResponseCopyWithImpl<$Res, _$ApiMovieResponseImpl>
    implements _$$ApiMovieResponseImplCopyWith<$Res> {
  __$$ApiMovieResponseImplCopyWithImpl(
    _$ApiMovieResponseImpl _value,
    $Res Function(_$ApiMovieResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? response = null, Object? data = null}) {
    return _then(
      _$ApiMovieResponseImpl(
        response: null == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as ApiResponseInfo,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as MovieListResponse,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiMovieResponseImpl implements _ApiMovieResponse {
  const _$ApiMovieResponseImpl({required this.response, required this.data});

  factory _$ApiMovieResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiMovieResponseImplFromJson(json);

  @override
  final ApiResponseInfo response;
  @override
  final MovieListResponse data;

  @override
  String toString() {
    return 'ApiMovieResponse(response: $response, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiMovieResponseImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, response, data);

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiMovieResponseImplCopyWith<_$ApiMovieResponseImpl> get copyWith =>
      __$$ApiMovieResponseImplCopyWithImpl<_$ApiMovieResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiMovieResponseImplToJson(this);
  }
}

abstract class _ApiMovieResponse implements ApiMovieResponse {
  const factory _ApiMovieResponse({
    required final ApiResponseInfo response,
    required final MovieListResponse data,
  }) = _$ApiMovieResponseImpl;

  factory _ApiMovieResponse.fromJson(Map<String, dynamic> json) =
      _$ApiMovieResponseImpl.fromJson;

  @override
  ApiResponseInfo get response;
  @override
  MovieListResponse get data;

  /// Create a copy of ApiMovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiMovieResponseImplCopyWith<_$ApiMovieResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiResponseInfo _$ApiResponseInfoFromJson(Map<String, dynamic> json) {
  return _ApiResponseInfo.fromJson(json);
}

/// @nodoc
mixin _$ApiResponseInfo {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ApiResponseInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponseInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseInfoCopyWith<ApiResponseInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseInfoCopyWith<$Res> {
  factory $ApiResponseInfoCopyWith(
    ApiResponseInfo value,
    $Res Function(ApiResponseInfo) then,
  ) = _$ApiResponseInfoCopyWithImpl<$Res, ApiResponseInfo>;
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class _$ApiResponseInfoCopyWithImpl<$Res, $Val extends ApiResponseInfo>
    implements $ApiResponseInfoCopyWith<$Res> {
  _$ApiResponseInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponseInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiResponseInfoImplCopyWith<$Res>
    implements $ApiResponseInfoCopyWith<$Res> {
  factory _$$ApiResponseInfoImplCopyWith(
    _$ApiResponseInfoImpl value,
    $Res Function(_$ApiResponseInfoImpl) then,
  ) = __$$ApiResponseInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$ApiResponseInfoImplCopyWithImpl<$Res>
    extends _$ApiResponseInfoCopyWithImpl<$Res, _$ApiResponseInfoImpl>
    implements _$$ApiResponseInfoImplCopyWith<$Res> {
  __$$ApiResponseInfoImplCopyWithImpl(
    _$ApiResponseInfoImpl _value,
    $Res Function(_$ApiResponseInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponseInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? code = null, Object? message = null}) {
    return _then(
      _$ApiResponseInfoImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiResponseInfoImpl implements _ApiResponseInfo {
  const _$ApiResponseInfoImpl({required this.code, required this.message});

  factory _$ApiResponseInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseInfoImplFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @override
  String toString() {
    return 'ApiResponseInfo(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseInfoImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  /// Create a copy of ApiResponseInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseInfoImplCopyWith<_$ApiResponseInfoImpl> get copyWith =>
      __$$ApiResponseInfoImplCopyWithImpl<_$ApiResponseInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseInfoImplToJson(this);
  }
}

abstract class _ApiResponseInfo implements ApiResponseInfo {
  const factory _ApiResponseInfo({
    required final int code,
    required final String message,
  }) = _$ApiResponseInfoImpl;

  factory _ApiResponseInfo.fromJson(Map<String, dynamic> json) =
      _$ApiResponseInfoImpl.fromJson;

  @override
  int get code;
  @override
  String get message;

  /// Create a copy of ApiResponseInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseInfoImplCopyWith<_$ApiResponseInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
