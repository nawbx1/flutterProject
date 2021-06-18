

import 'dart:core';

import 'package:doctor_pro/model/Address.dart';
import 'package:doctor_pro/model/Profile.dart';
import 'package:doctor_pro/model/Role.dart';
import 'package:doctor_pro/model/Speciality.dart';

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

  factory User.fromJson(Map<String, dynamic> jsonMap) {
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
      speciality: jsonMap['speciality'],
      profile: jsonMap['profile'],
      role: jsonMap['role'],
      address: jsonMap['address'],
    );
  }





Map<String, dynamic> toJson(User u) {
  Map<String, dynamic> json = {
    'id': u.id,
    'keycloak': u.keycloak,
    'username': u.username,
    'password': u.password,
    'email': u.email,
    'phone': u.phone,
    'cin': u.cin,
    'name': u.name,
    'verified': u.verified,
    'matriculeFiscale': u.matriculeFiscale,
    'speciality': u.speciality,
    'profile': u.profile,
    'role': u.role,
    'address': u.address
  }; return json;
}
}





