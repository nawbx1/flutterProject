// import 'dart:ui';
//
// import 'package:doctor_pro/constant/constant.dart';
//
// import 'package:doctor_pro/pages/doctor/consultation_detail.dart';
// import 'package:doctor_pro/pages/home/home.dart';
// import 'package:doctor_pro/pages/key/key.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// import 'package:page_transition/page_transition.dart';
//
// class GoogleMapPlacePicker extends StatefulWidget {
//   @override
//   _GoogleMapPlacePickerState createState() => _GoogleMapPlacePickerState();
// }
//
// class _GoogleMapPlacePickerState extends State<GoogleMapPlacePicker> {
//   PickResult selectedPickupPlace;
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//
//     return   PlacePicker(
//
//       apiKey: googleMapApiKey,
//       initialPosition: LatLng(-33.8567844, 151.213108),
//       useCurrentLocation: true,
//       selectInitialPosition: true,
//       //usePlaceDetailSearch: true,
//       onPlacePicked: (result) {
//         selectedPickupPlace = result;
//         Navigator.of(context).pop();
//         setState(() {});
//       },
//       selectedPlaceWidgetBuilder: (_, selectedPlace,
//           state, isSearchBarFocused) {
//         return isSearchBarFocused
//             ? Container()
//             : FloatingCard(
//           bottomPosition: 0.0,
//           leftPosition: 0.0,
//           rightPosition: 0.0,
//           width: 500,
//           borderRadius:
//           BorderRadius.circular(12.0),
//
//           child: state == SearchingState.Searching
//
//               ? Center(
//               child:
//               CircularProgressIndicator())
//               : ElevatedButton(
//             child: Text("choisissez cet endroit"),
//             onPressed: () {
//               print(selectedPlace
//                   .geometry.location);
//               Navigator.pop(
//                   context, selectedPlace);
//               setState(() {});
//             },
//
//           ),
//
//         );
//       },
//
//     );
//
//     // return Scaffold(
//     //
//     //   appBar: AppBar(
//     //       backgroundColor: Colors.indigo,
//     //       titleSpacing: 0.0,
//     //       centerTitle: true,
//     //       title: Text(
//     //         'Localisation',
//     //         style: TextStyle(
//     //           fontSize: 18.0,
//     //           fontWeight: FontWeight.bold,
//     //           color: Colors.white,
//     //         ),
//     //       ),
//     //       leading: IconButton(
//     //         icon: Icon(
//     //           Icons.arrow_back,
//     //           color: Colors.white,
//     //         ),
//     //         onPressed: () => Navigator.pop(context),
//     //       ),
//     //       actions: <Widget>[
//     //         IconButton(
//     //           icon: Icon(Icons.arrow_forward_outlined),
//     //           onPressed: () {
//     //             Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
//     //           },
//     //         ),
//     //       ]
//     //   ),body: ListView(
//     //   children: [
//     //     Container(
//     //       width: width,
//     //       height: height - 85.0,
//     //       child: Center(
//     //         child: Column(
//     //           mainAxisAlignment: MainAxisAlignment.center,
//     //           crossAxisAlignment: CrossAxisAlignment.center,
//     //           children: <Widget>[
//     //             ElevatedButton(
//     //
//     //                 child:
//     //                 PlacePicker(
//     //
//     //                   apiKey: googleMapApiKey,
//     //                   initialPosition: LatLng(-33.8567844, 151.213108),
//     //                   useCurrentLocation: true,
//     //                   selectInitialPosition: true,
//     //                   //usePlaceDetailSearch: true,
//     //                   onPlacePicked: (result) {
//     //                     selectedPickupPlace = result;
//     //                     Navigator.of(context).pop();
//     //                     setState(() {});
//     //                   },
//     //                   selectedPlaceWidgetBuilder: (_, selectedPlace,
//     //                       state, isSearchBarFocused) {
//     //                     return isSearchBarFocused
//     //                         ? Container()
//     //                         : FloatingCard(
//     //                       bottomPosition: 0.0,
//     //                       leftPosition: 0.0,
//     //                       rightPosition: 0.0,
//     //                       width: 500,
//     //                       borderRadius:
//     //                       BorderRadius.circular(12.0),
//     //
//     //                       child: state == SearchingState.Searching
//     //
//     //                           ? Center(
//     //                           child:
//     //                           CircularProgressIndicator())
//     //                           : ElevatedButton(
//     //                         child: Text("choisissez cet endroit"),
//     //                         onPressed: () {
//     //                           print(selectedPlace
//     //                               .geometry.location);
//     //                           Navigator.pop(
//     //                               context, selectedPlace);
//     //                           setState(() {});
//     //                         },
//     //
//     //                       ),
//     //
//     //                     );
//     //                   },
//     //
//     //                 )
//     //
//     //             ),
//     //             Container(
//     //               padding: EdgeInsets.all(40.0),
//     //               child: Column(
//     //                 mainAxisAlignment: MainAxisAlignment.start,
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 children: [
//     //                   Text(
//     //                     'placer le marqueur sur la carte Google au lieu de prise en charge',
//     //                     style: TextStyle(
//     //                       fontSize: 15.0,
//     //                       color: Colors.grey,
//     //                       fontWeight: FontWeight.w500,
//     //                     ),
//     //                   ),
//     //                   SizedBox(height: 10.0),
//     //                   (selectedPickupPlace == null)
//     //                       ? Container()
//     //                       : Text(
//     //                     selectedPickupPlace.formattedAddress ?? "",
//     //                     textAlign: TextAlign.center,
//     //                     style: TextStyle(fontSize: 18.0),
//     //                   ),
//     //                   (selectedPickupPlace == null)
//     //                       ? Container()
//     //                       : SizedBox(height: 10.0),
//     //                 ],
//     //               ),
//     //
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ],
//     // ),
//     // );
//   }
// }
