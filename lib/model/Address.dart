
import 'package:doctor_pro/model/Region.dart';


import 'package:json_annotation/json_annotation.dart';

part 'Address.g.dart';
@JsonSerializable()
class Address {
  final int id;

  final Region region;
  final String street;
  final int zipCode;

  final int longitude;
  final int lattitude;

  Address({this.id, this.region, this.street, this.zipCode, this.longitude,
    this.lattitude});


  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return 'Address{id: $id, region: $region, street: $street, zipCode: $zipCode, longitude: $longitude, lattitude: $lattitude}';
  }

/*factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      street: json['street'],
      zipCode: json['zipCode'],
      longitude: json['longitude'],
      lattitude: json['lattitude'],

      region: json['region'],


    );
  }

  Map<String, dynamic> toJson(Address a) {
    Map<String, dynamic> json = {
      'id':a.id,
      'street': a.street,
      'zipCode': a.zipCode,
      'longitude': a.longitude,
      'lattitude': a.lattitude,
      'region': a.region


    };return json ;
  }*/
}