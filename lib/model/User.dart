

import 'dart:core';

import 'package:doctor_pro/model/Address.dart';
import 'package:doctor_pro/model/Profile.dart';
import 'package:doctor_pro/model/Role.dart';
import 'package:doctor_pro/model/Speciality.dart';
import 'dart:convert' as Json;

import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';
@JsonSerializable()
class User{

   int  id ;
    String keycloak;
   String username;

   String password;
   String email;
   int phone;
   int cin;
   String name;
   bool verified;
   String matriculeFiscale;
   int OTP;

   List<Speciality> speciality;

   Profile profile;

   List<Role> role;
   Address address;

  User({
      this.id,
      this.keycloak,
      this.username,
      this.password,
      this.email,
      this.phone,
      this.cin,
      this.name,
      this.verified,
      this.matriculeFiscale,
      this.OTP,
      this.speciality,
      this.profile,
      this.role,
      this.address});


   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

   Map<String, dynamic> toJson() => _$UserToJson(this);


   @override
   String toString() {
     return 'User { id: $id, keycloak: $keycloak, username: $username, password: $password, email: $email, phone: $phone, cin: $cin, name: $name, verified: $verified, matriculeFiscale: $matriculeFiscale, OTP: $OTP, speciality: $speciality, profile: $profile, role: $role, address: $address}';
   }
/*

  factory User.fromJson(Map<String, dynamic> jsonMap) {
    List<Speciality>s =[];

    if(jsonMap['speciality']!=null){
      for(int i=0;i<jsonMap['speciality'].length;i++){
        s.add(new Speciality.fromJson(jsonMap['speciality'][i]));
      }
    }


    List<Role>r =[];
    if(jsonMap['role']!=null){
      for(int i=0;i<jsonMap['role'].length;i++){
        r.add(new Role.fromJson(jsonMap['role'][i]));
      }
    }
    return User(
      id: jsonMap['id'],
      keycloak: jsonMap['keycloak'],
      username: jsonMap['username'],
      password: jsonMap['password'],
      email: jsonMap['email'],
      phone: jsonMap['phone'],
      cin: jsonMap['cin'],
      name: jsonMap['name'],
      verified: jsonMap['verified'],
      matriculeFiscale: jsonMap['matriculeFiscale'],
      speciality:s,
      profile: (jsonMap['profile']!=null )? Profile.fromJson(jsonMap['profile']) : null ,
      role: r,
      address: (jsonMap['address']!=null )? Address.fromJson(jsonMap['address']) : null ,
    );
  }



  Map<String, dynamic> toJsonNew(User u) {
  var r=[];
  if(u.role!=null){
    for(int i=0;i<u.role.length;i++) {
      r.add(Role().toJson(u.role[i]));
    }
    }
  var s=[];
  if(u.speciality!=null){
    for(int i=0;i<u.speciality.length;i++) {
      s.add(Speciality().toJson(u.speciality[i]));
    }
  }


  Map<String, dynamic> json = {
  'id':u.id,
    'keycloak': u.keycloak,
    'username': u.username,
    'password': u.password,
    'email': u.email,
    'phone': u.phone,
    'cin': u.cin,
    'name': u.name,
    'verified': u.verified,
    'matriculeFiscale': u.matriculeFiscale,
    'speciality': s,
    'profile':  Profile().toJson(u.profile),
    'role': r,
    'address': Address().toJson(u.address),
  }; return json;
}

   @override
  String toString() {
    return 'User { id: $id, keycloak: $keycloak, username: $username, password: $password, email: $email, phone: $phone, cin: $cin, name: $name, verified: $verified, matriculeFiscale: $matriculeFiscale, OTP: $OTP, speciality: $speciality, profile: $profile, role: $role, address: $address}';
  }
*/




}





