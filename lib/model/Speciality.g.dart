// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Speciality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speciality _$SpecialityFromJson(Map<String, dynamic> json) {
  return Speciality(
    id: json['id'] as int,
    name: json['name'] as String,
    slogon: json['slogon'] as String,
    media: json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    interventionTypes: (json['interventionTypes'] as List)
        ?.map((e) => e == null
            ? null
            : InterventionType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SpecialityToJson(Speciality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slogon': instance.slogon,
      'media': instance.media,
      'interventionTypes': instance.interventionTypes,
    };
