
import 'package:doctor_pro/model/Address.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/model/AppointmentPK.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Appointment.g.dart';
@JsonSerializable()
class Appointment{

    AppointmentPK appointmentPK;

    String title;
    String description;

    User client;
    User professionnel;
    String status;
    Address address;
    Media media;


    Appointment({this.appointmentPK, this.title, this.description, this.client,
      this.professionnel, this.status, this.address, this.media});


    @override
  String toString() {
    return 'Appointment{appointmentPK: $appointmentPK, title: $title, description: $description, client: $client, professionnel: $professionnel, status: $status, address: $address, media: $media}';
  }

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

    Map<String, dynamic> toJson() => _$AppointmentToJson(this);

}




