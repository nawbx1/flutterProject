// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Gouvernorat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gouvernorat _$GouvernoratFromJson(Map<String, dynamic> json) {
  return Gouvernorat(
    id: json['id'] as int,
    name: json['name'] as String,
    regions: (json['regions'] as List)
        ?.map((e) =>
            e == null ? null : Region.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GouvernoratToJson(Gouvernorat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'regions': instance.regions,
    };
