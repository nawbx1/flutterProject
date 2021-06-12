// import 'dart:async';
//
// import 'package:doctor_pro/constant/constant.dart';
// import 'package:doctor_pro/pages/screens.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:page_transition/page_transition.dart';
//
// class OTPScreen extends StatefulWidget {
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   var firstController = TextEditingController();
//   var secondController = TextEditingController();
//   var thirdController = TextEditingController();
//   var fourthController = TextEditingController();
//   FocusNode secondFocusNode = FocusNode();
//   FocusNode thirdFocusNode = FocusNode();
//   FocusNode fourthFocusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//
//     loadingDialog() {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           // return object of type Dialog
//           return Dialog(
//             elevation: 0.0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0)),
//             child: Wrap(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       SpinKitRing(
//                         color: primaryColor,
//                         size: 40.0,
//                         lineWidth: 1.0,
//                       ),
//                       SizedBox(height: 25.0),
//                       Text(
//                         'Please Wait..',
//                         style: greySmallTextStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//       Timer(
//           Duration(seconds: 3),
//           () => Navigator.push(
//               context,
//               PageTransition(
//                   duration: Duration(milliseconds: 600),
//                   type: PageTransitionType.fade,
//                   child: Register())));
//     }
//
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
//             child: Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.0,
//               ),
//               body: ListView(
//                 physics: BouncingScrollPhysics(),
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(top: 20.0, left: 20.0),
//                     child: Text(
//                       'Verification',
//                       style: loginBigTextStyle,
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: EdgeInsets.only(left: 20.0),
//                     child: Text(
//                       'Enter the OTP code from the phone we just sent you.',
//                       style: whiteSmallLoginTextStyle,
//                     ),
//                   ),
//                   SizedBox(height: 50.0),
//                   // OTP Box Start
//                   Padding(
//                     padding: EdgeInsets.all(20.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         // 1 Start
//                         Container(
//                           width: 50.0,
//                           height: 50.0,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200].withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           child: TextField(
//                             controller: firstController,
//                             style: inputOtpTextStyle,
//                             keyboardType: TextInputType.number,
//                             cursorColor: whiteColor,
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(18.0),
//                               border: InputBorder.none,
//                             ),
//                             onChanged: (v) {
//                               FocusScope.of(context)
//                                   .requestFocus(secondFocusNode);
//                             },
//                           ),
//                         ),
//                         // 1 End
//                         // 2 Start
//                         Container(
//                           width: 50.0,
//                           height: 50.0,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200].withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           child: TextField(
//                             focusNode: secondFocusNode,
//                             controller: secondController,
//                             style: inputOtpTextStyle,
//                             keyboardType: TextInputType.number,
//                             cursorColor: whiteColor,
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(18.0),
//                               border: InputBorder.none,
//                             ),
//                             onChanged: (v) {
//                               FocusScope.of(context)
//                                   .requestFocus(thirdFocusNode);
//                             },
//                           ),
//                         ),
//                         // 2 End
//                         // 3 Start
//                         Container(
//                           width: 50.0,
//                           height: 50.0,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200].withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           child: TextField(
//                             focusNode: thirdFocusNode,
//                             controller: thirdController,
//                             style: inputOtpTextStyle,
//                             keyboardType: TextInputType.number,
//                             cursorColor: whiteColor,
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(18.0),
//                               border: InputBorder.none,
//                             ),
//                             onChanged: (v) {
//                               FocusScope.of(context)
//                                   .requestFocus(fourthFocusNode);
//                             },
//                           ),
//                         ),
//                         // 3 End
//                         // 4 Start
//                         Container(
//                           width: 50.0,
//                           height: 50.0,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200].withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           child: TextField(
//                             focusNode: fourthFocusNode,
//                             controller: fourthController,
//                             style: inputOtpTextStyle,
//                             keyboardType: TextInputType.number,
//                             cursorColor: whiteColor,
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(18.0),
//                               border: InputBorder.none,
//                             ),
//                             onChanged: (v) {
//                               loadingDialog();
//                             },
//                           ),
//                         ),
//                         // 4 End
//                       ],
//                     ),
//                   ),
//                   // OTP Box End
//                   SizedBox(height: 20.0),
//                   Padding(
//                     padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           'Didn\'t receive OTP Code!',
//                           style: greySmallTextStyle,
//                         ),
//                         SizedBox(width: 10.0),
//                         InkWell(
//                           onTap: () {},
//                           child: Text(
//                             'Resend',
//                             style: inputLoginTextStyle,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 30.0),
//                   Padding(
//                     padding: EdgeInsets.only(right: 20.0, left: 20.0),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(30.0),
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             PageTransition(
//                                 duration: Duration(milliseconds: 600),
//                                 type: PageTransitionType.fade,
//                                 child: Register()));
//                       },
//                       child: Container(
//                         height: 50.0,
//                         width: double.infinity,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30.0),
//                           gradient: LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.bottomRight,
//                             stops: [0.1, 0.5, 0.9],
//                             colors: [
//                               Colors.blue[300].withOpacity(0.8),
//                               Colors.blue[500].withOpacity(0.8),
//                               Colors.blue[800].withOpacity(0.8),
//                             ],
//                           ),
//                         ),
//                         child: Text(
//                           'Submit',
//                           style: inputLoginTextStyle,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
