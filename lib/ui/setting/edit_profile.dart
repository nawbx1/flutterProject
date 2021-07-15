import 'dart:io';

import 'package:doctor_pro/bloc/RegionBloc.dart';
import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Gouvernorat.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/Region.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var CinController = TextEditingController();
  var MatriculeFiscaleController = TextEditingController();
  var specialityController = TextEditingController();

  String selectedGouv="Ariana" ;
  String selectedRegion="Ariana Ville" ;

  bool loading=true ;
  UserBloc userBloc=new UserBloc();
  User user ;
  String userRole;
  @override
  void initState()  {
    initProfile();
    fetchGouvernorat();

    super.initState();
  }


  initProfile() async{
    print("initProfile");
    userRole= await TokenStorageBloc.getStoredUserRole();
    print('userRole');
    print(userRole);
    user = await userBloc.getUserByKeycloak();
    print(user);

    if(user!=null) {
      setState(() {
        loading=false ;
      });

      nameController.text = user.username;
      phoneController.text = user.phone.toString();
      emailController.text = user.email;
      CinController.text = user.cin.toString();
      MatriculeFiscaleController.text = user.matriculeFiscale ;

      if(user.address!=null && user.address.region!=null && user.address.region.gouvernorat!=null )
      {
        selectedGouv = user.address.region.gouvernorat.name ;
        selectedRegion = user.address.region.region ;
      }

      (user.speciality!=null)?

      user.speciality.forEach((element) {
        specialityController.text+= element.name + " " ;
      }):"";



    }

  }

  RegionBloc regionBloc =new RegionBloc();
  List<Gouvernorat>GouvList = [];
  List<DropdownMenuItem> _dropdownMenuItems=[];
  List<DropdownMenuItem> _dropdownMenuRegionItems=[];

  void fetchGouvernorat() async {
    List<Gouvernorat> GouvList2 = await regionBloc.fetchGouvernorat();
    setState(() {
      GouvList= GouvList2;
      GouvList.forEach((element) {
        print("element "+ element.toString());
        _dropdownMenuItems.add(
          DropdownMenuItem(child: Text(element.name),value: element,),
        );
      });

    });

  }


  List<Region> regions=[] ;


  getRegions(id)async{
    print("getRegions");
    print(id);
    _dropdownMenuRegionItems=[];
    regions = await regionBloc.fetchRegionByGouvernoartId(id);
    setState(() {
      regions;

      regions.forEach((element) {
        _dropdownMenuRegionItems.add(
          DropdownMenuItem(child: Text(element.region),value: element,),
        );
      });


    });

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    changeFullName() {
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
                        "Change Full Name",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: nameController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Full Name',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Cancel',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                user.name = nameController.text;
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Okay',
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

    changeMatriculeFiscale(){
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
                        "Changer Matricule Fiscale",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: MatriculeFiscaleController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'annuler',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                user.matriculeFiscale = MatriculeFiscaleController.text;
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'confirmer',
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
    changegouvernorat() {
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
                        "Changer gouvernorat",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                     SearchableDropdown.single(
                         items:_dropdownMenuItems ,
                         displayClearIcon: false,
                          hint: Padding(
                            padding: const EdgeInsets.all(2.0),
                              child: Text(selectedGouv),
                          ),
                          searchHint: "Gouvernorat",
                          onChanged: (value) {
                            setState(() {
                              getRegions(value.id);
                              (user.address.region==null)?user.address.region = new Region():
                              (user.address.region.gouvernorat==null)?user.address.region.gouvernorat = new Gouvernorat():
                              user.address.region.gouvernorat = value ;
                              selectedGouv = value.name;
                              print("Gouvernorat ===== ");
                              print(value);
                            });

                          },

                        ),

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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Annuler ',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedRegion="";
                                (user.address.region==null)?user.address.region = new Region():
                                (user.address.region.gouvernorat==null)?user.address.region.gouvernorat = new Gouvernorat():
                                user.address.region.gouvernorat.name  = selectedGouv ;
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Ok',
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
    changeRegion() {
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
                        "Changer Region",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      SearchableDropdown.single(
                        items:_dropdownMenuRegionItems ,
                        displayClearIcon: false,
                        hint: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(selectedRegion),
                        ),

                        searchHint: "Région",
                        onChanged: (value) {
                          setState(() {

                            /*selectedSpeciality=value;
                                          Speciality s = value ;
                                          FlutterStepperPage.user.speciality = [new Speciality.name(s.id,s.name)];
                                          */
                            user.address.region = value ;
                            selectedRegion = value.region ;

                          });

                        },
                        onClear: (){
                          setState(() {
                            // selectedGouv = null;
                          });
                        },
                        isExpanded: true,
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Annuler ',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                user.address.region.region   = selectedRegion ;
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Ok',
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
                        style: blackColorButtonTextStyle,
                        decoration: InputDecoration(
                          hintText: 'Old Password',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        style: blackColorButtonTextStyle,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        style: blackColorButtonTextStyle,
                        decoration: InputDecoration(
                          hintText: 'Confirm New Password',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Cancel',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Okay',
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
    changecin() {
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
                        "changer num Cin",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: CinController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Entrer Numero de CIN',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Annuler ',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                user.cin = int.parse(CinController.text);
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Ok',
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

    changePhoneNumber() {
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
                        "Change Phone Number",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: phoneController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Cancel',
                                style: blackColorButtonTextStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                user.phone = int.parse(phoneController.text);
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Okay',
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
    changeEmail() {
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
                        "Change Email",
                        style: blackHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextField(
                        controller: emailController,
                        style: blackColorButtonTextStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email Address',
                          hintStyle: greySmallTextStyle,
                        ),
                      ),
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
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text('Cancel',
                                  style: blackColorButtonTextStyle),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                user.email = emailController.text;
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: (width / 3.5),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'Okay',
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


    // client physique
    Column clientPhysique(){
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Profile Image Start
          InkWell(
            onTap: _selectOptionBottomSheet,
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
                        child:   (user.profile!=null && user.profile.profileImage!=null )? Image.network(
                            apiUrl+'user-service/uploads/'+user.profile.profileImage.mediaURL,
                            height: 100,
                            width: 100,
                            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              return Image(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/user.png"),
                              );
                            }
                        ):Image(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/user.png"),
                        ),
                      ),

                     Container(
                      height: 22.0,
                      width: 22.0,
                      margin: EdgeInsets.all(fixPadding / 2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.0),
                        border: Border.all(
                            width: 1.0, color: whiteColor.withOpacity(0.7)),
                        color: Colors.orange,
                      ),
                      child: Icon(Icons.add, color: whiteColor, size: 15.0),
                    ),],),
            ),
          ),
          // Profile Image End
          // Full Name Start
          InkWell(
            onTap: changecin,
            child: getTile('CIN', CinController.text),
          ),
          InkWell(
            onTap: changeFullName,
            child: getTile('Nom/Prénom',  nameController.text),
          ),
          // Full Name End
          // Phone Start
          InkWell(
            onTap: changePhoneNumber,
            child: getTile('Téléphone', phoneController.text),
          ),
          // Phone End
          // Email Start
          InkWell(
            onTap: changeEmail,
            child: getTile('Email', emailController.text),
          ),
          // Email End
          InkWell(
            onTap: changegouvernorat,
            child:
            getTile('gouvernorat',selectedGouv),
          ),
          InkWell(
            onTap: changeRegion,
            child:
            getTile('Région', selectedRegion),
          ),
        ],
      );
    }


    // client moral
    Column clientMoral(){
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Profile Image Start
          InkWell(
            onTap: _selectOptionBottomSheet,
            child: Container(
              width: 100.0,
              height: 100.0,
              margin: EdgeInsets.all(fixPadding * 4.0),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 2.0, color: whiteColor),
                image: DecorationImage(
                  image: AssetImage('assets/user/user_3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 22.0,
                width: 22.0,
                margin: EdgeInsets.all(fixPadding / 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  border: Border.all(
                      width: 1.0, color: whiteColor.withOpacity(0.7)),
                  color: Colors.orange,
                ),
                child: Icon(Icons.add, color: whiteColor, size: 15.0),
              ),
            ),
          ),
          // Profile Image End
          // Full Name Start
          InkWell(
            onTap: changeMatriculeFiscale,
            child: getTile('Matricule Fiscale', MatriculeFiscaleController.text),
          ),
          InkWell(
            onTap: changeFullName,
            child: getTile('Raison Sociale',  nameController.text),
          ),
          // Full Name End
          // Phone Start
          InkWell(
            onTap: changePhoneNumber,
            child: getTile('Téléphone', phoneController.text),
          ),
          // Phone End
          // Email Start
          InkWell(
            onTap: changeEmail,
            child: getTile('Email', emailController.text),
          ),
          // Email End
          InkWell(
            onTap: changegouvernorat,
            child:
            getTile('gouvernorat',selectedGouv),
          ),
          InkWell(
            onTap: changeRegion,
            child:
            getTile('Région', selectedRegion),
          ),
        ],
      );
    }


    // Professionnel
    Column Professionnel(){
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Profile Image Start
          InkWell(
            onTap: _selectOptionBottomSheet,
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
                    child: (user.profile!=null && user.profile.profileImage!=null )? Image.network(
                        apiUrl+'user-service/uploads/'+user.profile.profileImage.mediaURL,
                        height: 100,
                        width: 100,
                        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                          return Image(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/user.png"),
                          );
                        }
                    ):Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/user.png"),
                    ),
                  ),

                  Container(
                    height: 22.0,
                    width: 22.0,
                    margin: EdgeInsets.all(fixPadding / 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      border: Border.all(
                          width: 1.0, color: whiteColor.withOpacity(0.7)),
                      color: Colors.orange,
                    ),
                    child: Icon(Icons.add, color: whiteColor, size: 15.0),
                  ),],),

            ),
          ),
          // Profile Image End
          // Full Name Start
          InkWell(
            onTap: changeMatriculeFiscale,
            child: getTile('Matricule Fiscale', MatriculeFiscaleController.text),
          ),
          InkWell(
            onTap: changeFullName,
            child: getTile('Nom et prénom',  nameController.text),
          ),
          // Full Name End
          InkWell(

            child: getTile('Specialité ',  specialityController.text),
          ),
          // Full Name End


          // Phone Start
          InkWell(
            onTap: changePhoneNumber,
            child: getTile('Téléphone', phoneController.text),
          ),
          // Phone End
          // Email Start
          InkWell(
            onTap: changeEmail,
            child: getTile('Email', emailController.text),
          ),
          // Email End
          InkWell(
            onTap: changegouvernorat,
            child:
            getTile('gouvernorat', selectedGouv),
          ),
          InkWell(
            onTap: changeRegion,
            child:
            getTile('Région', selectedRegion),
          ),
        ],
      );
    }


    // Entreprise
    Column Entreprise(){
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Profile Image Start
          InkWell(
            onTap: _selectOptionBottomSheet,
            child: Container(
              width: 100.0,
              height: 100.0,
              margin: EdgeInsets.all(fixPadding * 4.0),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 2.0, color: whiteColor),
                image: DecorationImage(
                  image: AssetImage('assets/user/user_3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: 22.0,
                width: 22.0,
                margin: EdgeInsets.all(fixPadding / 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  border: Border.all(
                      width: 1.0, color: whiteColor.withOpacity(0.7)),
                  color: Colors.orange,
                ),
                child: Icon(Icons.add, color: whiteColor, size: 15.0),
              ),
            ),
          ),
          // Profile Image End
          // Full Name Start
          InkWell(
            onTap: changeMatriculeFiscale,
            child: getTile('Matricule Fiscale', MatriculeFiscaleController.text),
          ),
          InkWell(
            onTap: changeFullName,
            child: getTile('Raison Sociale',  nameController.text),
          ),
          // Full Name End
          InkWell(

            child: getTile('Specialité ',  specialityController.text),
          ),
          // Full Name End


          // Phone Start
          InkWell(
            onTap: changePhoneNumber,
            child: getTile('Téléphone', phoneController.text),
          ),
          // Phone End
          // Email Start
          InkWell(
            onTap: changeEmail,
            child: getTile('Email', emailController.text),
          ),
          // Email End
          InkWell(
            onTap: changegouvernorat,
            child:
            getTile('gouvernorat',selectedGouv),
          ),
          InkWell(
            onTap: changeRegion,
            child:
            getTile('Région', selectedRegion),
          ),
        ],
      );
    }
    updateInfos() async {
      print("update user");
      print(user);

      user = await userBloc.updateuser(user);

      print(user);
      if(user!=null)
      Navigator.pop(context);
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

              updateInfos();
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
          (!loading)?
          (userRole=="CLIENT_PHYSIQUE") ? clientPhysique() :
          (userRole=="CLIENT_MORAL") ? clientMoral() :
          (userRole=="PROFESSIONNEL") ? Professionnel() :
          (userRole=="GESTIONNAIRE") ? Entreprise() :
          Column()

          :Center(child: CircularProgressIndicator( backgroundColor: Colors.red,  strokeWidth: 2,)),
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





  File _image;
  Future openGallery() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
       _uploadImage();
    });
  }

  Future openCamera() async {

    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
       _image = File(pickedFile.path);
      _uploadImage();
    });
  }
  Media media  =new Media();

  Future<bool> _uploadImage() async {
    print(_image);
    media.file =  await _image.readAsBytes();

    setState((){
      media;
      media.fileName=_image.path.substring(_image.path.lastIndexOf('.'),_image.path.length) ;

    });
    User u = await userBloc.updatePhotoProfile(media);
    print("userrrrr");
    print(u);


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
                            'Choisir Option',
                            textAlign: TextAlign.center,
                            style: blackHeadingTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            openCamera();
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
                            openGallery();
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
                                  'Gallerie',
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
