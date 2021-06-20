
import 'package:doctor_pro/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenStorageBloc{

  static void  storeUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson().toString());


  }
  static void storeAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);

  }
  static Future<User> getStoredUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonCodec codec = new JsonCodec();
    print("getStoredUser 000000000000000");
    var sss= prefs.getString('user') ;
    print("user from storage");
    print(sss);
    var s = codec.decode(sss);
    print("getStoredUser 222222222222");
    print(s);
    User user= User.fromJson( s ) ;



    return user;
  }

  static Future<String> getStoredAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   String accessToken= prefs.getString('accessToken');
    return accessToken;
  }

}