import 'package:flutter/material.dart';

class profil extends StatefulWidget {

  const profil({Key key}) : super(key: key);

  static bool verif=false;
  @override
  _profilState createState() => _profilState();
}

bool verifPassword = true;
bool verifPasswordc = true;
class _profilState extends State<profil> {
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController passwordconfController = TextEditingController();
  String ErrorMessage = '';

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
  String passwordVerification = "";
  String ErrorMessage1="";
  bool showPassword = true;
  bool showConfirmPassword = true;
  void verifpassword(String v ){
    if(v=='')
      setState(() {
        verifPasswordc = false;
      });
    else if( passwordconfController.text==passwordController.text)
      setState(() {
        verifPasswordc = true;

      });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Column(
          children: [

            TextFormField(
                obscureText: showPassword,
                onChanged: (value) {
                  checkPassword(value); verif();
                },
                textInputAction: TextInputAction.next,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: IconButton(

                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => setState((  ) => showPassword = !showPassword),
                  ),
                  hintText: 'Mot passe',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:verifPassword ? Colors.black : Colors.red, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color:verifPassword ? Colors.black : Colors.red, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color:verifPassword ? Colors.black : Colors.red, width: 1.5),
                  ),
                ),
                controller: passwordController),
            SizedBox(height: 20),
            TextFormField(
                onChanged: (value) {
                  verifpassword(value) ; verif();
                },
                obscureText: showConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Confirm mot passe',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color:verifPasswordc ? Colors.black : Colors.red, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color:verifPasswordc ? Colors.black : Colors.red, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color:verifPasswordc ? Colors.black : Colors.red, width: 1.5),
                  ),


                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => setState(
                            () => showConfirmPassword = !showConfirmPassword),

                  ),
                ),
                controller: passwordconfController

            )
          ],
        )

    );


  }
  verif(){

    if(verifPasswordc&&verifPassword)
      profil.verif=true;
    else{
      profil.verif=false;
    }
  }

}






