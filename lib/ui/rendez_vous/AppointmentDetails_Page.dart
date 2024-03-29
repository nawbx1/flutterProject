import 'dart:io';

import 'package:doctor_pro/bloc/AppointmentBloc.dart';
import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Address.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/model/AppointmentPK.dart';
import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/model/Media.dart';
import 'package:doctor_pro/model/Region.dart';
import 'package:doctor_pro/model/User.dart';

import 'package:doctor_pro/pages/key/key.dart';
import 'package:doctor_pro/ui/rendez_vous/ArtisanProfile_Page.dart';

import 'package:doctor_pro/ui/rendez_vous/Speciality_Page.dart';
import 'package:doctor_pro/ui/util/NotificationDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doctor_pro/ui/util/SideMenu.dart';
import 'package:intl/intl.dart';
class AppointmentDetails extends StatefulWidget {
  final String  heurDebut,heurFin;
  final User professionel;
  final InterventionType  interventionType;
  final Region region;
  final DateTime date;

  const AppointmentDetails(
      {Key key,
        @required this.professionel,
        @required this.interventionType,
        @required this.region,
        @required this.heurDebut,
        @required this.heurFin,
        @required this.date ,

      })
      : super(key: key);
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}
class _AppointmentDetailsState extends State<AppointmentDetails> {

  static TextEditingController descriptionController = TextEditingController();
  Appointment appointment =new Appointment();
  AppointmentBloc appointmentBloc= new AppointmentBloc();
  int currentUserId;

  getCurrentUserId()async{
    currentUserId= await TokenStorageBloc.getStoredUserId();
    setState(() {
      currentUserId ;
      print('currentUserId   ' + currentUserId.toString()) ;

    });
  }

  saveAppointment()async{
    appointment.appointmentPK.clientId=currentUserId ; //currentUserId;
    setState(() {
      appointment ;

    });
    Appointment savedAppointment= await appointmentBloc.save(appointment);
   /* if(savedAppointment!=null)
      successOrderDialog('félicitation! ','le rendez-vous a été enregistrer');
    else  successOrderDialog('Desole! ','rendez-vous a echoué');*/
  }
  final patientList = [
    {'name': 'Allison Perry', 'image': 'assets/user/user_3.jpg'},
    {'name': 'John Smith', 'image': ''}
  ];
  File _image;
  final _picker = ImagePicker();
  PickResult selectedPickupPlace;
  DateTime finalDateDebut;
  DateTime finalDateFin;
  Media media=new Media();
AppointmentPK appointmentPK=new AppointmentPK();
Address address=new Address();
  @override
  void initState() {
    getCurrentUserId();

    if(widget.date!=null){
    setState(() {
       finalDateDebut=widget.date;
       finalDateFin=widget.date;
    });
    setState(() {
      finalDateDebut= finalDateDebut.add(new Duration(days: 0,hours:int.parse(widget.heurDebut.split(':')[0]),minutes:int.parse(widget.heurDebut.split(':')[1])  )) ;//0,int.parse(widget.heurDebut.split(':')[0]),int.parse(widget.heurDebut.split(':')[1])
      finalDateFin =finalDateFin.add(new Duration(days: 0,hours:int.parse(widget.heurFin.split(':')[0]),minutes:int.parse(widget.heurFin.split(':')[1])  )) ;
    appointmentPK.startDate=finalDateDebut;
      appointmentPK.endDate=finalDateFin;
      appointmentPK.professionnelId=widget.professionel.id;
    appointment.title=widget.interventionType.name;
    address.region=widget.region;
    appointment.appointmentPK=appointmentPK;
    appointment.address=address;
    appointment.status="en_attente";
    print('appointmen iiiiiiiiis ');
    print(appointment);
    });
    }
print(widget.date);
    print('hours:int.parse(widget.heurDebut.split()[0]) === '+ widget.heurDebut.split(':')[0].toString());
    print("date debu is "+finalDateDebut.toString());
    print("date fin is "+finalDateFin.toString());
  }

