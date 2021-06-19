import 'package:doctor_pro/model/Speciality.dart';

class InterventionType {
  final int id;

  final String name ;

 // final Speciality speciality ;


  InterventionType({this.id, this.name});
  factory InterventionType.fromJson(Map<String, dynamic> jsonMap) {
    return InterventionType(
        id: jsonMap['id'],
        name: jsonMap['name']

    );
  }
  Map<String, dynamic> toJson(InterventionType i) {

    Map<String, dynamic> json = {



      'name': i.name,



    };return json ;
  }

}