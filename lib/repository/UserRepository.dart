
import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:http/http.dart' ;
import 'package:http/http.dart' as http;
class UserRepository{

  Future<Response>  fetchSpeciality() async {
    print("fetchSpeciality  ..... ");
    return await http.get(Uri.parse(apiUrl+'user-service/speciality/all'),
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
      /*  .then((response) {
      res = response.statusCode;
      print(response.body);
      if (res == 200) {
        if (response.body != "") {
          print(widget.user.role[0].name);
          print(widget.user.role[0].name== "CLIENT_PHYSIQUE");
          print("jjjjjjj ");
          if (widget.user.role[0].name == "CLIENT_PHYSIQUE") {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 600),
                    type: PageTransitionType.fade,
                    child: ProfileClienPhysiquePage(user: widget.user,)));
          } if(widget.user.role[0].name == "CLIENT_MORALE"){
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 600),
                    type: PageTransitionType.fade,
                    child: Profileclientmorale()));

          }if (widget.user.role[0].name=="PROFESSIONNEL_PHYSIQUE"){
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 600),
                    type: PageTransitionType.fade,
                    child: Profileclientmorale()));

          }if(widget.user.role[0].name=="PROFESSIONNEL_MORALE"){


          }
        }
      }
    }
    );*/

  }



/* Future<dynamic> doRegister(User user) async {
    String myurl = "http://192.168.1.102:9089/user-service/keycloak/save";
    print("do register " + user.toString());
    var res ,resOTP;
    var bodyUser ;
    await http.post(Uri.parse(myurl),
        body: json.encode(SignupPage.user),
        headers: {'Content-Type': 'application/json'})
        .then((response) {
      print(response.statusCode);

      res =response.statusCode ;

      print('user saved  ==>   '+ response.body);
      http.post(
          Uri.parse("http://192.168.1.102:9089/user-service/keycloak/sendOtpSms"),
          body: response.body,
          headers: {'Content-Type': 'application/json'}).then((response) {
        print(response.statusCode);
        print(response.body);
        resOTP = response.statusCode;
        setState(() {
          SignupPage.user = response.body ;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPScreen(user: SignupPage.user,)));
        });

        print("fakri"+ SignupPage.user);

      });
    });


    if(res==200 && resOTP==200)
    {
      return resOTP ;
    }
    else return null ;

  }*/
}