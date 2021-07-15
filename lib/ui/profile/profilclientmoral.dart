import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/bloc/RegionBloc.dart';
import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/model/Gouvernorat.dart';
import 'package:doctor_pro/model/Region.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';

class Profileclientmorale extends StatefulWidget {
  Profileclientmorale({Key key , @required this.user }) : super(key: key);
  User user;
  @override
  ProfileclientmoraleState createState() => ProfileclientmoraleState();
}

class ProfileclientmoraleState extends State<Profileclientmorale>
    with SingleTickerProviderStateMixin {
  static TextEditingController emailController = new  TextEditingController();
  static TextEditingController fullnameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController cinController = TextEditingController();

  static TextEditingController matriculeController = TextEditingController();
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  UserBloc userBloc=new UserBloc();
  String userRole;
  @override
  void initState() {
    initProfile();
    fetchGouvernorat();
    super.initState();
  }


  RegionBloc regionBloc =new RegionBloc();

  List<Gouvernorat>GouvList = [];

  String selectedGouv="Ariana" ;
  String selectedRegion="Ariana Ville" ;

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

  initProfile() async{
    print("initProfile");
    print(widget.user);

    if(widget.user==null)
    {
      userRole= await TokenStorageBloc.getStoredUserRole();
      print('userRole');
      print(userRole);
      widget.user = await userBloc.getUserByKeycloak();

    }

      fullnameController.text=widget.user.name;
      emailController.text=widget.user.email;
      phoneController.text=widget.user.phone.toString();
      cinController.text=widget.user.cin.toString();
      matriculeController.text=widget.user.matriculeFiscale;
    if(widget.user.address!=null && widget.user.address.region!=null && widget.user.address.region.gouvernorat!=null )
    {
      selectedGouv = widget.user.address.region.gouvernorat.name ;
      selectedRegion = widget.user.address.region.region ;
    }



  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[


                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Tél',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: phoneController,
                                      onChanged: ((v) =>{
                                        widget.user.phone= int.parse(phoneController.text)
                                      } ),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Matricule fiscale',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(

                                      decoration: const InputDecoration(

                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: matriculeController,

                                      onChanged: ((v) =>{
                                        widget.user.matriculeFiscale= matriculeController.text
                                      } ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Raison Sociale',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(

                                      decoration: const InputDecoration(

                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,
                                      controller: fullnameController,
                                      onChanged: ((v) =>{
                                        widget.user.username=fullnameController.text
                                      } ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: emailController,
                                      enabled: !_status,
                                      onChanged: ((v) =>{
                                        widget.user.email=emailController.text
                                      } ),
                                    ),
                                  ),
                                ],
                              )),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child:   SearchableDropdown.single(
                                      readOnly:_status,
                                      items:_dropdownMenuItems ,
                                      label: Padding(
                                        padding: EdgeInsets.only(left: 15, top: 5),
                                        child: Text(
                                          "Gouvernorat",
                                          // style: AppTheme.dropdownTitleStyle,
                                        ),
                                      ),
                                      hint: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(selectedGouv),
                                      ),

                                      searchHint: "Gouvernorat",
                                      onChanged: (value) {
                                        setState(() {

                                          /*selectedSpeciality=value;
                                          Speciality s = value ;

                                          FlutterStepperPage.user.speciality = [new Speciality.name(s.id,s.name)];

                                          */

                                          getRegions(value.id);
                                          selectedGouv = value.name ;

                                        });

                                      },
                                      onClear: (){
                                        setState(() {
                                          // selectedGouv = null;
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(

                                    child:   SearchableDropdown.single(
                                      readOnly:_status,
                                      items:_dropdownMenuRegionItems ,

                                      label: Padding(
                                        padding: EdgeInsets.only(left: 15, top: 5),
                                        child: Text(
                                          "Région",
                                          // style: AppTheme.dropdownTitleStyle,
                                        ),
                                      ),
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
                                          widget.user.address.region = value ;


                                        });

                                      },
                                      onClear: (){
                                        setState(() {
                                          // selectedGouv = null;
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),

                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      userBloc.updateuser(widget.user);
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }


}