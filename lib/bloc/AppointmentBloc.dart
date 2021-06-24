import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'dart:convert';
import 'package:doctor_pro/repository/AppointmentRepository.dart';
import 'package:doctor_pro/ui/util/NotificationDialog.dart';
class AppointmentBloc{




  AppointmentRepository appointmentRepository = new  AppointmentRepository();

  AppointmentBloc();

  Future<Appointment> save(Appointment appointment) async{

    var result = await appointmentRepository.save(appointment) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));
    print(result.body);
    String source = Utf8Decoder().convert(result.bodyBytes);
    Appointment a = Appointment.fromJson(json.decode(source.toString())) ;
    print("save user UserBloc "  + a.toString());


    print("status code "  +  result.statusCode.toString() );

    if(result.statusCode==200)
      NotificationDialog( 'Success','ya3tik sa7a ','200');
    else NotificationDialog( 'desole','marra o5ra ','500');
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

  Future<List<Appointment>> getProfessionelCalendar(int id) async {


    var result = await appointmentRepository.getProfessionelCalendar(id) ;
    print("result is");
    String source = Utf8Decoder().convert(result.bodyBytes);
    var  res = json.decode(source.toString())as List;
    print(res.length);
    print(res[1]);
    print("result is 2");
    List<Appointment> result2 = res.map((i) => Appointment.fromJson(i)).toList();
    print(result2.toString());
    print("result is 3");
    print(res[0]);
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