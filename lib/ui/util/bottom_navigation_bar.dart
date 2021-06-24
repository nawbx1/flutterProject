import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:doctor_pro/ui/auth/login_page.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentList.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:doctor_pro/ui/util/Home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigation> {
  int currentIndex=0;

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
      bottomNavigationBar: StyleProvider(
        style: Style(),
        child: ConvexAppBar(
          items: [
            TabItem(icon: Icons.chat_bubble_outline, title: 'Acceuil'),
            TabItem(icon: Icons.call, title: 'RDV'),
            TabItem(icon: Icons.group, title: 'Specialité'),
            TabItem(icon: Icons.more_horiz, title: 'Profil'),
          ],
          initialActiveIndex: currentIndex,
          height: 50,
          top: -30,
          curveSize: 100,
          curve: Curves.easeInCirc,
          onTap: (int i) => changePage(i),
          backgroundColor: redColor,
          elevation: 0.0,
        ),
      ),
      body: (currentIndex == 0)
          ? Center(
              child: Home(),
            )
          : (currentIndex == 1)
              ? Center(
                  child: AppointmentPage(),
                )
              : (currentIndex == 2)
                  ? Center(
                       child: SpecialityPage(),
                    )
                  : (currentIndex == 3)
                      ? Center(
                          child: ProfileSetting(),
                        )
                      : Center(
                          child: Text('Tab 5'),
                        ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 15;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10.0, color: Colors.white);
  }
}
