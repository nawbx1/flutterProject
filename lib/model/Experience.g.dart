// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) {
  return Experience(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    media: (json['media'] as List)
        ?.map(
            (e) => e == null ? null : Media.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'media': instance.media,
    };
