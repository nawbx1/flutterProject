// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    competences: (json['competences'] as List)
        ?.map((e) =>
            e == null ? null : Competence.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    experiences: (json['experiences'] as List)
        ?.map((e) =>
            e == null ? null : Experience.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    regions: (json['regions'] as List)
        ?.map((e) =>
            e == null ? null : Region.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    coverImage: json['coverImage'] == null
        ? null
        : Media.fromJson(json['coverImage'] as Map<String, dynamic>),
    profileImage: json['profileImage'] == null
        ? null
        : Media.fromJson(json['profileImage'] as Map<String, dynamic>),
    id: json['id'] as int,
    information: json['information'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'competences': instance.competences,
      'experiences': instance.experiences,
      'regions': instance.regions,
      'coverImage': instance.coverImage,
      'profileImage': instance.profileImage,
      'id': instance.id,
      'information': instance.information,
    };
