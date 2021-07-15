import 'package:cool_alert/cool_alert.dart';
import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'dart:convert';
import 'package:doctor_pro/repository/AppointmentRepository.dart';
import 'package:doctor_pro/ui/util/NotificationDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
class AppointmentBloc{


  AppointmentRepository appointmentRepository = new  AppointmentRepository();

  AppointmentBloc();




  // Future<List<User>> withAlgo() async {
  //   print("userbloc   ..... ");
  //
  //   var result = await appointmentRepository.withAlgo() ;
  //   print("result is");
  //   String source = Utf8Decoder().convert(result.bodyBytes);
  //   var  res = json.decode(source.toString()) as List;
  //   print(res.length);
  //   print(res[1]);
  //   print("result is 2");
  //   //List<Speciality> lists = res.map((tagJson) => Speciality.fromJson(tagJson)).toList() ;
  //   List<User> result2 = res.map((i) => User.fromJson(i)).toList();
  //
  //
  //   print(result2.toString());
  //   print("result is 3");
  //   print(res[0]);
  //   return result.statusCode==200? result2 : [];
  // }




  Future<Appointment> save(BuildContext context, Appointment appointment) async{

    var result = await appointmentRepository.save(appointment) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));


    result.statusCode==200?
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      //autoCloseDuration: Duration(seconds: 2),
      text: "Rendez-Vous Enregistrer Avec Succès !",

      confirmBtnText: 'Oui',
      cancelBtnText: 'Non',
      confirmBtnColor: Colors.green,
      showCancelBtn: true,

      onConfirmBtnTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 100),
                child:
                //GoogleMapPlacePicker()
                SpecialityPage(
                )));
      },
    ): CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "Essayer de nouveau!",
    );
    print(result.body);
    String source = Utf8Decoder().convert(result.bodyBytes);
    Appointment a = Appointment.fromJson(json.decode(source.toString())) ;
    print("save user UserBloc "  + a.toString());


    print("status code "  +  result.statusCode.toString() );

    if(result.statusCode==200)
      NotificationDialog( 'Success','ya3tik saida ','200');
    else NotificationDialog( 'desole','marra o5ra ','500');
    return result.statusCode==200? a : null;
  }

  Future<Appointment> update(BuildContext context, Appointment appointment) async{

    var result = await appointmentRepository.update(appointment) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));

    result.statusCode==200?
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      //autoCloseDuration: Duration(seconds: 2),
      text: "Rendez-Vous mise à jour Avec Succès !",

      confirmBtnText: 'Oui',
      cancelBtnText: 'Non',
      confirmBtnColor: Colors.green,
      showCancelBtn: true,

      onConfirmBtnTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 100),
                child:
                //GoogleMapPlacePicker()
                SpecialityPage(
                )));
      },
    ): CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "Essayer de nouveau!",
    );


    print(result.body);
    String source = Utf8Decoder().convert(result.bodyBytes);
    Appointment a = Appointment.fromJson(json.decode(source.toString())) ;
    print("save user UserBloc "  + a.toString());


    print("status code "  +  result.statusCode.toString() );

    if(result.statusCode==200)
      NotificationDialog( 'Success','rendez-vous enregistrer ','200');
    else NotificationDialog( 'desole','essayer de nouveau ','500');
    return result.statusCode==200? a : null;
  }

  Future<List<Appointment>> getMyAppointment() async {

   int id = await TokenStorageBloc.getStoredUserId();
    print(id);
    var result = await appointmentRepository.getMyAppointment(id) ;
    print("result is");
    String source = Utf8Decoder().convert(result.bodyBytes);
    var  res = json.decode(source.toString()) as List;
    print(res.length);
    print(res);
    print("result is 2");
    List<Appointment> result2 = res.map((i) => Appointment.fromJson(i)).toList();
    print(result2.toString());
    print("result is 3");
    print(res[0]);
    return result.statusCode==200? result2 : [];
  }

  Future<List<Appointment>> getProfessionelCalendar() async {

    int id = await TokenStorageBloc.getStoredUserId();
    var result = await appointmentRepository.getProfessionelCalendar(id) ;
    String source = Utf8Decoder().convert(result.bodyBytes);
    var  res = json.decode(source.toString())as List;
    List<Appointment> result2 = res.map((i) => Appointment.fromJson(i)).toList();
    print(result2.toString());
    return result.statusCode==200? result2 : [];
  }

  Future<List<Appointment>> getMyAppointmentAsClient() async {

    int id = await TokenStorageBloc.getStoredUserId();
    print("id is");
    print(id);
    var result = await appointmentRepository.getMyAppointmentAsClient(id) ;
    print("result is");
    String source = Utf8Decoder().convert(result.bodyBytes);
    var  res = json.decode(source.toString()) as List;
    print(res.length);
    print(res);
    print("result is 2");
    List<Appointment> result2 = res.map((i) => Appointment.fromJson(i)).toList();
    print(result2.toString());
    print("result is 3");
    print(res[0]);
    return result.statusCode==200? result2 : [];
  }


}