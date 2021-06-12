// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImagePickerIntegration extends StatefulWidget {
//   @override
//   _ImagePickerIntegrationState createState() => _ImagePickerIntegrationState();
// }
//
// class _ImagePickerIntegrationState extends State<ImagePickerIntegration> {
//   File _image;
//   final _picker = ImagePicker();
//
//   Future getImageFromCamera() async {
//     final pickedFile = await _picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('Aucune image sélectionnée .');
//       }
//     });
//   }
//
//   Future getImageFromGallery() async {
//     final pickedFile = await _picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('Aucune image sélectionnée ');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         titleSpacing: 0.0,
//         centerTitle: true,
//         title: Text(
//           'Ajouter image ',
//           style: TextStyle(
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Center(
//         child: _image == null ? Text('Aucune image sélectionnée.') : Image.file(_image),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.teal,
//         onPressed: () =>
//             _bottomSheet(context, MediaQuery.of(context).size.width),
//         tooltip: 'Choisir une image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
//
//   void _bottomSheet(context, width) {
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.white,
//         builder: (BuildContext bc) {
//           return Container(
//             width: width,
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//             ),
//             child: Wrap(
//               children: <Widget>[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10.0),
//                       alignment: Alignment.center,
//                       child: Text(
//                         'Choisissez l\'option',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Divider(),
//                     SizedBox(height: 15.0),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                         getImageFromCamera();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.camera_alt,
//                               size: 22.0,
//                               color: Colors.black,
//                             ),
//                             SizedBox(width: 10.0),
//                             Text(
//                               'Caméra',
//                               style: TextStyle(
//                                   color: Colors.black, fontSize: 16.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15.0),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                         getImageFromGallery();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.photo_album,
//                               size: 22.0,
//                               color: Colors.black,
//                             ),
//                             SizedBox(width: 10.0),
//                             Text(
//                               'Choisir depuis la galerie',
//                               style: TextStyle(
//                                   color: Colors.black, fontSize: 16.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15.0),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
