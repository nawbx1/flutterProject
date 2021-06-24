


import 'package:doctor_pro/model/Gouvernorat.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Region.g.dart';
@JsonSerializable()
class Region{
  int id;


  Gouvernorat gouvernorat;


  String region;

  Region({this.id, this.gouvernorat, this.region});


  @override
  String toString() {
    return 'Region{id: $id, gouvernorat: $gouvernorat, region: $region}';
  }

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);

  Map<String, dynamic> toJson() => _$RegionToJson(this);


/* factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      region: json['region'],
      gouvernorat:json['gouvernorat']

    );
  }

  Map<String, dynamic> toJson(Region g) {
    Map<String, dynamic> json = {
      'id':g.id,
      'region': g.region,
      'gouvernorat': g.gouvernorat,



    };
  }
*/
}