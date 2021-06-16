import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/pages/login_signup/profilclient.dart';
import 'package:doctor_pro/pages/login_signup/signup.dart';
import 'package:doctor_pro/pages/speciality/speciality.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';
class client extends StatefulWidget {
  const client({Key key}) : super(key: key);

  static bool verif=false;
  static String role="";
  @override
  _clientState createState() => _clientState();
}



class _clientState extends State<client> {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController emailController = new  TextEditingController();
  static TextEditingController fullnameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController cinController = TextEditingController();
  static TextEditingController matriculeController = TextEditingController();


  int _radioValue1=-1 ,_radioValue2=-1 ,_radioValue3=-1;
  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value ;
      _radioValue3=-1;
      _radioValue2=-1;
      client.role="client";

    });
  }

  void _handleRadioValueChange2(int value){
    setState(() {
      _radioValue2 = value;
      _radioValue3=-1;
      client.role="professionnel";
    });
  }

  void _handleRadioValueChange3(int value){
    setState(() {
      _radioValue3 = value;
      _radioValue2=-1;
    });
  }
  String selectedCountry = 'CA';
  bool verifName = true;
  bool verifEmail = true;
  bool verifPhone = true;
  bool verifCin = true;
  bool isRequest = false;
  bool visible = true;
  String passwordVerification = "";
  String ErrorMessage = '';
  String phoneNumber;
  String phoneIsoCode;
  String ErrorMessage1="";
  bool showPassword = true;
  bool showConfirmPassword = true;

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
  void checkCin(String v) {
    if (v == '')
      setState(() {
        verifCin = false;
      });
    else {
      if (v.length >= 8)
        setState(() {
          verifCin = true;
          passwordVerification = "";
          ErrorMessage = "";
        });
      else
        setState(() {
          verifCin = false;
          passwordVerification =
          'Mot de passe faible, il faut au moins 8 caractères';
          ErrorMessage1 = passwordVerification;
        });
    }
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


@override
void initState(){
    print('rrr');
  fetchSpeciality();
  signup1.user['role']=[_radioValue2==0?"CLIENT_PHYSIQUE":_radioValue2==1?"ClIENT_MORALE":_radioValue3==0?"PROFESSIONNEL_PHYSIQUE":_radioValue3==1?"PROFESSIONNEL_MORALE":null];
}

  @override
  Widget build(BuildContext context) {


    return Container(

        child: Form(
          key: formKey,
          autovalidate: false,
          child: Column(
            children: <Widget>[
              Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Radio(
                value: 0,
                groupValue: _radioValue1,
                onChanged: _handleRadioValueChange1,
              ),
              new Text(
                'Client',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              new Radio(
                value: 1,
                groupValue: _radioValue1,
                onChanged: _handleRadioValueChange1,
              ),
              new Text(
                'Artisan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

            ],

          ),
              _radioValue1==0?value2():_radioValue1==1?value3():Container(),


          SizedBox(height: 20),





                ],


            //  _radioValue1==0?formclientphysique():formclientmoral(),


          ),
        ));
  }
  formclientmoral(){
  return Column(
    children: [
      TextFormField(
        onChanged: (value) {
          checkPhone(value)
          ;verif();
          signup1.user['phone']=phoneController.text;
        },
        onEditingComplete:() {


        },
        textInputAction: TextInputAction.next,
        maxLines: 1,
        keyboardType: TextInputType.number,
        controller: phoneController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          hintText: 'Tel',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
          ),
        ),


      ),




      SizedBox(height: 20),
      TextFormField(
          onChanged: (value) {

            verif();signup1.user['username']=fullnameController.text;
          },

          textInputAction: TextInputAction.next,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            hintText: 'Raison Social',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
            ),

          ),


          controller: fullnameController),
      SizedBox(height: 20),
      TextFormField(
          onChanged: (value) {

           verif();signup1.user['matricule_fiscale']=matriculeController.text;
          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            hintText: 'RNE',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
            ),

          ),


          controller: matriculeController),
      SizedBox(height: 20),
      TextFormField(
          onChanged: (value) {
            verif(); checkEmail(value);signup1.user['email']=emailController.text;
          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.grey,
            ),
            hintText: 'Email',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
            ),
          ),
          controller: emailController),
      SizedBox(height: 20),

    ],
  );





  }
  formclientphysique(){
    return Column(
      children: [


        TextFormField(
          onChanged: (value) {
            checkPhone(value)
            ;verif();signup1.user['phone']=phoneController.text;
          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          keyboardType: TextInputType.number,
          controller: phoneController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.phone,
              color: Colors.grey,
            ),
            hintText: 'Tel',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
          ),


        ),
        SizedBox(height: 20),
        TextFormField(
          onChanged: (value) {
            checkPhone(value)
            ;verif();
            signup1.user['cin']=cinController.text;
          },
          onEditingComplete:() {


          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          keyboardType: TextInputType.number,
          controller: cinController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            hintText: 'CIN',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifCin ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifCin ? Colors.black : Colors.red, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifCin ? Colors.black : Colors.red, width: 1.5),
            ),
          ),


        ),

        SizedBox(height: 20),
        TextFormField(
            onChanged: (value) {

              verif();signup1.user['username']=fullnameController.text;
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              hintText: 'Nom',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),

            ),


            controller: fullnameController),
        SizedBox(height: 20),
        TextFormField(
            onChanged: (value) {
              verif(); checkEmail(value);signup1.user['email']=emailController.text;
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Email',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
            ),
            controller: emailController),
        SizedBox(height: 20),

      ],
    );





  }
  formprofessionnelmoral(){
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            checkPhone(value)
            ;verif();signup1.user['phone']=phoneController.text;
          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          keyboardType: TextInputType.number,
          controller: phoneController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.phone,
              color: Colors.grey,
            ),
            hintText: 'Tel',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
          ),


        ),

        SizedBox(height: 20),

        TextFormField(
            onChanged: (value) {

              verif();signup1.user['username']=fullnameController.text;
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              hintText: 'Raison Social',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),

            ),


            controller: fullnameController),
        SizedBox(height: 20),
        TextFormField(
            onChanged: (value) {

              verif();signup1.user['matricule_fiscale']=matriculeController.text;
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              hintText: 'RNE',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),

            ),


            controller: matriculeController),
        SizedBox(height: 20),
        TextFormField(
            onChanged: (value) {
              verif(); checkEmail(value);signup1.user['email']=emailController.text;
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Email',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
            ),
            controller: emailController),
        SizedBox(height: 20),
    SearchableDropdown.single(

    items:_dropdownMenuItems ,
    label: Padding(
    padding: EdgeInsets.only(left: 15, top: 5),
    child: Text(
    "Specialité",
   // style: AppTheme.dropdownTitleStyle,
    ),
    ),
    hint: Padding(
    padding: const EdgeInsets.all(2.0),
    child: Text("Choisissez le type de votre specialité"),
    ),
    clearIcon: Icon(
    Icons.delete,
    color: Colors.red,
    ),
    searchHint: "Choisissez le type de Specialite",
    onChanged: (value) {
      //signup1.user['speciality_id']=selectedSpeciality.id;
    setState(() {
    selectedSpeciality=value;
    });

    },
    onClear: (){
    setState(() {
    selectedSpeciality = null;
    });
    },
    isExpanded: true,
    ),


      ],
    );





  }
  formprofessionnel(){
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            checkPhone(value)
            ;verif();signup1.user['phone']=phoneController.text;
          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          keyboardType: TextInputType.number,
          controller: phoneController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.phone,
              color: Colors.grey,
            ),
            hintText: 'Tel',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifPhone ? Colors.black : Colors.red, width: 1.5),
            ),
          ),


        ),

        SizedBox(height: 20),


        TextFormField(
          onChanged: (value) {
            checkPhone(value)
            ;verif();
            signup1.user['cin']=cinController.text;
          },
          onEditingComplete:() {


          },
          textInputAction: TextInputAction.next,
          maxLines: 1,
          keyboardType: TextInputType.number,
          controller: cinController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            hintText: 'CIN',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color:verifCin ? Colors.black : Colors.red, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifCin ? Colors.black : Colors.red, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color:verifCin ? Colors.black : Colors.red, width: 1.5),
            ),
          ),


        ),
        SizedBox(height: 20),
        TextFormField(
            onChanged: (value) {

              verif();checkEmail(value);signup1.user['username']=fullnameController.text;
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              hintText: 'Nom',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifName ? Colors.black : Colors.red, width: 1.5),
              ),

            ),


            controller: fullnameController),
        SizedBox(height: 20),


        TextFormField(
            onChanged: (value) {
              verif(); checkEmail(value);
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Email',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color:verifEmail ? Colors.black : Colors.red, width: 1.5),
              ),
            ),
            controller: emailController),

        SizedBox(height: 20),
        SearchableDropdown.single(

          items:_dropdownMenuItems ,
          label: Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: Text(
              "Specialité",
              // style: AppTheme.dropdownTitleStyle,
            ),
          ),
          hint: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Choisissez le type de votre specialité"),
          ),
          clearIcon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          searchHint: "Choisissez le type de Specialite",
          onChanged: (value) {
            //signup1.user['speciality_id']=selectedSpeciality.id;
            setState(() {
              selectedSpeciality=value;
            });

          },
          onClear: (){
            setState(() {
              selectedSpeciality = null;
            });
          },
          isExpanded: true,
        ),


      ],
    );





  }
  value2(){
  return Column(
    children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        new Radio(
        value: 0,

          groupValue: _radioValue2,
            onChanged: _handleRadioValueChange2

        ),
        new Text(
          'Client physique',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        new Radio(
          value: 1,
          groupValue: _radioValue2,
          onChanged: _handleRadioValueChange2,
        ),
        new Text(
          'Client morale',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),

]

      ),
      _radioValue2==0?formclientphysique():_radioValue2==1?formclientmoral():Container(),
    ],
  );

  }
  value3(){
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Radio(
            value: 0,
            groupValue: _radioValue3,
            onChanged: _handleRadioValueChange3,
          ),
          new Text(
            'Professionnel',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          new Radio(
            value: 1,
            groupValue: _radioValue3,
            onChanged: _handleRadioValueChange3,
          ),
          Expanded(
            child: new Text(
              'Professionnel morale(entreprise)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],

      ),
      _radioValue3==0?formprofessionnel():_radioValue3==1?formprofessionnelmoral():Container(),

    ],

  );

  }


  verif(){

  if(verifName&&verifPhone&&verifEmail)
    client.verif=true;
  else{
    client.verif=false;
  }
  }


  List<dynamic> specialityList=[];

  void fetchSpeciality() async {

    var result = await http.get(Uri.parse('http://192.168.1.102:9089/user-service/speciality/all'),headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});
    print('dddd');
    if(result.statusCode==200){
      setState(() {
        specialityList= json.decode(result.body);
      });
      specialityList.forEach((element) {
        print(element);
        _dropdownMenuItems.add(
          DropdownMenuItem(child: Text(element['name']),value: element,),
        );
      });

    }

    print(result.body);
  }
  dynamic  selectedSpeciality ;
  List<DropdownMenuItem> _dropdownMenuItems=[];
}

