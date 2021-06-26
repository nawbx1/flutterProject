import 'package:doctor_pro/bloc/AppointmentBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentBackCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/AppointmentFrontCard.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentListScreen/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SlidingCard.dart';
import 'package:intl/intl.dart';

///This is the main Appointment card
///it regroups the AppointmentFrontCard
///and AppointmentBacktCard together
///using my future dart package ''SlidingCard''
class AppointmentCard extends StatelessWidget {
  const AppointmentCard(
      {Key key,
      this.slidingCardController,
      @required this.appointmentData,
      @required this.onCardTapped,
        @required this.onAppointmentAccepted,
        @required this.onAppointmentRefused})
      : super(key: key);
  final Appointment appointmentData;
  final SlidingCardController slidingCardController;
  final Function onCardTapped;
  final Function onAppointmentAccepted;
  final Function onAppointmentRefused;

  @override
  Widget build(BuildContext context) {
    AppointmentBloc appointmentBloc = new AppointmentBloc();
    updateAppointementStatus(String status) async {
      appointmentData.status = status;
      Appointment app = await appointmentBloc.update(appointmentData);
    }

    return GestureDetector(
      onTap: () {
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
          appointmentTitle:
              appointmentData != null && appointmentData.title != null
                  ? appointmentData.title
                  : "Rendez-Vous",
          imgLink: (
                  appointmentData != null &&
                  appointmentData.client != null &&
                  appointmentData.client.profile != null &&
                  appointmentData.client.profile.profileImage != null &&
                  appointmentData.client.profile.profileImage.mediaURL != null)
              ? apiUrl +
                  "user-service/uploads/" +
                  appointmentData.client.id.toString() +
                  appointmentData.client.profile.profileImage.mediaURL
              : apiUrl + "user-service/uploads/avatar.jpg",
          patienName: appointmentData != null &&
                  appointmentData.client != null &&
                  appointmentData.client.name != null
              ? appointmentData.client.name
              : "Client",
          patienSurname: appointmentData != null &&
                  appointmentData.client != null &&
                  appointmentData.client.email != null
              ? appointmentData.client.email
              : "mail@bh.tn",
          appointmentDate:
          appointmentData != null &&
                  appointmentData.appointmentPK != null &&
                  appointmentData.appointmentPK.startDate != null
              ? new DateFormat('dd-MM-yyyy')
                  .format(appointmentData.appointmentPK.startDate)
              : "01/04/2021",
          appointmentTime: appointmentData != null &&
                  appointmentData.appointmentPK != null &&
                  appointmentData.appointmentPK.startDate != null
              ? new DateFormat('hh:mm')
                  .format(appointmentData.appointmentPK.startDate)
              : "12:30",
          onInfoTapped: () {
            print('info pressed');
            slidingCardController.expandCard();
          },
          onDecline: () {
            print('Declined'); //encours,validée,refusée,terminée,en_attente
            updateAppointementStatus("refusée");
            onAppointmentRefused();
          },
          onAccep: () {
            updateAppointementStatus("validée");
            print('Accepted');
            onAppointmentAccepted();
          },
          onRedCloseButtonTapped: () {
            slidingCardController.collapseCard();
          },
        ),
        backCardWidget: AppointmentBackCard(
          onPhoneTapped: () {
            print('Phone tapped');
            launch(appointmentData != null &&
                    appointmentData.client != null &&
                    appointmentData.client.phone != null
                ? "tel://" + appointmentData.client.phone.toString()
                : "tel://21269974");
          },
          patientComment:
              appointmentData != null && appointmentData.description != null
                  ? appointmentData.description
                  : "",
        ),
      ),
    );
  }
}
