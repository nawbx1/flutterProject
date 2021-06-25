import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentBackCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentFrontCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'SlidingCard.dart';


///This is the main Appointment card 
///it regroups the AppointmentFrontCard 
///and AppointmentBacktCard together 
///using my future dart package ''SlidingCard''
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    Key key,
    this.slidingCardController ,@required this.appointmentData, @required this.onCardTapped
  }) : super(key: key);
  final Appointment appointmentData;
  final  SlidingCardController slidingCardController;
  final Function onCardTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('Well the card was tapped');
        onCardTapped();
      },
          child: SlidingCard(
                slimeCardElevation: 0.5,
               // slidingAnimationReverseCurve: Curves.bounceInOut,
                cardsGap: SizeConfig.safeBlockVertical,
                controller: slidingCardController,
                slidingCardWidth: SizeConfig.horizontalBloc * 90,
                visibleCardHeight: SizeConfig.safeBlockVertical * 27,
                hiddenCardHeight: SizeConfig.safeBlockVertical * 15,
                frontCardWidget: AppointmentFrontCard(
                  imgLink: "appointmentData.client.profile.profileImage.mediaURL",
                  patienName: "appointmentData.patientName",
                  patienSurname: "appointmentData.patientSurName",
                  appointmentDate: "appointmentData.appoitmentDate",
                  appointmentTime: "appointmentData.appoitmentTime",
                  onInfoTapped: () {
                    print('info pressed');
                    slidingCardController.expandCard();
                  },
                  onDecline: () {
                    print('Declined');
                  },
                  onAccep: () {
                    print('Accepted');
                  },
                  onRedCloseButtonTapped: (){
                    slidingCardController.collapseCard();
                  },
                ),
                backCardWidget:AppointmentBackCard(
                  onPhoneTapped: (){print('Phone tapped');},
                  patientComment: "appointmentData.appoitmentComment"
                ),
      ),
    );
  }
}

