import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
class AppointmentRepository {


  final urlRendezVous = apiUrl + 'rendez-vous-service/rdv/';

  AppointmentRepository();



  Future<Response>  save(Appointment appointment) async {
    print("saveUser  .....  UserRepository "+appointment.toJson().toString());
    return await http.post(Uri.parse(urlRendezVous+'save'),
        body: json.encode(appointment.toJson()),
        headers: {'Content-Type': 'application/json'});
  }



  Future<Response>  update(Appointment appointment) async {
    print("saveUser  .....  UserRepository "+appointment.toJson().toString());
    return await http.put(Uri.parse(urlRendezVous+'update'),
        body: json.encode(appointment.toJson()),
        headers: {'Content-Type': 'application/json'});
  }



  Future<Response> getMyAppointment(int id) async {
    return await http.get(
        Uri.parse(urlRendezVous + 'appointmentbyprofessionnel/' + id.toString()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        });
  }

  Future<Response> getProfessionelCalendar(int id) async {
    return await http.get(
        Uri.parse(urlRendezVous + 'professionelcalendar/' + id.toString()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        });
  }


  Future<Response> getMyAppointmentAsClient(int id) async {
    return await http.get(
        Uri.parse(urlRendezVous + 'appointmentbyclient/' + id.toString()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        });
  }


}