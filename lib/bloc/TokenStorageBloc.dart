
import 'package:doctor_pro/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenStorageBloc{

  static void  storeUserDetails(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', user.id);
    prefs.setString('userKeycloak', user.keycloak.toString());
    prefs.setString('userRole', user.role[0].name.toString());

  }
  static void storeAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);

  }
  static Future<int> getStoredUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getInt("userId");
  }

  static Future<String> getStoredUserKeycloak() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("userKeycloak");
  }

  static Future<String> getStoredUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("userRole");
  }

  static Future<String> getStoredAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   String accessToken= prefs.getString('accessToken');
    return accessToken;

  }

  static Future<String> removeAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('userRole');
    prefs.remove('userId');
    prefs.remove('userKeycloak');
    return 'ok' ;
  }



}