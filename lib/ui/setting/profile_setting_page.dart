import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/ui/auth/login_page.dart';
import 'package:doctor_pro/ui/setting/ExperiencePage.dart';
import 'package:doctor_pro/ui/setting/changepassword.dart';
import 'package:doctor_pro/ui/setting/edit_profile.dart';
import 'package:doctor_pro/ui/util/Competence_DraggableList.dart';
import 'package:doctor_pro/ui/util/SideMenu.dart';
import 'package:doctor_pro/ui/util/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _profileSetting createState() => _profileSetting();
}

class _profileSetting extends State<ProfileSetting> {

  UserBloc userBloc=new UserBloc();
  String userRole;
  User user ;
  bool loading=true ;


  void initState()  {
    initProfile();
    super.initState();
  }

  initProfile() async{
    print("initProfile");
    userRole= await TokenStorageBloc.getStoredUserRole();
    print('userRole');
    print(userRole);
    user = await userBloc.getUserByKeycloak();
    print(user);
    if(user!=null) {
      setState(() {
        loading=false ;
      });
    }

  }

  logoutDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Voulez-vous vraiment se déconnecter ?",
                      style: blackHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Annuler',
                              style: blackColorButtonTextStyle,
                            ),
                          ),
                        ),
                         InkWell(
                           onTap: () {
                                signout();
                           },
                           child: Container(
                             width: (width / 3.5),
                             alignment: Alignment.center,
                             padding: EdgeInsets.all(10.0),
                             decoration: BoxDecoration(
                               color: primaryColor,
                               borderRadius: BorderRadius.circular(5.0),
                             ),
                             child: Text(
                               'Sign Out',
                               style: whiteColorButtonTextStyle,
                             ),
                           ),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu().build(context),
      backgroundColor: whiteColor,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(80.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                iconTheme: IconThemeData(color: blackColor),

                backgroundColor: whiteColor,
                elevation: 1.0,
               // automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46.0,
                      height: 46.0,
                      /*decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.0),
                        border: Border.all(width: 0.2, color: greyColor),
                        image: DecorationImage(
                          image: AssetImage('assets/user/user_3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),*/
                     child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30.0)),
                        child: Image.network(
                            (user.profile.profileImage!=null )?
                            apiUrl+'user-service/uploads/'+user.profile.profileImage.mediaURL
                                :"",
                            height: 100,
                            width: 100,
                            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              return Image(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/user.png"),
                              );
                            }
                        ),
                      ),

                    ),
                    widthSpace,
                    Text(
                      (loading==false)?user.username.toString():"",
                      style: appBarTitleTextStyle,
                    ),
                  ],
                ),
                // actions: [
                //   // Column(
                //   //   mainAxisAlignment: MainAxisAlignment.center,
                //   //   crossAxisAlignment: CrossAxisAlignment.end,
                //   //   children: [
                //   //     InkWell(
                //   //       onTap: () {
                //   //         Navigator.push(
                //   //             context,
                //   //             PageTransition(
                //   //                 duration: Duration(milliseconds: 500),
                //   //                 type: PageTransitionType.rightToLeft,
                //   //                 child: EditProfile()));
                //   //       },
                //   //       child: Container(
                //   //         padding: EdgeInsets.only(right: 15.0),
                //   //         child: Text(
                //   //           'Edit Profile',
                //   //           style: primaryColorsmallBoldTextStyle,
                //   //         ),
                //   //       ),
                //   //     ),
                //   //   ],
                //   // )
                // ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informations générale ',
                  style: blackHeadingTextStyle,
                ),
                heightSpace,
                heightSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: EditProfile()));
                  },
                  child:
                  listItem(primaryColor, Icons.person, 'Modifier le profil'),
                ),
              ],
            ),
          ),
          divider(),
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sécurité',
                  style: blackHeadingTextStyle,
                ),
                heightSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: changepassword(user:user)));
                  },
                  child: listItem(primaryColor, Icons.touch_app, 'Mot de passe'),
                ),
              ],
            ),
          ),
          divider(),
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: CompetanceList(user:user)));
                  },
                  child:  (userRole=="PROFESSIONNEL" || userRole=="GESTIONNAIRE")?
                  listItem(Colors.green, Icons.star_border, 'Competences'):Container(),
                ),


                heightSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: ExperiencePage(user:user)));
                  },
                  child:   (userRole=="PROFESSIONNEL" || userRole=="GESTIONNAIRE")?
                  listItem(Colors.green, Icons.star_border, 'Experience'):Container(),
                ),


              ],
            ),
          ),
          divider(),
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => logoutDialogue(),
                  child: listItem(Colors.teal, Icons.exit_to_app, 'Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }

  listItem(color, icon, title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 0.3, color: color),
                  color: color.withOpacity(0.15),
                ),
                child: Icon(
                  icon,
                  size: 22.0,
                  color: color,
                ),
              ),
              widthSpace,
              Expanded(
                child: Text(
                  title,
                  style: blackNormalBoldTextStyle,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: blackColor,
          size: 14.0,
        ),
      ],
    );
  }

  void signout() async{
    String res = await TokenStorageBloc.removeAccessToken();
    print(res);
     (res=="ok")?
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage())):print("not ok");

  }
}
