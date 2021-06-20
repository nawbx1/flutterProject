// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseLogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseLogin _$ResponseLoginFromJson(Map<String, dynamic> json) {
  return ResponseLogin(
    json['accessToken'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$ResponseLoginToJson(ResponseLogin instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
      'refreshToken': instance.refreshToken,
    };
