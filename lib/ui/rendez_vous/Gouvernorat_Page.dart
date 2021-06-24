

import 'package:doctor_pro/bloc/RegionBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Gouvernorat.dart';
import 'package:doctor_pro/model/InterventionType.dart';

import 'package:doctor_pro/ui/rendez_vous/ArtisanList_Page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../pages/artisan/drawer_1.dart';


class GouvernoratPage extends StatefulWidget {
  final InterventionType  interventionType;
  final String speciality  ;
  const GouvernoratPage({Key key, @required this.interventionType,@required this.speciality }) : super(key: key);
  @override
  _GouvernoratPageState createState() => _GouvernoratPageState();
}

class _GouvernoratPageState extends State<GouvernoratPage> {

  RegionBloc regionBloc =new RegionBloc();


  List<Gouvernorat>GouvList = [];


  void fetchGouvernorat() async {
    List<Gouvernorat> GouvList2 = await regionBloc.fetchGouvernorat();
      setState(() {
        GouvList= GouvList2;
      });

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
                          title: Text(GouvList[index].name),
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

                          interventionType: widget.interventionType,
                              gouvernoratId:GouvList[index].id
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