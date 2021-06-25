import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/ui/util/SideMenu.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        backgroundColor: scaffoldBgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: blackColor),
          titleSpacing: 0.0,
          elevation: 0.0,
          title: Text(
            'Acceuil',
            style: appBarTitleTextStyle,
          ),


        ),


        body: Center(
          child: Text('Home Works'),
        ),
    );
  }
}
