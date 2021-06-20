/*
class Media {
  final int id;

  final String type;

  final String label;

  final String fileName;

  final dynamic file;

  final String mediaURL;

  Media({this.id, this.type, this.label, this.fileName, this.file,
    this.mediaURL});

  factory Media.fromJson(Map<String, dynamic> jsonMap) {
    return Media(

        // type: jsonMap['type'],
        label: jsonMap['label'],
        file: jsonMap['file'],
        fileName: jsonMap['fileName'],
        mediaURL: jsonMap['mediaURL']
    );

  }
  Map<String, dynamic> toJson(Media m) {

    Map<String, dynamic> json = {


      //'type': m.type,
      'mediaURL': m.mediaURL,
      'label': m.label,





    };return json ;
  }
}
*/

import 'package:json_annotation/json_annotation.dart';

part 'Media.g.dart';
@JsonSerializable()
class Media {
  int id;
  String type; //image video
  String fileName;

  Media({this.id, this.type, this.fileName});


  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);


/*

  factory Media.fromJson(Map<String, dynamic> jsonMap) {
    return Media(

        id: jsonMap['id'],
        type: jsonMap['type'],
        fileName: jsonMap['fileName'],
    );

  }
  Map<String, dynamic> toJson(Media m) {
    return({
      'fileName': m.fileName,
      'type': m.type,
    });
  }

*/




}
