import 'package:doctor_pro/bloc/AppointmentBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/ui/auth/sign_up_page.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentDetailScreen.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/MiniAppointmentCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/SlidingCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/sizeConfig.dart';
import 'package:doctor_pro/ui/util/SideMenu.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class AppointmentScreen extends StatefulWidget {
  final List<Appointment> RDVList ;

  const AppointmentScreen(
      {Key key, @required this.RDVList }) : super(key: key);
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {




  AppointmentBloc appointmentBloc = new AppointmentBloc();

  /*void fetchRDV() async {
    RDVList = await appointmentBloc.getProfessionelCalendar(7);
    setState(() {
      RDVList;
      (RDVList != null) ?
      RDVList : RDVList = [];
    });
    print(RDVList);
  }*/

  @override
  void initState() {
    super.initState();
    //fetchRDV();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return
      showListFullAppointment(converAppointmentToLesssAppointment(widget.RDVList));
  }


  Widget showListFullAppointment(List<Widget> fullAppointment) {
    return Container(
      color: Color(0xffF3F6FF).withOpacity(0.134),
      child: AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: fullAppointment.length,
          itemBuilder: (BuildContext context, int index) {

            return AnimationConfiguration.staggeredList(
              position: index,
              duration: Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: -20,
                child: FadeInAnimation(child: fullAppointment[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  //now we create the card comming from the appointment manager
  List<Widget> converAppointmentToLesssAppointment(List<Appointment> listAppointment) {
    List<Widget> list=[];
    for (var anElement in listAppointment) {

      print('adding mini card');
      setState(() {
        list.add(Center(
            child: MiniAppointmentCard(
              onCardTapped: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: AppointmentDetailScreen(
                          appointmentData: anElement,
                        )));
              },
              appointmentData: anElement,
            )));
      });

    }
    return list;
  }

  List<Widget> converAppointmentToFullAppointment(List<Appointment> listAppointment) {
    List<Widget> list=[];
    for (var anElement in listAppointment) {
      SlidingCardController aController = new SlidingCardController();
      print('adding mini card');
      setState(() {
        list.add(
            appointmentCardWithButton(anElement, aController)

        );
      });

    }
    return list;
  }

  Widget appointmentCardWithButton(Appointment anElement,
      SlidingCardController aController) {
    return
      Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppointmentCard(
              onCardTapped: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: AppointmentDetailScreen(
                          appointmentData: anElement,
                        )));
              },
              key: Key(Random().nextInt(4000).toString()),
              slidingCardController: aController,
              appointmentData: anElement,
            ),
          ));
  }

}
