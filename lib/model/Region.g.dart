// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) {
  return Region(
    id: json['id'] as int,
    gouvernorat: json['gouvernorat'] == null
        ? null
        : Gouvernorat.fromJson(json['gouvernorat'] as Map<String, dynamic>),
    region: json['region'] as String,
  );
}

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'id': instance.id,
      'gouvernorat': instance.gouvernorat,
      'region': instance.region,
    };
