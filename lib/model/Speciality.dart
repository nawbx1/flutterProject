import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/model/Media.dart';

class Speciality {
   int id;

   String name ;

   String slogon ;

   Media media ;

   List<InterventionType> interventionTypes ;

  Speciality({this.id, this.name, this.slogon, this.media ,this.interventionTypes});

  Speciality.name(this.id, this.name);


  factory Speciality.fromJson(Map<String, dynamic> jsonMap) {
    List<InterventionType> list=[];
    if(jsonMap['interventionTypes']!=null){
      for(int i=0;i<jsonMap['interventionTypes'].length;i++){
        list.add(new InterventionType.fromJson(jsonMap['interventionTypes'][i]));
      }
    }

    return Speciality(
        id: jsonMap['id'],
        name: jsonMap['name'],
        slogon: jsonMap['slogon'],
        interventionTypes: list,
        media: (jsonMap['media']!=null )? Media.fromJson(jsonMap['media']) : null

        );
  }


  Map<String, dynamic> toJson(Speciality s) {
    var inter=[];
    if(s.interventionTypes!=null)
      for(int i=0;i<s.interventionTypes.length;i++) {
        inter.add(InterventionType().toJson(s.interventionTypes[i]));

      }
    Map<String, dynamic> json = {
      'id':s.id,
      'name': s.name,
      //'slogon': s.slogon,
      //'media':Media().toJson(s.media),
      //'interventionTypes':inter,

    };return json ;
  }




   @override
  String toString() {
    return 'Speciality{id: $id, name: $name}';
  }
}