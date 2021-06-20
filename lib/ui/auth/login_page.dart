import 'dart:convert';

import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/pages/login_signup/signup.dart';
import 'package:doctor_pro/ui/auth/sign_up_page.dart';
import 'package:doctor_pro/ui/profile/profilclientphysique.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget  {
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedCountry = 'CA';
  bool verifName = true;
  bool verifEmail = true;
  bool verifPhone = true;
  bool verifPassword = true;
  bool isRequest = false;
  bool visible = true;
  String passwordVerification = "";
  String ErrorMessage = '';
  String phoneNumber;
  String phoneIsoCode;
  String ErrorMessage1="";
  bool showPassword = true;
User user=new User();
  UserBloc userBloc=new UserBloc();
  void checkFullname(String v) {
    if (v == '')
      setState(() {
        verifName = false;
      });
    else
      setState(() {
        verifName = true;
      });
  }
  void checkPhone(String v) {
    if (v == '')
      setState(() {
        verifPhone = false;
      });
    else {
      if (v.length >= 8)
        setState(() {
          verifPhone = true;
          passwordVerification = "";
          ErrorMessage = "";
        });
      else
        setState(() {
          verifPhone = false;
          passwordVerification =
          'Mot de passe faible, il faut au moins 8 caractères';
          ErrorMessage1 = passwordVerification;
        });
    }
  }

  void checkPassword(String v) {
    if (v == '')
      setState(() {
        verifPassword = false;
        passwordVerification = "Veuillez saisir un mot de passe";
        ErrorMessage1 = passwordVerification;
      });
    else {
      if (v.length >= 8)
        setState(() {
          verifPassword = true;
          passwordVerification = "";
          ErrorMessage = "";
        });
      else
        setState(() {
          verifPassword = false;
          passwordVerification =
          'Mot de passe faible, il faut au moins 8 caractères';
          ErrorMessage1 = passwordVerification;
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    size: Size(double.infinity, 250.0),
                    painter: CurvePainter(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 250.0,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(width: 3.0, color: Colors.white),
                      image: DecorationImage(
                        image: AssetImage('assets/google.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            'Bienvenue!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),


          SizedBox(height: 30.0),
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.grey,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(

                controller: emailController,

                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  checkEmail(value);
                  user.email=emailController.text;
                },

                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.phone),
                  // TextStyle(color: verifPhone ? Colors.black : Colors.red),
                  errorText: verifPhone ? null : '',
                  errorStyle: TextStyle(
                      decorationColor: Colors.red, height: 0, fontSize: 0.1),
                  contentPadding: EdgeInsets.zero,    filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: verifPhone ? Colors.black : Colors.red, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: verifPhone ? Colors.black : Colors.red, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: verifPhone ? Colors.black : Colors.red, width: 1.5),
                  ),

                ),

              ),
            ),
          ),
          SizedBox(height: 30.0),
          // Email Field Start

          // Email Field End

          // Password Field Start
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: Colors.grey,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: passwordController,
                onChanged: (value) {
                  checkPassword(value);
                  user.password=passwordController.text;
                },

                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Mot passe",
                  prefixIcon: Icon(Icons.vpn_key),

                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color:Colors.black , width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black , width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color:Colors.black , width: 1.5),
                  ),
                ),
              ),
            ),
          ),
          // Password Field End
          SizedBox(height: 12.0),
          // Forgot Password Start
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              child: Text(
                'Mot passe oublié ?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Forgot Password End
          SizedBox(height: 20.0),
          // Sign in button start
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              elevation: 3.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  checkPassword(passwordController.text);
                  checkEmail(emailController.text);
                  setState(() {
                    ErrorMessage1="";
                  });

                    singin(user);

                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.red[800],
                  ),
                  child: Text(
                    'Connecter',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Sign in button End
          SizedBox(height: 25.0),
          // New User Text Start
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'New User?',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 3.0),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  )),
            ],
          ),
          // New User Text End
        ],
      ),
    );
  }




  singin(User user) async{
   String accessToken = await userBloc.login(user);
   if(accessToken!=null){
     postLoginRedirect();
   }
  }
  postLoginRedirect() async {

print("postLoginRedirect .................................. ");
    User storedUser = await TokenStorageBloc.getStoredUser() ;
print("postLoginRedirect 222222222222222222222222222222222 .................................. ");
      if (storedUser.role[0].name == "CLIENT_PHYSIQUE") {
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.fade,
                child: ProfileClienPhysiquePage(user: storedUser,)));
      }
      /*if(storedUser.role[0].name == "CLIENT_MORALE"){
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.fade,
                child: Profileclientmorale()));

      }if (storedUser.role[0].name=="PROFESSIONNEL"){
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.fade,
                child: Profileclientmorale()));

      }
      if (storedUser.role[0].name==""){
        Navigator.push(
            context,
            PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.fade,
                child: Profileclientmorale()));

      }*/

  }


  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
  void checkEmail(String v) {
    if (v == '')
      setState(() {
        verifEmail = false;
      });
    else
    if(validateEmail(v))
      setState(() {
        verifEmail = true;
      });
    else
      setState(() {
        verifEmail = false;
      });
  }


}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red[800];
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 200.0);
    path.quadraticBezierTo(size.width / 2, 300.0, size.width, 200.0);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}