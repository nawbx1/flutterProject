
import 'package:doctor_pro/bloc/AppointmentBloc.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentDetailScreen.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/MiniAppointmentCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/SlidingCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/sizeConfig.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_pro/constant/constant.dart';
import 'package:intl/intl.dart';



import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class AppointmentPage extends StatefulWidget {
  final bool isProfessionnel ;
  const AppointmentPage(
      {Key key, @required this.isProfessionnel }) : super(key: key);
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  //final String Url = apiUrl+"rendez-vous-service/rdv/all";

  Widget listWidjet  ;

  List<Appointment> RDVList=[];
  List<Appointment> enattentelist=[];
  List<Appointment> acceptedlist=[];
  List<Appointment> acheavedlist=[];
  List<String> labels = [];
  int currentIndex = 0;

  AppointmentBloc appointmentBloc=new AppointmentBloc();
  void fetchRDV() async {
    if(!widget.isProfessionnel)
      RDVList = await appointmentBloc.getMyAppointmentAsClient();
    else   RDVList = await appointmentBloc.getMyAppointment();


    //encours,validée,refusée,terminée,en_attente
    for(Appointment a in RDVList ){
      if(a.status=='terminée')
        setState(() {
          acheavedlist.add(a);
        });

      if(a.status=='en_attente')
        setState(() {
          enattentelist.add(a);
        });

      if(a.status=='validée')
        setState(() {
          acceptedlist.add(a);
        });
    }

    print(RDVList);

  }
  @override
  void initState(){
    super.initState();
    fetchRDV() ;

  }

  deleteAppointmentDialog(index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Are you sure you want to cancel this appointment?",
                      style: blackNormalTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'No',
                              style: primaryColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              RDVList.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Yes',
                              style: whiteColorButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.0,
          automaticallyImplyLeading: false,
          title: Text(
            'Rendez-vous',
            style: appBarTitleTextStyle,
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: tabItem('tous ', RDVList !=null ? RDVList.length:0),
              ),
              Tab(
                child: tabItem('en attente ', enattentelist !=null ? enattentelist.length:0),
              ),
              Tab(
                child: tabItem(' accepté', acceptedlist !=null ?acceptedlist.length :0),
              ),
              Tab(
                child: tabItem('terminé', acheavedlist !=null ?acheavedlist.length :0),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllAppointment(),
            enAttenteAppointments(),
            acceptedAppointments(),
            acheavedAppointments(),
          ],
        ),
      ),
    );
  }


  tabItem(text, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: blackSmallTextStyle,
        ),
        SizedBox(width: 4.0),
        Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: whiteColor,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  AllAppointment() {
    return (RDVList  == null ||  RDVList.length == 0)
        ?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.date_range,
            color: greyColor,
            size: 70.0,
          ),
          heightSpace,
          Text(
            'AUCUN RENDEZ-VOUS ACCEPTÉ',
            style: greyNormalTextStyle,
          ),
        ],
      ),
    )
        :showListFullAppointment(converAppointmentToLesssAppointment(RDVList));

  }

  enAttenteAppointments() {
    return (enattentelist  == null ||  enattentelist.length == 0)
        ?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.date_range,
            color: greyColor,
            size: 70.0,
          ),
          heightSpace,
          Text(
            'AUCUN RENDEZ-VOUS EN ATTENTE ',
            style: greyNormalTextStyle,
          ),
        ],
      ),
    )
        :
    showListFullAppointment(converAppointmentToFullAppointment(enattentelist));
  }

  acceptedAppointments() {
    return (acceptedlist == null || acceptedlist.length == 0)
        ?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.date_range,
            color: greyColor,
            size: 70.0,
          ),
          heightSpace,
          Text(
            'AUCUN RENDEZ-VOUS ACCEPTÉ',
            style: greyNormalTextStyle,
          ),
        ],
      ),
    )
        :
    showListFullAppointment(converAppointmentToLesssAppointment(acceptedlist));
  }

  acheavedAppointments() {
    return (acheavedlist==null || acheavedlist.length == 0)
        ?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.date_range,
            color: greyColor,
            size: 70.0,
          ),
          heightSpace,
          Text(
            'AUCUN RENDEZ-VOUS TERMINÉ',
            style: greyNormalTextStyle,
          ),
        ],
      ),
    )
        :  showListFullAppointment(converAppointmentToLesssAppointment(acheavedlist));
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
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
    print('list appppppointmennnnt');
    print(listAppointment);
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
                            isFromAppointmentCard: false
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
              onAppointmentAccepted:(){
                setState(() {
                  enattentelist.remove(anElement);
                  acceptedlist.add(anElement);

                });
              },

              onAppointmentRefused:(){
                setState(() {
                  enattentelist.remove(anElement);
                  acceptedlist.add(anElement);

                });
              },
              onCardTapped: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: AppointmentDetailScreen(
                          appointmentData: anElement,
                            isFromAppointmentCard: true
                        )));
              },
              key: Key(Random().nextInt(4000).toString()),
              slidingCardController: aController,
              appointmentData: anElement,
            ),
          ));
  }

}
