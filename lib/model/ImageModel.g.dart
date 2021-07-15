// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return ImageModel(
    id: json['id'] as int,
    name: json['name'] as String,
    type: json['type'] as String,
    picByte: json['picByte'],
    uploadDir: json['uploadDir'] as String,
  );
}

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'picByte': instance.picByte,
      'uploadDir': instance.uploadDir,
    };
