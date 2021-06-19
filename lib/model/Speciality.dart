import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/model/Media.dart';

class Speciality {
  final int id;

  final String name ;

  final String slogon ;

  final Media media ;

  final List<InterventionType> interventionTypes ;

  Speciality({this.id, this.name, this.slogon, this.media ,this.interventionTypes});
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
      'slogon': s.slogon,
      'media_id':Media().toJson(s.media),
      'interventionTypes':inter,

    };return json ;
  }




}