  Future getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Aucune image sélectionnée ');
      }
    });
    media.file= await _image.readAsBytes();
    setState(() {
      print('hedhi limage ');
      print(_image.readAsBytes().toString());
      media;
      media.fileName=_image.path.substring(_image.path.lastIndexOf('.'),_image.path.length) ;
      print("hedhi media ");
      print(media);

      appointment.media=media;
    });
  }
  Future getImageFromGallery() async {
    File _image;
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Aucune image sélectionnée ');
      }
    });
    media.file= await _image.readAsBytes();
    setState(() {
      print('hedhi limage ');
      print(_image.readAsBytes().toString());
      media;
      media.fileName=_image.path.substring(_image.path.lastIndexOf('.'),_image.path.length) ;
      print("hedhi media ");
      print(media);

      appointment.media=media;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'Détails de rendez-vous ',
          style: appBarTitleTextStyle,
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: blackColor,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      floatingActionButton: Wrap( //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(

              margin:EdgeInsets.all(10),
              child: FloatingActionButton(
                backgroundColor: primaryColor ,
                onPressed: () =>
                    _bottomSheet(context, MediaQuery.of(context).size.width),
                tooltip: 'Choisir une image',
                child:

                Icon(Icons.add_a_photo),
              )

          ), //button first
          Container(

              margin:EdgeInsets.all(10),
              child: FloatingActionButton(
                backgroundColor: primaryColor ,
                onPressed: () =>
                    GoogleMapPlacePicker(context, MediaQuery.of(context).size.width),
                child:
                Icon(Icons.add_location_alt_rounded),
              )
          ), //button first// button second
        ],),

      bottomNavigationBar: Container(
        color: Colors.white,
        width: double.infinity,
        height: 70.0,
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        alignment: Alignment.center,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 600),
                    child: SpecialityPage()));
          },
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 70.0,
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            alignment: Alignment.center,
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: () {
                saveAppointment();

                //successOrderDialog();
              },
              child: Container(
                width: double.infinity,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: primaryColor,
                ),
                child: Text(
                  'Confirmer ',
                  style: whiteColorButtonTextStyle,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 1.0,
            child: Container(
              color: whiteColor,
              padding:
              EdgeInsets.only(top: fixPadding * 2.0, bottom: fixPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag:  widget.professionel!=null && widget.professionel.profile!=null&& widget.professionel.profile.profileImage!=null ?
                    apiUrl +
                    'user-service/'+  widget.professionel.profile.profileImage.mediaURL: apiUrl +
                    'user-service/uploads/avatar.jpg',
                          child: Container(
                            width: 76.0,
                            height: 76.0,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(38.0),
                              border:
                              Border.all(width: 0.3, color: primaryColor),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage( widget.professionel!=null && widget.professionel.profile!=null&& widget.professionel.profile.profileImage!=null ?
                                apiUrl +
                                    'user-service/'+  widget.professionel.profile.profileImage.mediaURL: apiUrl +
                                    'user-service/uploads/avatar.jpg',),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ' ${widget.professionel!=null  ? widget.professionel.username:''}',
                                      style: blackNormalBoldTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: Duration(
                                                      milliseconds: 600),
                                                  type: PageTransitionType.fade,
                                                  child: ArtisanProfilePage(
                                                    artisanImage:
                                                   '',
                                                    artisanName:
                                                    'widget.artisanName',
                                                    artisanType:
                                                    'widget.artisanType',
                                                    experience:
                                                    'widget.artisanExp',
                                                  )));
                                        },
                                        child: Text(
                                          'Voir  Profile',
                                          style: primaryColorsmallBoldTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                widget.professionel!=null && widget.professionel.profile!=null&& widget.professionel.speciality!=null && widget.professionel.speciality.isNotEmpty  ?
                                widget.professionel.speciality[0].name:' ' ,
                                style: greyNormalTextStyle,
                              ),
                              SizedBox(height: 7.0),
                             /* Text(

                                '${widget.artisanExp} Ans d\'Experience',
                                style: primaryColorNormalTextStyle,
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace,
                  Container(
                    width: double.infinity,
                    height: 0.7,
                    color: greyColor.withOpacity(0.4),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: fixPadding,
                        right: fixPadding * 2.0,
                        left: fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: greyColor,
                            ),
                            widthSpace,
                            Text(
                              new DateFormat('yyyy-MM-dd').format( widget.date),
                              style: blackNormalTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: greyColor,
                            ),
                            widthSpace,
                            Text(
                              'from: ' +widget.heurDebut +' to: '+widget.heurFin,
                              style: blackNormalTextStyle,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Appointment for Start
                Description(),
                // Appointment for End
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _bottomSheet(context, width) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (BuildContext bc) {
          return Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Wrap(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Choisissez l\'option',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 15.0),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        getImageFromCamera();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Caméra',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        getImageFromGallery();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_album,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Choisir depuis la galerie',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ],
            ),
          );
        });
  }
  void GoogleMapPlacePicker(context, width) {
    showModalBottomSheet(

        context: context,
        backgroundColor: Colors.white,
        builder: (BuildContext bc) {
          return PlacePicker(
            apiKey: googleMapApiKey,
            initialPosition: LatLng(-33.8567844, 151.213108),
            useCurrentLocation: true,
            selectInitialPosition: true,
            usePlaceDetailSearch: true,
            onPlacePicked: (result) {
              selectedPickupPlace = result;
              Navigator.of(context).pop();
              setState(() {});
            },
            selectedPlaceWidgetBuilder: (_, selectedPlace,
                state, isSearchBarFocused) {
              return isSearchBarFocused
                  ? Container()
                  : FloatingCard(
                bottomPosition: 0.0,
                leftPosition: 0.0,
                rightPosition: 0.0,
                width: 500,
                borderRadius:
                BorderRadius.circular(12.0),

                child: state == SearchingState.Searching

                    ? Center(
                    child:
                    CircularProgressIndicator())
                    : ElevatedButton(
                  child: Text("choisissez cet endroit"),
                  onPressed: () {
                    print(selectedPlace
                        .geometry.location);
                    Navigator.pop(
                        context, selectedPlace);
                    setState(() {});
                  },

                ),

              );
            },

          );
        });
  }
  successOrderDialog( String headerTitle,String bodyMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 170.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70.0,
                  width: 70.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(color: primaryColor, width: 1.0),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 40.0,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  headerTitle ,
                  style: greySmallBoldTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  bodyMessage,
                  style: greyVerySmallBoldTextStyle,
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Description() {
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description de rendez-vous',
            style: blackBigBoldTextStyle,
          ),
          TextField(
            controller: descriptionController,
            onChanged: (v){
              appointment.description=descriptionController.text;
            },
            maxLines: 8,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),

                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Ecrire votre Description ",
                fillColor: Colors.white70),
          ),

          heightSpace,
          heightSpace,

          heightSpace,
          heightSpace,

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Icon(Icons.location_on_outlined, color: Colors.lime, size: 20.0),
          //     SizedBox(width: 5.0),
          //
          //     Wrap(
          //
          //       children: [
          //
          //         InkWell(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 PageTransition(
          //                     duration: Duration(
          //                         milliseconds: 600),
          //                     type: PageTransitionType.fade,
          //                     child: GoogleMapPlacePicker()));
          //           },
          //           child: Text(
          //             'Ma localisation',
          //             style: primaryColorsmallBoldTextStyle,
          //           ),
          //
          //         ),
          //       ],
          //     ),
          //   ],
          // ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Icon(Icons.image_outlined , color: Colors.lime, size: 20.0),
          //     SizedBox(width: 5.0),
          //
          //     Wrap(
          //
          //       children: [
          //
          //         InkWell(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 PageTransition(
          //                     duration: Duration(
          //                         milliseconds: 600),
          //                     type: PageTransitionType.fade,
          //                     child: ImagePickerIntegration()));
          //           },
          //           child: Text(
          //             'Ajouter images ',
          //             style: primaryColorsmallBoldTextStyle,
          //           ),
          //
          //
          //         ),
          //       ],
          //     ),
          //   ],
          // ),

        ],
      ),
    );
  }
}
