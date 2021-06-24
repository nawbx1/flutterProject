import 'package:doctor_pro/pages/profile/Setting1.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SideMenu extends StatefulWidget {
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_home.jpg'),
                fit: BoxFit.cover,
              ),
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
                      image: DecorationImage(
                        image: AssetImage('assets/user.jpg'),
                        fit: BoxFit.cover,
                      ),
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
                        'Ellison Perry',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'test@abc.com',
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
            onTap: ( ) {},
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              'Home ',
              style: TextStyle(color: Colors.black),
            ),

            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,

            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.photo_album,
              color: Colors.black,
            ),
            title: Text(
              'Gallery',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              'Notifications',
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
                  child: ProfileSetting(),
                ),
              );
            },

            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text(
              'Profile',
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
            onTap: () {},
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
