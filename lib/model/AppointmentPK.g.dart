// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppointmentPK.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentPK _$AppointmentPKFromJson(Map<String, dynamic> json) {
  return AppointmentPK(
    clientId: json['clientId'] as int,
    professionnelId: json['professionnelId'] as int,
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
  );
}

Map<String, dynamic> _$AppointmentPKToJson(AppointmentPK instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'professionnelId': instance.professionnelId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
