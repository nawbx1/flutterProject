import 'package:doctor_pro/appBehaviour/my_behaviour.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:doctor_pro/ui/auth/login_page.dart';
import 'package:doctor_pro/ui/auth/otp.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/appointmentScreen.dart';
import 'package:doctor_pro/ui/rendez_vous/CalendarPage.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:doctor_pro/ui/util/Competence_DraggableList.dart';
import 'package:doctor_pro/ui/util/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentList.dart';
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
       // home: CalendarPage (),
       //home: LoginPage (),
       // home: SpecialityPage(),
      //home: AppointmentPage(isProfessionnel: false,),//for client (client or profesiionel)
      home: AppointmentPage(isProfessionnel:true),

    );
  }

}
