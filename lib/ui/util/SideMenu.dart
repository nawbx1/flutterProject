import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/pages/chat/chat_list.dart';
import 'package:doctor_pro/pages/home/home.dart';
import 'package:doctor_pro/pages/profile/Setting1.dart';
import 'package:doctor_pro/ui/auth/login_page.dart';
import 'package:doctor_pro/ui/auth/sign_up_page.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentList.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/appointmentScreen.dart';
import 'package:doctor_pro/ui/rendez_vous/CalendarPage.dart';
import 'package:doctor_pro/ui/rendez_vous/Speciality_Page.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  User user ;
  initUser() async{
    user = await userBloc.getUserByKeycloak();
    print("user _SideMenuState ");
    print(user);
    setState(() {
      user ;
    });

  }
@override
  void initState() {
    initUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              /*image: DecorationImage(
                image: AssetImage('assets/bg_home.jpg'),
                fit: BoxFit.cover,
              ),*/
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      /*image: DecorationImage(
                        image: AssetImage('assets/user.jpg'),
                        fit: BoxFit.cover,
                      ),*/
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!=null &&   user.email!=null ?  user.email : "",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        user!=null &&   user.email!=null ?  user.email : "",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: Home(),
                ),
              );
            },
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              'Acceuil ',
              style: TextStyle(color: Colors.black),
            ),

            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,

            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: AppointmentPage(isProfessionnel:true),
                ),
              );
            },
            leading: Icon(
              Icons.photo_album,
              color: Colors.black,
            ),
            title: Text(
              'Liste RDVs',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: AppointmentPage(isProfessionnel:false),
                ),
              );
            },
            leading: Icon(
              Icons.photo_album,
              color: Colors.black,
            ),
            title: Text(
              'Mes Demandes RDVs',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: CalendarPage(),
                ),
              );
            },
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              'Mon Calendrier',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: SpecialityPage(),
                ),
              );
            },
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              'Prendre RDV',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: ChatList(),
                ),
              );
            },

            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text(
              'Messagerie',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: (
                ) {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 800),
                  type: PageTransitionType.fade,
                  child: ProfileSetting(),
                ),
              );
            },
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              PageTransition(
                duration: Duration(milliseconds: 800),
                type: PageTransitionType.fade,
                child: LoginPage(),
              );
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}



