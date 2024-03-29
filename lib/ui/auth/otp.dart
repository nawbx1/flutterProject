import 'dart:async';
import 'dart:convert';

import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/ui/auth/login_page.dart';
import 'package:doctor_pro/ui/profile/profilclientmoral.dart';
import 'package:doctor_pro/ui/profile/profilclientphysique.dart';
import 'package:doctor_pro/ui/profile/profilprofessionnelmorale.dart';
import 'package:doctor_pro/ui/profile/profilprofessionnelphy.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_pro/constant/constant.dart';

import 'package:doctor_pro/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doctor_pro/ui/rendez_vous/Speciality_Page.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key key , @required this.user }) : super(key: key);
  final User user;


  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var firstController = TextEditingController();
  var secondController = TextEditingController();
  var thirdController = TextEditingController();
  var fourthController = TextEditingController();
  var fivethController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();
  FocusNode fivethFocusNode = FocusNode();
  String OTPText = '';
  UserBloc userBloc=new UserBloc();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Winek fond blanc.jpeg'), fit: BoxFit.cover ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      'Vérification',
                      style: loginBigTextStyle,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Entrez le code OTP .',
                      style: whiteSmallLoginTextStyle,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  // OTP Box Start
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // 1 Start
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            controller: firstController,
                            style: inputOtpTextStyle,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(18.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (v) {
                              OTPText += v ;
                              FocusScope.of(context)
                                  .requestFocus(secondFocusNode);
                            },
                          ),
                        ),
                        // 1 End
                        // 2 Start
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            focusNode: secondFocusNode,
                            controller: secondController,
                            style: inputOtpTextStyle,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(18.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (v) {
                              OTPText += v ;
                              FocusScope.of(context)
                                  .requestFocus(thirdFocusNode);
                            },
                          ),
                        ),
                        // 2 End
                        // 3 Start
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            focusNode: thirdFocusNode,
                            controller: thirdController,
                            style: inputOtpTextStyle,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(18.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (v) {
                              OTPText += v ;

                              FocusScope.of(context)
                                  .requestFocus(fourthFocusNode);
                            },
                          ),
                        ),
                        // 3 End
                        // 4 Start
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            focusNode: fourthFocusNode,
                            controller: fourthController,
                            style: inputOtpTextStyle,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(18.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (v) {
                              OTPText += v ;

                              FocusScope.of(context)
                                  .requestFocus(fivethFocusNode);

                            },
                          ),
                        ),
                        Container(
                          width: 50.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextField(
                            focusNode: fivethFocusNode,
                            controller: fivethController,
                            style: inputOtpTextStyle,
                            keyboardType: TextInputType.number,
                            cursorColor: whiteColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(18.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (v) {
                              OTPText += v ;


                            },
                          ),
                        ),
                        // 4 End
                      ],
                    ),
                  ),
                  // OTP Box End
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Je n\'ai pas reçu le code OTP !',
                          style: greySmallTextStyle,
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Renvoyer',
                            style: inputLoginTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {

                        verif();

                      },
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.5, 0.9],
                            colors: [
                              blueColor.withOpacity(0.8),
                              blueColor.withOpacity(0.8),
                              blueColor.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Text(
                          'Envoyer',
                          style: inputLoginTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<dynamic> verif() async{
    print(widget.user);
    bool res= await userBloc.verifOTP(widget.user.id,OTPText);
    if(res)
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: LoginPage()));

  }




}


