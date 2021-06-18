import 'package:doctor_pro/model/Speciality.dart';

class InterventionType {
  final int id;

  final String name ;

  final Speciality speciality ;


  InterventionType({this.id, this.name, this.speciality});
  factory InterventionType.fromJson(Map<String, dynamic> jsonMap) {
    return InterventionType(
        id: jsonMap['id'],
        name: jsonMap['name'],
        speciality: jsonMap['speciality']
    );
  }

}