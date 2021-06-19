import 'dart:convert';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/ui/auth/confirmer.dart';
import 'package:doctor_pro/ui/auth/otp.dart';
import 'package:doctor_pro/ui/auth/password_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'dart:collection';

import 'formulaireclient.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);



  @override
  _SignupPageState createState() => _SignupPageState();
}


int _curStep = 2;
UserBloc userBloc =new UserBloc();

class _SignupPageState extends State<SignupPage> {

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
  FlutterStepperPage({Key key,  this.title}) : super(key: key);

  final String title;
  static User user =new User();
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
        title: Text('Mot De Passe'),
        content: PassowrdForm(),

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
                  if(PassowrdForm.verif )
                    currentStep = currentStep + 1;
                }
              } else {
                doRegister(FlutterStepperPage.user);

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


  void doRegister(User user) async {
    print("user doregister");
    print(user.toString());
    dynamic usersaved  = await userBloc.saveuser(user) ;

    print("usersaved ==> " + usersaved.toString() );

    if(usersaved!=null)
      Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPScreen( user: usersaved, )));

   /* //User user =new User();
    String myurl = apiUrl+"user-service/keycloak/save";
    print("do register " + user.toString());
    var res ,resOTP;
    var bodyUser ;
    await http.post(Uri.parse(myurl),
        body: json.encode(user),
        headers: {'Content-Type': 'application/json'})
        .then((response) {
      print(response.statusCode);

      res =response.statusCode ;

      print('user saved  ==>   '+ response.body);
      http.post(
          Uri.parse(apiUrl+"user-service/keycloak/sendOtpSms"),
          body: response.body,
          headers: {'Content-Type': 'application/json'}).then((response) {
        print(response.statusCode);
        print(response.body);
        resOTP = response.statusCode;
        setState(() {
          user = User.fromJson(response.body.toString() as Map ) ;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>OTPScreen( user: user, )));
        });

        print("fakri"+ user.toString());

      });
    });


    if(res==200 && resOTP==200)
    {
      return resOTP ;
    }
    else return null ;*/

  }


}
