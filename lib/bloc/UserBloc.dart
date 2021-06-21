
import 'dart:convert';

import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
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
    var  res = json.decode(result.body.toString())as List;
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

    Future<User> saveuser(User user) async{
    var result = await userRepository.saveUser(user) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));
    print(result.body);
    User u = User.fromJson(json.decode(result.body)) ;
    print("save user UserBloc "  + u.toString());


    print("status code "  +  result.statusCode.toString() );

    return result.statusCode==200? u : null;
  }


  Future<String> login(User user) async{
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

    return responseLogin.accessToken;
  }


  Future<User> updateuser(User user) async{
    var result = await userRepository.updateUser(user) ;
    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));
    User u = User.fromJson(json.decode(result.body)) ;
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







}