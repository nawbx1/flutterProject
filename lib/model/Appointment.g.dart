// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  return Appointment(
    appointmentPK: json['appointmentPK'] == null
        ? null
        : AppointmentPK.fromJson(json['appointmentPK'] as Map<String, dynamic>),
    title: json['title'] as String,
    description: json['description'] as String,
    client: json['client'] == null
        ? null
        : User.fromJson(json['client'] as Map<String, dynamic>),
    professionnel: json['professionnel'] == null
        ? null
        : User.fromJson(json['professionnel'] as Map<String, dynamic>),
    status: json['status'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    media: json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointmentPK': instance.appointmentPK,
      'title': instance.title,
      'description': instance.description,
      'client': instance.client,
      'professionnel': instance.professionnel,
      'status': instance.status,
      'address': instance.address,
      'media': instance.media,
    };
