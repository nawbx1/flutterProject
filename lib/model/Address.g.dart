// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as int,
    region: json['region'] == null
        ? null
        : Region.fromJson(json['region'] as Map<String, dynamic>),
    street: json['street'] as String,
    zipCode: json['zipCode'] as int,
    longitude: json['longitude'] as int,
    lattitude: json['lattitude'] as int,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'region': instance.region,
      'street': instance.street,
      'zipCode': instance.zipCode,
      'longitude': instance.longitude,
      'lattitude': instance.lattitude,
    };
