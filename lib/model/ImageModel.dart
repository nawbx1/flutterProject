

import 'package:json_annotation/json_annotation.dart';

part 'ImageModel.g.dart';
@JsonSerializable()
class ImageModel {
  final int id;

  final String name;

  final String type;

  final dynamic picByte;

  final String uploadDir;

  ImageModel({this.id, this.name, this.type, this.picByte, this.uploadDir});


  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

/*factory ImageModel.fromJson(Map<String, dynamic> jsonMap) {
    return ImageModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        type: jsonMap['type'],
        picByte: jsonMap['picByte'],
        uploadDir: jsonMap['uploadDir']
    );
  }

  Map<String, dynamic> toJson(ImageModel u) {


    Map<String, dynamic> json = {
      'name': u.name,
      'type': u.type,
      'uploadDir': u.uploadDir,

    }; return json;
  }
*/
}