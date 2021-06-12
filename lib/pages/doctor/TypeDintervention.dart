// import 'package:doctor_pro/constant/constant.dart';
// import 'package:doctor_pro/pages/screens.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
//
// class TypeDintervention extends StatelessWidget {
//   final artisanTypeList = [
//     {'type': 'Cough & Fever', 'image': 'assets/icons/patient.png'},
//     {'type': 'Homoeopath', 'image': 'assets/icons/stethoscope.png'},
//     {'type': 'Gynecologist', 'image': 'assets/icons/woman.png'},
//     {'type': 'Pediatrician', 'image': 'assets/icons/pediatrician.png'},
//     {'type': 'Physiotherapist', 'image': 'assets/icons/physiotherapist.png'},
//     {'type': 'Nutritionist', 'image': 'assets/icons/nutritionist.png'},
//     {'type': 'Spine and Pain Specialist', 'image': 'assets/icons/pain.png'},
//     {'type': 'Dentist', 'image': 'assets/icons/dentist.png'}
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBgColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         titleSpacing: 0.0,
//         elevation: 0.0,
//         title: Text(
//           'Speciality',
//           style: appBarTitleTextStyle,
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: blackColor,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(65.0),
//           child: Container(
//             color: whiteColor,
//             height: 65.0,
//             padding: EdgeInsets.only(
//               left: fixPadding * 2.0,
//               right: fixPadding * 2.0,
//               top: fixPadding,
//               bottom: fixPadding,
//             ),
//             alignment: Alignment.center,
//             child: Container(
//               height: 55.0,
//               padding: EdgeInsets.all(fixPadding),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: whiteColor,
//                 borderRadius: BorderRadius.circular(8.0),
//                 border:
//                 Border.all(width: 1.0, color: greyColor.withOpacity(0.6)),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search specialities',
//                   hintStyle: greyNormalTextStyle,
//                   prefixIcon: Icon(Icons.search),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.only(
//                       top: fixPadding * 0.78, bottom: fixPadding * 0.78),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(fixPadding),
//         child: GridView.builder(
//           itemCount: artisanTypeList.length,
//           gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           itemBuilder: (BuildContext context, int index) {
//             final item = artisanTypeList[index];
//             return Padding(
//               padding: EdgeInsets.all(fixPadding),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                       duration: Duration(milliseconds: 800),
//                       type: PageTransitionType.fade,
//                       child: ArtisanList(
//                        atisanType: item['type'],
//                       ),
//                     ),
//                   );
//                 },
//                 child: Hero(
//                   tag: item['type'],
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5.0),
//                       boxShadow: <BoxShadow>[
//                         BoxShadow(
//                             blurRadius: 1.0,
//                             spreadRadius: 1.5,
//                             color: Colors.grey[300]),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Image.asset(
//                           item['image'],
//                           width: 75.0,
//                           height: 75.0,
//                           fit: BoxFit.cover,
//                         ),
//                         SizedBox(height: 10.0),
//                         Text(
//                           item['type'],
//                           style: blackNormalBoldTextStyle,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
