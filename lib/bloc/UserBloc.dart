
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/model/Competence.dart';
import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/Speciality.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/model/ResponseLogin.dart';
import 'package:doctor_pro/repository/UserRepository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc{

  UserRepository userRepository = new  UserRepository();

  UserBloc();

  Future<User> getUserByKeycloak() async {

    String keycloak = await TokenStorageBloc.getStoredUserKeycloak();

    print('getUserByKeycloak');
    print(keycloak);
    if(keycloak ==null )
      return null ;
    var result = await userRepository.getUserByKeycloak(keycloak) ;

    String source = Utf8Decoder().convert(result.bodyBytes);

    User user = User.fromJson(json.decode(source.toString()));
    print('usesssssssssssssr');
    print(user.toString());

    return result.statusCode==200? user : null;
  }

  Future<List<Speciality>> fetchSpeciality() async {
    print("userbloc   ..... ");

    var result = await userRepository.fetchSpeciality() ;
    print("result is");
    String source = Utf8Decoder().convert(result.bodyBytes);
    var  res = json.decode(source.toString()) as List;
    print(res.length);
    print(res[1]);
    print("result is 2");
    //List<Speciality> lists = res.map((tagJson) => Speciality.fromJson(tagJson)).toList() ;
    List<Speciality> result2 = res.map((i) => Speciality.fromJson(i)).toList();


    print(result2.toString());
    print("result is 3");
    print(res[0]);
    return result.statusCode==200? result2 : [];
  }


  Future<List<InterventionType>> fetchInterventionsBySpecialityName(String name) async {

    var result = await userRepository.fetchInterventionsBySpecialityName(name) ;
    String source = Utf8Decoder().convert(result.bodyBytes);
    Speciality speciality = Speciality.fromJson(json.decode(source.toString()));
    print(speciality.toString());

    List<InterventionType>list = [] ;

    await speciality.interventionTypes.forEach((e) async{
        list.add(e);
    });
    print('list after foreach interventions');
    print(list);

    return result.statusCode==200? list : null ;
  }



  Future<User> saveuser(User user) async{

    var result = await userRepository.saveUser(user) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));
    print(result.body);
    String source = Utf8Decoder().convert(result.bodyBytes);
    User u = User.fromJson(json.decode(source.toString())) ;
    print("save user UserBloc "  + u.toString());


    print("status code "  +  result.statusCode.toString() );

    return result.statusCode==200? u : null;
  }

  Future<String> login(context,User user) async{
    print("user to login is "+user.toString());
    var result = await userRepository.login(user) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));
    String source = Utf8Decoder().convert(result.bodyBytes);
    ResponseLogin responseLogin = ResponseLogin.fromJson(json.decode(source.toString())) ;
    print(responseLogin.toString());
    user = responseLogin.user;
    print("login user UserBloc "  + responseLogin.user.toString());
    print("status code "  +  result.statusCode.toString() );
    TokenStorageBloc.storeUserDetails(responseLogin.user);
    TokenStorageBloc.storeAccessToken(responseLogin.accessToken);
    /*CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
    );*/
    return responseLogin.accessToken;
  }

  Future<User> updateuser(User user) async{
    var result = await userRepository.updateUser(user) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));
    String source = Utf8Decoder().convert(result.bodyBytes);
    User u = User.fromJson(json.decode(source.toString())) ;
    print("save user UserBloc "  + u.toString());
    print("status code "  +  result.statusCode.toString() );
    return result.statusCode==200? u : null;
  }

  Future<bool> verifOTP(int id,String otp) async {
    Response response= await userRepository.verifOTP(id, otp);
if(response.statusCode==200)
  return true;
else return false;
  }


  Future<List<User>> getAllUsers() async {
    print("userbloc   ..... ");

    var result = await userRepository.getAllUsers() ;
    print("result is");
    String source = Utf8Decoder().convert(result.bodyBytes);
    var  res = json.decode(source.toString()) as List;
    print(res.length);
    print(res[1]);
    print("result is 2");
    //List<Speciality> lists = res.map((tagJson) => Speciality.fromJson(tagJson)).toList() ;
    List<User> result2 = res.map((i) => User.fromJson(i)).toList();


    print(result2.toString());
    print("result is 3");
    print(res[0]);
    return result.statusCode==200? result2 : [];
  }

  Future<User> updateCompetence(competence, id) async{
    var result = await userRepository.updateCompetance(competence, id) ;
    String source = Utf8Decoder().convert(result.bodyBytes);
    User u = User.fromJson(json.decode(source.toString())) ;
    print("status code "  +  result.statusCode.toString() );
    return result.statusCode==200? u : null;
  }


  Future<String> updatepassword(String keycloak,String password) async{
    var result = await userRepository.updatepassword(keycloak,password) ;
    return result.statusCode==200? "ok" : "not ok";
  }

  Future<User> updatePhotoProfile(Media media) async {
    int id = await TokenStorageBloc.getStoredUserId();
    var result = await userRepository.updatePhotoProfile(id,media) ;
    String source = Utf8Decoder().convert(result.bodyBytes);
    User u = User.fromJson(json.decode(source.toString())) ;
    print("status code "  +  result.statusCode.toString() );
    return result.statusCode==200? u : null;

  }




}