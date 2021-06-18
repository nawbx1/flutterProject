import 'package:doctor_pro/appBehaviour/my_behaviour.dart';
import 'package:doctor_pro/pages/login_signup/log.dart';
import 'package:doctor_pro/pages/login_signup/myapp.dart';
import 'package:doctor_pro/pages/login_signup/profil/profilpage.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant/constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'artisan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Noto Sans',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },


      home: signup12 (),

    );
  }
}
