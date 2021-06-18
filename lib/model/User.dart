

import 'dart:core';

import 'package:doctor_pro/model/Address.dart';
import 'package:doctor_pro/model/Profile.dart';
import 'package:doctor_pro/model/Role.dart';
import 'package:doctor_pro/model/Speciality.dart';

class User{

  final int  id ;
  final  String keycloak;
  final String username;

  final String password;
  final String email;
  final int phone;
  final int cin;
  final String name;
  final bool verified;
  final String matriculeFiscale;
  final int OTP;

  final List<Speciality> speciality;

  final Profile profile;

  final List<Role> role;
  final Address address;

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
}





