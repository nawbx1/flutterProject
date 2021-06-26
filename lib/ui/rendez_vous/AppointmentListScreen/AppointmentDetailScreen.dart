import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/ActionButton.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Appointment appointmentData;
  final bool isFromAppointmentCard;
  const AppointmentDetailScreen({Key key, @required this.appointmentData ,@required this.isFromAppointmentCard})
      : super(key: key);
  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen>
    with SingleTickerProviderStateMixin {
  bool isContainerCollapsed = true;
  bool isDateAndTimeVisible = false;
  bool isUserProfileImageVisible = false;
  bool isPhoneLogoVisible = false;
  bool areDetailsvisible = false;
  AnimationController animationController;
  Tween<double> tweenedValue;
  Animation tweenAnimation;
  @override
  void initState() {
    super.initState();
    initiateAnimation();
    animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 275),
    );
    tweenedValue = Tween(begin: 50, end: 0);
    tweenAnimation = tweenedValue.animate(animationController);
    animationController.addListener(
      () {
        setState(() {});
      },
    );
  }

  ///The animation here are staged
  void initiateAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isContainerCollapsed = false;
      });
    }).then(
      (f) {
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            isDateAndTimeVisible = true;
          });
        }).then((f) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              isUserProfileImageVisible = true;
            });
          }).then((f) {
            Future.delayed(Duration(milliseconds: 200), () {
              setState(() {
                isPhoneLogoVisible = true;
              });
            }).then((f) {
              Future.delayed(Duration(milliseconds: 150), () {
                setState(() {
                  areDetailsvisible = true;
                });
                animationController.forward();
              });
            });
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: AnimatedOpacity(
        duration: Duration(milliseconds: 230),
        opacity: isContainerCollapsed ? 0 : 1,
        child:

          widget.isFromAppointmentCard ?
        ActionButton(
          onAcceptPressed: () {
            print('Nothing Configured for it ');
          },
          onDecinePressed: () {
            reverseAnimation();
          },
        ) :
          Container(
            child: Text(
              '' reverseAnimation();
            ),
          ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
              Stack(
                children: <Widget>[
                  AnimatedContainer(
                    curve: isContainerCollapsed
                        ? Curves.elasticIn
                        : Curves.elasticOut,
                    duration: Duration(seconds: 1),
                    height: isContainerCollapsed
                        ? 0
                        : SizeConfig.safeBlockVertical * 40,
                    width: isContainerCollapsed
                        ? 0
                        : SizeConfig.safeBlockHorizontal * 100,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(145),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 48.0),
                          child: Container(
                            //color: Colors.white,
                            height: SizeConfig.safeBlockVertical * 19,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            child: Center(
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 375),
                                opacity: isDateAndTimeVisible ? 1 : 0,
                                child: Text(


                                widget.appointmentData != null &&
                                    widget.appointmentData.appointmentPK != null &&
                                    widget.appointmentData.appointmentPK.startDate != null
                                    &&
                                    widget.appointmentData.appointmentPK.startDate != null
                                ? new DateFormat('dd-MM-yyyy')
                                    .format(widget.appointmentData.appointmentPK.startDate) +'\n Debut :'+ new DateFormat('hh:mm')
                                    .format(widget.appointmentData.appointmentPK.startDate)+'\n  Fin :'+ new DateFormat('hh:mm')
                                    .format(widget.appointmentData.appointmentPK.endDate)
                                      : '01/04/2021 \n Heure Debut : 08:30 \n Heure Fin : 11:00'





                                  /*widget.appointmentData.appoitmentDate +
                                      ', ' +
                                      widget.appointmentData.appoitmentTime*/,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 8,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical * 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 65.0),
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: AnimatedOpacity(
                              opacity: isUserProfileImageVisible ? 1 : 0,
                              duration: Duration(milliseconds: 300),
                              child: Container(
                                child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                                  child: Image.network(
                                      (widget.appointmentData.client.profile!=null && widget.appointmentData.client.profile.profileImage !=null )?
                                      apiUrl+'user-service/uploads/'+widget.appointmentData.client.profile.profileImage.mediaURL
                                          :  apiUrl+'user-service/uploads/avatar.jpg',
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

                                height: SizeConfig.safeBlockVertical * 13,
                                width: SizeConfig.safeBlockHorizontal * 26,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 18),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () {

                                },
                                child: AnimatedOpacity(
                                  opacity: isPhoneLogoVisible ? 1 : 0,
                                  duration: Duration(milliseconds: 300),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: blueColor,
                                        border: Border.all(
                                            color: Colors.white, width: 5),
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    height: SizeConfig.safeBlockVertical * 8.66,
                                    width:
                                        SizeConfig.safeBlockHorizontal * 17.33,
                                    child: Icon(
                                      Icons.phone,
                                      size:
                                          SizeConfig.safeBlockHorizontal * 8.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65.0, top: 8, right: 22),
                child: Transform.translate(
                  offset: Offset(0, tweenAnimation.value),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 235),
                    opacity: areDetailsvisible ? 1 : 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 80,
                          height: SizeConfig.safeBlockVertical * 9,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.appointmentData.client.username,
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 7,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),

                        Container(
                            //color: Colors.yellow,
                            width: SizeConfig.safeBlockHorizontal * 80,
                            height: SizeConfig.safeBlockVertical * 4,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Description:',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45),
                              ),
                            )),
                        Container(
                          //color: Colors.yellow,
                          width: SizeConfig.safeBlockHorizontal * 80,
                          //height: SizeConfig.safeBlockVertical*20,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.appointmentData.description,
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reverseAnimation() {
    Future.delayed(Duration(milliseconds: 00), () {
      setState(() {
        isContainerCollapsed = true;
      });
    }).then((f) {
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          isDateAndTimeVisible = false;
        });
      }).then((f) {
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {
            isUserProfileImageVisible = false;
          });
        }).then((f) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              isPhoneLogoVisible = false;
            });
          }).then((f) {
            Future.delayed(Duration(milliseconds: 250), () {
              setState(() {
                areDetailsvisible = false;
              });
              animationController.reverse().then((f) {
                Navigator.pop(context);
              });
            });
          });
        });
      });
    });
  }
}
