import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/constant/constant.dart';

import 'package:doctor_pro/ui/rendez_vous/ArtisanList_Page.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

import '../../pages/artisan/drawer_1.dart';


class Gouvernorat extends StatefulWidget {
  final String  intervention;
  final String speciality  ;
  const Gouvernorat({Key key, @required this.intervention,@required this.speciality }) : super(key: key);
  @override
  _GouvernoratState createState() => _GouvernoratState();
}

class _GouvernoratState extends State<Gouvernorat> {


  List<dynamic>GouvList = [];


  void fetchGouvernorat() async {

    var result = await http.get(Uri.parse(apiUrl+'user-service/region/gouvernorat/all'),headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});

    if(result.statusCode==200){
      setState(() {
        GouvList= json.decode(result.body);
      });
    }
  }
  @override
  void initState(){
    super.initState();
    fetchGouvernorat();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer1().build(context),
      backgroundColor: scaffoldBgColor,

      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'Choisir ville',
          style: appBarTitleTextStyle,
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: blackColor,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body:
      Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                alignment: FractionalOffset.center,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(widget.speciality, style: new TextStyle(color: Color(0xFF84A2AF),fontWeight: FontWeight.bold)),
                    ),
                    new FlatButton(
                      child: new Text('Tunisie', style: new TextStyle(color: Color(0xFF84A2AF), fontWeight: FontWeight.bold),),
                      //onPressed: ,
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: GouvList.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  InkWell(
                    child:  Card(
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                      child: Container(
                        child: ListTile(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
                          title: Text(GouvList[index]['name']),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(milliseconds: 800),
                          type: PageTransitionType.fade,
                          child: ArtisanList(
                              speciality: widget.speciality,
                              regions:GouvList[index]['regions']
                          ),
                        ),
                      );
                    },
                  );

              },
            ),
          ),
        ],

      ),
    );
  }
}
//
//
//