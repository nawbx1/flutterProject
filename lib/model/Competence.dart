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
  Map<String, dynamic> toJson(Competence c) {
    var inter=[];
    if(c.interventionType!=null){
      for(int i=0;i<c.interventionType.length;i++) {
        inter.add(InterventionType().toJson(c.interventionType[i]));
      }
    }
    Map<String, dynamic> json = {



      'position': c.position,
      'intervention_id':inter,


    };return json ;
  }

}

