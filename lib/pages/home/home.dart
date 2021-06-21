
import 'dart:io';
import 'dart:ui';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/ui/rendez_vous/ArtisanList_Page.dart';
import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: (currentIndex == 0)
            ? ArtisanList()
            : (currentIndex == 1)
            ? ArtisanList()
            : (currentIndex == 2)
            ? ArtisanList()
            : (currentIndex == 3)
            ? ArtisanList()
            : ArtisanList(),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
      );
      return Future.value(false);
    } else {
      return true;
    }
  }
}
