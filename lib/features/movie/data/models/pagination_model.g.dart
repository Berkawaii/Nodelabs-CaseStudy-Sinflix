// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationModelImpl _$$PaginationModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaginationModelImpl(
  totalCount: (json['totalCount'] as num).toInt(),
  perPage: (json['perPage'] as num).toInt(),
  maxPage: (json['maxPage'] as num).toInt(),
  currentPage: (json['currentPage'] as num).toInt(),
);

Map<String, dynamic> _$$PaginationModelImplToJson(
  _$PaginationModelImpl instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'perPage': instance.perPage,
  'maxPage': instance.maxPage,
  'currentPage': instance.currentPage,
};
