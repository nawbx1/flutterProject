
import 'package:json_annotation/json_annotation.dart';

part 'AppointmentPK.g.dart';
@JsonSerializable()
class AppointmentPK{

    int clientId;

    int professionnelId;

    DateTime startDate;

    DateTime endDate;


    AppointmentPK({
      this.clientId, this.professionnelId, this.startDate, this.endDate});


    @override
  String toString() {
    return 'AppointmentPK{clientId: $clientId, professionnelId: $professionnelId, startDate: $startDate, endDate: $endDate}';
  }

  factory AppointmentPK.fromJson(Map<String, dynamic> json) => _$AppointmentPKFromJson(json);

    Map<String, dynamic> toJson() => _$AppointmentPKToJson(this);

}