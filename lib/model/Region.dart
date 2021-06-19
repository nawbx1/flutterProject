

import 'package:doctor_pro/model/Gouvernerat.dart';

class Region{
  final int id;


  final Gouvernorat gouvernorat;


  final String region;

  Region({this.id, this.gouvernorat, this.region});

  factory Region.fromJson(Map<String, dynamic> json) {
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

}