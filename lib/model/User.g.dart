// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    keycloak: json['keycloak'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
    phone: json['phone'] as int,
    cin: json['cin'] as int,
    name: json['name'] as String,
    verified: json['verified'] as bool,
    matriculeFiscale: json['matriculeFiscale'] as String,
    OTP: json['OTP'] as int,
    speciality: (json['speciality'] as List)
        ?.map((e) =>
            e == null ? null : Speciality.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    profile: json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    role: (json['role'] as List)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'keycloak': instance.keycloak,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'phone': instance.phone,
      'cin': instance.cin,
      'name': instance.name,
      'verified': instance.verified,
      'matriculeFiscale': instance.matriculeFiscale,
      'OTP': instance.OTP,
      'speciality': instance.speciality,
      'profile': instance.profile,
      'role': instance.role,
      'address': instance.address,
    };
