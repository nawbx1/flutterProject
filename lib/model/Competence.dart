import 'package:doctor_pro/model/InterventionType.dart';

class Competence {
  final int id;
  
  final int position ;

  final List<InterventionType> interventionType ;


  Competence({this.id, this.position, this.interventionType});
  factory Competence.fromJson(Map<String, dynamic> jsonMap) {
    return Competence(
        id: jsonMap['id'],
        position: jsonMap['position'],
        interventionType: jsonMap['interventionType'],
    );
  }

}

