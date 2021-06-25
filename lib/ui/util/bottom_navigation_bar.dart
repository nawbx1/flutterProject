import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:doctor_pro/pages/home/home.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:doctor_pro/ui/rendez_vous/CalendarPage.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigation> {
  int currentIndex;
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 800),
              type: PageTransitionType.fade,
              child: SpecialityPage()
            ),
          );

          /*Fluttertoast.showToast(
              msg: "Floating Action Button Tapped",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);*/
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.white,
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: 0.2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text(
              'Acceuil',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.calendar_today,
              color: Colors.red,
            ),
            title: Text(
              'calendrier',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            title: Text(
              'Profil',
              style: TextStyle(fontSize: 12.0),
            ),
          )
        ],
      ),
      body:(currentIndex == 0)
                  ? Center(
                        child: Home(),
                      )
                  : (currentIndex == 1)
                          ? Center(
                        child: CalendarPage(),
                      )
                  : (currentIndex == 2)
                          ? Center(
                        child: ProfileSetting(),
                       )
                  : (currentIndex == 3)
                        ? Center(
                       child: SpecialityPage(),
                     ): Center(
                        child: Text(''),
                    ),
    );
  }
}
