// import 'package:doctor_pro/constant/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:doctor_pro/pages/screens.dart';
//
// class Register extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/doctor_bg.jpg'), fit: BoxFit.cover),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 0.0,
//             left: 0.0,
//             child: Container(
//               width: width,
//               height: height,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   stops: [0.1, 0.3, 0.5, 0.7, 0.9],
//                   colors: [
//                     Colors.black.withOpacity(0.4),
//                     Colors.black.withOpacity(0.55),
//                     Colors.black.withOpacity(0.7),
//                     Colors.black.withOpacity(0.8),
//                     Colors.black.withOpacity(1.0),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             child: WillPopScope(
//               child: Scaffold(
//                 backgroundColor: Colors.transparent,
//                 appBar: AppBar(
//                   backgroundColor: Colors.transparent,
//                   elevation: 0.0,
//                   leading: IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Login()));
//                     },
//                   ),
//                 ),
//                 body: ListView(
//                   physics: BouncingScrollPhysics(),
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(top: 20.0, left: 20.0),
//                       child: Text(
//                         'Register',
//                         style: loginBigTextStyle,
//                       ),
//                     ),
//                     SizedBox(height: 10.0),
//                     Padding(
//                       padding: EdgeInsets.only(left: 20.0),
//                       child: Text(
//                         'Create account',
//                         style: whiteSmallLoginTextStyle,
//                       ),
//                     ),
//                     SizedBox(height: 50.0),
//                     Padding(
//                       padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200].withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         ),
//                         child: TextField(
//                           style: inputLoginTextStyle,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 20.0),
//                             hintText: 'Username',
//                             hintStyle: inputLoginTextStyle,
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Padding(
//                       padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200].withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         ),
//                         child: TextField(
//                           style: inputLoginTextStyle,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 20.0),
//                             hintText: 'Email',
//                             hintStyle: inputLoginTextStyle,
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Padding(
//                       padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200].withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         ),
//                         child: TextField(
//                           style: inputLoginTextStyle,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 20.0),
//                             hintText: 'Password',
//                             hintStyle: inputLoginTextStyle,
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Padding(
//                       padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200].withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         ),
//                         child: TextField(
//                           style: inputLoginTextStyle,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.only(left: 20.0),
//                             hintText: 'Confirm Password',
//                             hintStyle: inputLoginTextStyle,
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 40.0),
//                     Padding(
//                       padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(30.0),
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               PageTransition(
//                                   duration: Duration(milliseconds: 600),
//                                   type: PageTransitionType.fade,
//                                   child: BottomBar()));
//                         },
//                         child: Container(
//                           height: 50.0,
//                           width: double.infinity,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30.0),
//                             gradient: LinearGradient(
//                               begin: Alignment.centerLeft,
//                               end: Alignment.bottomRight,
//                               stops: [0.1, 0.5, 0.9],
//                               colors: [
//                                 Colors.blue[300].withOpacity(0.8),
//                                 Colors.blue[500].withOpacity(0.8),
//                                 Colors.blue[800].withOpacity(0.8),
//                               ],
//                             ),
//                           ),
//                           child: Text(
//                             'Continue',
//                             style: inputLoginTextStyle,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                   ],
//                 ),
//               ),
//               onWillPop: () async {
//                 bool backStatus = onWillPop();
//                 if (backStatus) {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Login()));
//                 }
//                 return false;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   onWillPop() {
//     return true;
//   }
// }
