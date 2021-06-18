import 'dart:convert';
import 'package:doctor_pro/pages/login_signup/otp.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_pro/pages/login_signup/StepProgressView.dart';
import 'package:doctor_pro/pages/login_signup/confirmer.dart';
import 'package:doctor_pro/pages/login_signup/formulaireclient.dart';
import 'package:doctor_pro/pages/login_signup/formulaireclient.dart';
import 'package:doctor_pro/pages/login_signup/log.dart';
import 'package:doctor_pro/pages/login_signup/profilclient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'dart:collection';

import 'formulaireclient.dart';

class signup1 extends StatefulWidget {
  const signup1({Key key}) : super(key: key);
  static dynamic user={
    "id":"",
    "username":"",
    "email":"",
    "password":"",
    "role":[],
    "verified":false,
    "matriculeFiscale":"",
    "speciality":[],
    "cin":"",
    "phone":""

  };


  @override
  _signup1State createState() => _signup1State();
}


int _curStep = 2;

class _signup1State extends State<signup1> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 60.0)),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hh.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Créer un nouveau compte',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Signika Negative',
            ),
          ),
          //StepperBody(),
          Expanded(
            child: FlutterStepperPage(title: 'hello'),
          ),

          //   StepProgressView(icons: stepIcons,
          // width: MediaQuery.of(context).size.width,
          //   curStep: _curStep,
          //  color: Color(0xffe5649e),),
        ]),
      ),
    );
  }
}

class FlutterStepperPage extends StatefulWidget {
  FlutterStepperPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterStepperPageState createState() => _FlutterStepperPageState();
}

final formKey = GlobalKey<FormState>();

class _FlutterStepperPageState extends State<FlutterStepperPage> {
  var currentStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Text('Inscription'),
        content: Column(
          children: [
         //   client.verif?Text(show): Container(),
            client()
          ],
        ),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Profil'),
        content: profil(),

        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Valider'),
        content: confirm(),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    return Scaffold(
      body: Container(

        child:

        Stepper(

          currentStep: this.currentStep,
          steps: steps,
          type: StepperType.horizontal,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                if (currentStep == 0) {
                  if(client.verif )
                  currentStep = currentStep + 1;
                  else{




                  }
                } else if (currentStep == 1) {
                  if(profil.verif )
                  currentStep = currentStep + 1;
                }
              } else {
                doRegister();

              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }

  Future<dynamic> doRegister() async {
    String myurl = "http://192.168.1.102:9089/user-service/keycloak/save";
  print("do register " + signup1.user.toString());
    var res ,resOTP;
    var bodyUser ;
    await http.post(Uri.parse(myurl),
        body: json.encode(signup1.user),
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
          signup1.user = response.body ;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPScreen(user: signup1.user,)));
        });

        print("fakri"+ signup1.user);

      });
    });


    if(res==200 && resOTP==200)
    {
      return resOTP ;
    }
    else return null ;

  }


}
