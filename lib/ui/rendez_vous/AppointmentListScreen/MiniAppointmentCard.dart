import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MiniAppointmentCard extends StatelessWidget {
  final Appointment appointmentData;
  final Function onCardTapped;
  const MiniAppointmentCard({
    @required this.appointmentData,
    @required this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Mini appointment Card tapped');
        onCardTapped();
      },
      child: Card(
        elevation: 0.3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          width: SizeConfig.horizontalBloc * 90,
          height: SizeConfig.verticalBloc * 8.7,
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                          child: Image.network(
                              (appointmentData !=null && appointmentData.client !=null
                                  && appointmentData.client.profile !=null && appointmentData.client.profile.profileImage !=null
                                  && appointmentData.client.profile.profileImage.mediaURL !=null ) ?
                              apiUrl+"user-service/uploads/"+ appointmentData.client.id.toString()+appointmentData.client.profile.profileImage.mediaURL:
                              apiUrl+"user-service/uploads/avatar.jpg"
                              ,
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

                        height: SizeConfig.safeBlockVertical * 8,
                        width: SizeConfig.safeBlockHorizontal * 15,
                      ),
                      Positioned(
                        right: -3,
                        bottom: -0.5,
                        child: Container(
                          width: SizeConfig.safeBlockHorizontal * 4.5,
                          height: SizeConfig.safeBlockHorizontal * 4.5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                              color: Color(0xff5EFF38)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.safeBlockVertical * 3,
                        width: SizeConfig.safeBlockHorizontal * 90,
                        //color: Colors.yellow,
                        child: Text(appointmentData.client.username
                         /* appointmentData.patientSurName +
                              ' ' +
                              appointmentData.patientName*/,
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      Container(
                        height: SizeConfig.safeBlockVertical * 3,
                        width: SizeConfig.safeBlockHorizontal * 90,
                        //color: Colors.pink,
                        child: Text(appointmentData !=null && appointmentData.appointmentPK !=null
                            && appointmentData.appointmentPK.startDate !=null ?new DateFormat('dd-MM-yyyy hh:mm').
                        format(appointmentData.appointmentPK.startDate) : "01/04/2021 12:30",
                          /*
                          appointmentData.appoitmentDate +
                              ', ' +
                              appointmentData.appoitmentTime,*/
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    color: Colors.black54,
                    iconSize: SizeConfig.safeBlockHorizontal * 7,
                    onPressed: () {
                      print('3 dots icon tapped');
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
