
import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:http/http.dart' ;
import 'package:http/http.dart' as http;
class UserRepository{



  Future<Response>  getAllUsers() async {

    return await http.get(Uri.parse(apiUrl+'user-service/user/all'),
        headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});
  }

  Future<Response>  getUserByKeycloak(String keycloak) async {

    return await http.get(Uri.parse(apiUrl+'user-service/user/keycloak?keycloak='+keycloak),
        headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});
  }

  Future<Response>  fetchSpeciality() async {
    print("fetchSpeciality  ..... ");
    return await http.get(Uri.parse(apiUrl+'user-service/speciality/all'),
        headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});
  }

  Future<Response>  fetchInterventionsBySpecialityName(String name) async {
    return await http.get(Uri.parse(apiUrl+'user-service/speciality/all/'+name),
        headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});
  }

  Future<Response>  login(User user) async {
    print("login  UserRepository "+user.toJson().toString());
    return await http.post(Uri.parse(apiUrl+'user-service/keycloak/login'),
        body: json.encode(user.toJson()),
        headers: {'Content-Type': 'application/json'});
  }


  Future<Response>  saveUser(User user) async {
    print("saveUser  .....  UserRepository "+user.toJson().toString());
    return await http.post(Uri.parse(apiUrl+'user-service/keycloak/save'),
        body: json.encode(user.toJson()),
        headers: {'Content-Type': 'application/json'});
  }

  Future<Response>  updateUser(User user) async {
    print("saveUser  .....  UserRepository "+user.toJson().toString());
    return await http.put(Uri.parse(apiUrl+'user-service/user/updateprofile'),
        body: json.encode(user.toJson()),
        headers: {'Content-Type': 'application/json'});
  }

  Future<Response> verifOTP(int id, String otp) async{

    String myurl = apiUrl+"user-service/keycloak/verifyotp/"+id.toString()+"/"+otp;
  return  http.get(Uri.parse(myurl),

        headers: {'Content-Type': 'application/json'});

  }


  Future<Response>  updateCompetance(competence,id) async {
    return await http.post(Uri.parse(apiUrl+'user-service/user/updatecompetance/'+id),
        body: json.encode(competence.toJson()),
        headers: {'Content-Type': 'application/json'});
  }



  Future<Response>  updatepassword(String keycloak , String password) async {
    return await http.put(Uri.parse(apiUrl+'user-service/user/update/'+keycloak.toString()+"/"+password.toString()),
        headers: {'Content-Type': 'application/json'});
  }

  Future<Response>  updatePhotoProfile(int id,Media media) async {
    return await http.put(Uri.parse(apiUrl+'user-service/media/updatephotoprofile/'+id.toString()),
        body: json.encode(media.toJson()),
        headers: {'Content-Type': 'application/json'});
  }



}