import 'package:doctor_pro/model/Speciality.dart';


import 'package:json_annotation/json_annotation.dart';

part 'InterventionType.g.dart';

@JsonSerializable()
class InterventionType {
  final int id;

  final String name ;

 // final Speciality speciality ;


  InterventionType({this.id, this.name});

  factory InterventionType.fromJson(Map<String, dynamic> json) => _$InterventionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$InterventionTypeToJson(this);

  @override
  String toString() {
    return 'InterventionType{id: $id, name: $name}';
  }

/* factory InterventionType.fromJson(Map<String, dynamic> jsonMap) {
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
*/
}