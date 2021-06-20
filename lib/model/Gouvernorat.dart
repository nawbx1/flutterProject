import 'package:doctor_pro/model/Region.dart';
import 'package:json_annotation/json_annotation.dart';



part 'Gouvernorat.g.dart';

@JsonSerializable()
class Gouvernorat {

  int id;
  String name ;

  List<Region>regions ;


  Gouvernorat({this.id, this.name, this.regions});


  factory Gouvernorat.fromJson(Map<String, dynamic> json) => _$GouvernoratFromJson(json);

  Map<String, dynamic> toJson() => _$GouvernoratToJson(this);

/* factory Gouvernorat.fromJson(Map<String, dynamic> json) {
    return Gouvernorat(
      id: json['id'],
      name: json['name'],
      regions: json['regions'],



    );
  }

  Map<String, dynamic> toJsonNew(Gouvernorat g) {
    Map<String, dynamic> json = {

      'name': g.name,
      'regions': g.regions,


    };
  }
*/
}