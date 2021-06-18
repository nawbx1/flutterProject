import 'package:doctor_pro/model/Media.dart';

class Experience {
  final int id;

  final String name ;

  final String description ;

  final List<Media> media ;



  Experience({this.id, this.name, this.description, this.media});
  factory Experience.fromJson(Map<String, dynamic> jsonMap) {
    return Experience(
        id: jsonMap['id'],
        name: jsonMap['name'],
        description: jsonMap['description'],
        media: jsonMap['media']
    );
  }

}