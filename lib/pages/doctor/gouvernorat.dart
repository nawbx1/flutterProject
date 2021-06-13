// import 'dart:convert';
//
// import 'package:doctor_pro/constant/constant.dart';
// import 'package:doctor_pro/pages/doctor/TypeDintervention.dart';
// import 'package:doctor_pro/pages/screens.dart';
// import 'package:flutter/material.dart';
// import 'package:group_list_view/group_list_view.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:http/http.dart' as http;
//
//
// class gouvernorat extends StatefulWidget {
//   final String  intervention;
//   final String speciality  ;
//   const gouvernorat({Key key, @required this.intervention,@required this.speciality }) : super(key: key);
//   @override
//   _gouvernoratState createState() => _gouvernoratState();
// }
// Map<String, List> _elements = {
//   'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
//   'Team B': ['Toyah Downs', 'Tyla Kane'],
//   'Team C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
//   'Team D': [
//     'Casey Zuniga',
//     'Ayisha Burn',
//     'Josie Hayden',
//     'Kenan Walls',
//     'Mario Powers'
//   ],
//   'Team Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
// };
// class _gouvernoratState extends State<gouvernorat> {
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBgColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         titleSpacing: 0.0,
//         elevation: 0.0,
//         title: Text(
//           widget.speciality ,
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
//       ),
//
//             body: ListView.builder(
//                 sectionsCount: _elements.keys.toList().length,
//       countOfItemInSection: (int section) {
//         return _elements.values.toList()[section].length;
//       },
//       itemBuilder: (BuildContext context, IndexPath index) {
//         return Text(
//           _elements.values.toList()[index.section][index.index],
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         );
//       },
//       groupHeaderBuilder: (BuildContext context, int section) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//           child: Text(
//             _elements.keys.toList()[section],
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//         );
//       },
//       separatorBuilder: (context, index) => SizedBox(height: 10),
//       sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
//     );
//
//     ),
//
//           );
//
//   }
//
//
//
