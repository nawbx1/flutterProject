
import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/ui/auth/sign_up_page.dart';
import 'package:doctor_pro/ui/util/bottom_navigation_bar.dart';
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150.0,
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                /* Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    size: Size(double.infinity, 200.0),
                    //painter: CurvePainter(),
                  ),
                ),*/
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    width: 100.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(40.0),
                      //border: Border.all(width: 3.0, color: Colors.white),
                      image: DecorationImage(
                        image: AssetImage('assets/winek.png'),
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
                  user.email=emailController.text;
                },

                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.zero,    filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),

                ),

              ),
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

                controller: passwordController,
                obscureText: showPassword,

                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  user.password=passwordController.text;
                },

                decoration: InputDecoration(
                  hintText: "Mot de passe",
                  prefixIcon: Icon(Icons.vpn_key),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),

                  contentPadding: EdgeInsets.zero,    filled: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),

                ),

              ),
            ),
          ),
          SizedBox(height: 20.0),

          ErrorMessage!=''?Center(child: Text(ErrorMessage,style: TextStyle(color: Colors.red),)):Container(),
          // Password Field End
          SizedBox(height: 20.0),
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
                  color: redColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Forgot Password End

          SizedBox(height: 20.0),

          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              elevation: 3.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  singin(user);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: redColor,
                  ),
                  child: Text(
                    'Se connecter',
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
                'Nouveau utilisateur ?',
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
                    'Créer un compte',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: redColor,
                    ),
                  )),
            ],
          ),
          // New User Text End
        ],
      ),
    );
  }


  bool check() {
    ErrorMessage='';
    bool v=true ;
    if (emailController.text == '')
      setState(() {
        ErrorMessage+="verifier email\n";
        v=false;
      });
    if (passwordController.text == '')
      setState(() {
        ErrorMessage+="verifier password";
        v=false ;
      });

    return v ;

  }

  singin(User user) async{
    String accessToken ;
    print(check()) ;
    if(check())
    {
      accessToken = await userBloc.login(context,user);
      if(accessToken!=null){
        postLoginRedirect();
      }
      else ErrorMessage = "verifier votre email/mot de passe" ;
    }
    setState(() {
      ErrorMessage ;
    });

  }
  postLoginRedirect() async {

    String userRole = await TokenStorageBloc.getStoredUserRole() ;
    Navigator.push(
        context,
        PageTransition(
            duration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: BottomNavigation()));
  }




}