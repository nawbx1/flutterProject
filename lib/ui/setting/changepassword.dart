import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:flutter/material.dart';

class changepassword extends StatefulWidget {
  changepassword({Key key , @required this.user }) : super(key: key);
  User user;
  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {

  UserBloc userBloc=new UserBloc();
  var passwordController = TextEditingController();

  static TextEditingController passverifController = TextEditingController();
  static TextEditingController nouvpasswordController = TextEditingController();
  static TextEditingController confinouvpasswordController = TextEditingController();
  bool verifpass=true;
  bool verifpassnouv=true;
  bool verifpassnn=true;
  String passwordVerification = "";
  String ErrorMessage = '';
  String ErrorMessage1='';
  @override
  void initState() {
    super.initState();

  }
  /*void checkpass1(String v) {
    if (v == '')
      setState(() {
        verifpass = false;
      });
    else {
      if (passverifController.text==widget.user.password.length)
        setState(() {
          verifpass = true;

        });
      else
        setState(() {
          verifpass = false;
          passwordVerification =
          'verifier mot passe';
          ErrorMessage= passwordVerification;
        });
    }
  }*/
  void checkpass2(String v) {
    if (v == '')
      setState(() {
        verifpassnn = false;
      });
    else {
      if (nouvpasswordController.text==confinouvpasswordController.text && (v.length>=8))
        setState(() {
          verifpassnn = true;

        });

      else
        setState(() {
          verifpassnn = false;
          passwordVerification =
          'verifier le nouveau mot passe';
          ErrorMessage1= passwordVerification;
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    changePassword() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Changez votre mot de passe",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),


                      TextField(
                        obscureText: true,
                        controller: nouvpasswordController,
                        style: blackColorButtonTextStyle,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color:verifpassnouv ? Colors.black : Colors.red, width: 1.5),
                          ),
                          hintText: 'Nouveau mot passe',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      TextField(
                        controller: confinouvpasswordController,
                        onChanged: (value){
                          checkpass2(value);
                        },
                        obscureText: true,
                        style: blackColorButtonTextStyle,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color:verifpassnn ? Colors.black : Colors.red, width: 1.5),
                          ),
                          hintText: 'confirmer mot passe',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      Text(ErrorMessage),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Annuler',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              String keycloak = await TokenStorageBloc.getStoredUserKeycloak()  ;
                              var updatepassword = await userBloc.updatepassword(keycloak,nouvpasswordController.text);
                              if(updatepassword=="ok")
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: (width / 3),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Confirmer',
                                style: whiteColorButtonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              child: Text(
                'Save',
                style: primaryColorNormalTextStyle,
              ),
            ),
          ),

        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Profile Image Start
              InkWell(
                //onTap: _selectOptionBottomSheet,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.all(fixPadding * 4.0),
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30.0)),
                        child: Image.network(
                            (widget.user.profile!=null && widget.user.profile.profileImage!=null )?
                            apiUrl+'user-service/uploads/'+widget.user.profile.profileImage.mediaURL
                                :"",
                            height: 150,
                            width: 150,
                            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              return Image(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/user.png"),
                              );
                            }
                        ),
                      ),

                     ],),


                ),
              ),
              // Full Name End
              // Password Start
              InkWell(
                onTap: changePassword,
                child: getTile('Password',''),
              ),

              // Password End
              // Phone Start

            ],
          ),
        ],
      ),
    );
  }

  getTile(String title, String value) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          right: fixPadding, left: fixPadding, bottom: fixPadding * 1.5),
      padding: EdgeInsets.only(
        right: fixPadding,
        left: fixPadding,
        top: fixPadding * 2.0,
        bottom: fixPadding * 2.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.5,
            spreadRadius: 1.5,
            color: Colors.grey[200],
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width - 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: (width - 80.0) / 2.4,
                  child: Text(
                    title,
                    style: greyNormalTextStyle,
                  ),
                ),
                Container(
                  width: (width - 80.0) / 2.0,
                  child: Text(
                    value,
                    style: blackNormalTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
            color: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select Options (Camera or Gallery) Start Here
  void _selectOptionBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Choose Option',
                            textAlign: TextAlign.center,
                            style: blackHeadingTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Camera', style: blackSmallTextStyle),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.photo_album,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Upload from Gallery',
                                  style: blackSmallTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
// Bottom Sheet for Select Options (Camera or Gallery) Ends Here
}

