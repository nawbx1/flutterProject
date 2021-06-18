import 'package:doctor_pro/model/Media.dart';

class Speciality {
  final int id;

  final String name ;

  final String slogon ;

  final Media media ;

  Speciality({this.id, this.name, this.slogon, this.media});
  factory Speciality.fromJson(Map<String, dynamic> jsonMap) {
    return Speciality(
        id: jsonMap['id'],
        name: jsonMap['name'],
        slogon: jsonMap['slogon'],
        media: jsonMap['media']
    );
  }

}