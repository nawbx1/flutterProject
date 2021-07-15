// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return Media(
    id: json['id'] as int,
    type: json['type'] as String,
    label: json['label'] as String,
    fileName: json['fileName'] as String,
    file: json['file'],
    mediaURL: json['mediaURL'] as String,
  );
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'label': instance.label,
      'fileName': instance.fileName,
      'file': instance.file,
      'mediaURL': instance.mediaURL,
    };
