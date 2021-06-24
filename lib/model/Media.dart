import 'package:json_annotation/json_annotation.dart';

part 'Media.g.dart';
@JsonSerializable()
class Media {
   int id;

   String type;

   String label;

   String fileName;

   dynamic file;

   String mediaURL;


  Media({
    this.id, this.type, this.label, this.fileName, this.file, this.mediaURL});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @override
  String toString() {
    return 'Media{id: $id, type: $type, label: $label, fileName: $fileName, file: $file, mediaURL: $mediaURL}';
  }


}