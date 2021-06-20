// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Competence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Competence _$CompetenceFromJson(Map<String, dynamic> json) {
  return Competence(
    id: json['id'] as int,
    position: json['position'] as int,
    interventionType: json['interventionType'] == null
        ? null
        : InterventionType.fromJson(
            json['interventionType'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompetenceToJson(Competence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'interventionType': instance.interventionType,
    };
