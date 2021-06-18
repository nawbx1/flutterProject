import 'package:doctor_pro/model/Region.dart';


class Gouvernorat {
  final int id;

  final String name ;


final List<Region>regions ;


  Gouvernorat({this.id, this.name, this.regions});

  factory Gouvernorat.fromJson(Map<String, dynamic> json) {
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

}