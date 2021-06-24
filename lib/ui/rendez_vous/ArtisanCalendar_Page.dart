import 'package:doctor_pro/bloc/AppointmentBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/model/Region.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar_widget/date_helper.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';
import 'package:page_transition/page_transition.dart';

import '../../pages/artisan/drawer_1.dart';
import 'package:doctor_pro/ui/rendez_vous/AppointmentDetails_Page.dart';
import 'package:doctor_pro/ui/rendez_vous/ArtisanProfile_Page.dart';
import 'package:doctor_pro/model/Appointment.dart';

const labelMonth = 'Month';
const labelDate = 'Date';

const labelWeekDay = 'Week Day';

class ArtisanCalendar extends StatefulWidget {

  final int id;
  final User professionel;
  final InterventionType  interventionType;
  final Region region;

  const ArtisanCalendar(
      {Key key,

        @required this.id,
      @required this.professionel,
      @required this.interventionType,
      @required this.region
      })
      : super(key: key);

  @override
  ArtisanCalendarState createState() => ArtisanCalendarState();
}

class ArtisanCalendarState extends State<ArtisanCalendar> {
  String selectedTime = '';
  String selectedTimeEnd = '';
  String selectedDate;
  DateTime date = DateTime.now();
  String monthString;
  bool showConfirmButtom = false;

  List<Appointment> listAppointment;

  AppointmentBloc appointmentBloc = new AppointmentBloc();
  Map<String, dynamic> timeCalendar = {
    'morningSlotList': [
      {'time': '8:00 ', 'value': 80, 'isSelected': false,'isDisabled':false},
      {'time': '8:30 ', 'value': 85, 'isSelected': false },
      {'time': '9:00 ', 'value': 90, 'isSelected': false},
      {'time': '9:30 ', 'value': 95, 'isSelected': false},
      {'time': '10:00 ', 'value': 100, 'isSelected': false},
      {'time': '10:30 ', 'value': 105, 'isSelected': false},
      {'time': '11:00 ', 'value': 110, 'isSelected': false},
      {'time': '11:30 ', 'value': 115, 'isSelected': false}
    ],
    'afternoonSlotList': [
      {'time': '12:30 ', 'value': 125, 'isSelected': false},
      {'time': '13:00 ', 'value': 130, 'isSelected': false},
      {'time': '13:30 ', 'value': 135, 'isSelected': false},
      {'time': '14:00 ', 'value': 140, 'isSelected': false},
      {'time': '14:30 ', 'value': 145, 'isSelected': false},
      {'time': '15:00 ', 'value': 150, 'isSelected': false},
      {'time': '15:30 ', 'value': 155, 'isSelected': false},
      {'time': '16:00 ', 'value': 160, 'isSelected': false},
      {'time': '16:30 ', 'value': 165, 'isSelected': false},
      {'time': '17:00 ', 'value': 170, 'isSelected': false},
      {'time': '17:30 ', 'value': 175, 'isSelected': false},
      {'time': '18:00 ', 'value': 180, 'isSelected': false}
    ],
    'eveningSlotList': [
      {'time': '18:30 ', 'value': 185, 'isSelected': false},
      {'time': '19:00 ', 'value': 190, 'isSelected': false},
      {'time': '19:30 ', 'value': 195, 'isSelected': false},
      {'time': '20:00 ', 'value': 200, 'isSelected': false},
      {'time': '20:30 ', 'value': 205, 'isSelected': false},
      {'time': '21:00 ', 'value': 210, 'isSelected': false},
      {'time': '21:30 ', 'value': 215, 'isSelected': false},
      {'time': '22:00 ', 'value': 220, 'isSelected': false},
      {'time': '22:30 ', 'value': 225, 'isSelected': false}
    ]
  };

  DateTime firstDate;
  DateTime lastDate;
  String dateFormat = 'dd';
  String monthFormat = 'MMM';
  String weekDayFormat = 'EEE';
  List<String> order = [labelMonth, labelDate, labelWeekDay];
  bool forceRender = false;

  Color defaultDecorationColor = Colors.transparent;
  BoxShape defaultDecorationShape = BoxShape.circle;
  bool isCircularRadiusDefault = true;

  Color selectedDecorationColor = primaryColor;
  BoxShape selectedDecorationShape = BoxShape.circle;
  bool isCircularRadiusSelected = true;

  Color disabledDecorationColor = Colors.grey;
  BoxShape disabledDecorationShape = BoxShape.circle;
  bool isCircularRadiusDisabled = true;

  int minSelectedDateCount = 1;
  int maxSelectedDateCount = 1;
  RangeValues selectedDateCount;

  List<DateTime> initialSelectedDates;
  int count = 0;
  int startHour = 0;
  int endHour = 0;

  void initialiserTimeCalender() async{
    listAppointment = await appointmentBloc.getProfessionelCalendar(7);
  }

  testvars(e){
    print('selected date is ');
print(e.toString());
  }
  void initialiserSelectedTimeCalenderItems(int first, int last) {
    print('initialiserSelectedTimeCalenderItems');
    print(first);
    print(last);
    print('value of first  = ' +
        first.toString() +
        '     value of last  = ' +
        last.toString());
    for (dynamic value in timeCalendar.values) {
      for (dynamic value2 in value) {
        if (int.parse(value2['value'].toString()).compareTo(first) >= 0 &&
            int.parse(value2['value'].toString()).compareTo(last) <= 0) {
          print('value of first  = ' + first.toString());
          setState(() {
            value2['isSelected'] = true;
          });
        } else {
          setState(() {
            value2['isSelected'] = false;
          });
        }
      }
    }
  }
  String heurDebut;
  String heurFin;

  updateTimeSelected(int timeSelected) {
    print('updateTimeSelected');
    print(timeSelected);
    setState(() {
      count += 1;
    });

    if (count.compareTo(1) == 0) {
      setState(() {
        startHour = timeSelected;
        heurDebut=selectedTime;
      });

      print('value of startHour if loula');
      print(startHour);
      print('value of endHour');
      print(endHour);
      initialiserSelectedTimeCalenderItems(startHour, startHour);
      showConfirmButtom = false;
    }
    // i
    else if (count.compareTo(2) == 0) {
      setState(() {
        endHour = timeSelected; // timeSelected !=null ? timeSelected: 0;
        heurFin=selectedTime;
        count = 0;
      });
      initialiserSelectedTimeCalenderItems(startHour, endHour);
      showConfirmButtom = true;
      print('value of startHour if theniya');
      print(startHour);
      print('value of endHour');
      print(endHour);
    }
  }

  @override
  void initState() {
    super.initState();

    const int days = 30;
    firstDate = toDateMonthYear(DateTime.now());
    lastDate = toDateMonthYear(firstDate.add(Duration(days: days - 1)));
    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
    initialSelectedDates = feedInitialSelectedDates(minSelectedDateCount, days);
    setState(() {
      selectedDate =
          '${firstDate.day}-${convertNumberMonthToStringMonth(firstDate.month)}';
    });
  }

  List<DateTime> feedInitialSelectedDates(int target, int calendarDays) {
    List<DateTime> selectedDates = [];

    for (int i = 0; i < calendarDays; i++) {
      if (selectedDates.length == target) {
        break;
      }
      DateTime date = firstDate.add(Duration(days: i));
      if (date.weekday != DateTime.sunday) {
        selectedDates.add(date);
      }
    }
    return selectedDates;
  }

  String convertNumberMonthToStringMonth(month) {
    if (month == 1) {
      monthString = 'January';
    } else if (month == 2) {
      monthString = 'Fabruary';
    } else if (month == 3) {
      monthString = 'March';
    } else if (month == 4) {
      monthString = 'April';
    } else if (month == 5) {
      monthString = 'May';
    } else if (month == 6) {
      monthString = 'June';
    } else if (month == 7) {
      monthString = 'July';
    } else if (month == 8) {
      monthString = 'August';
    } else if (month == 9) {
      monthString = 'September';
    } else if (month == 10) {
      monthString = 'October';
    } else if (month == 11) {
      monthString = 'November';
    } else if (month == 12) {
      monthString = 'December';
    }
    return monthString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer1().build(context),
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'Rendez-vous ',
          style: appBarTitleTextStyle,
        ),
      ),
      bottomNavigationBar: (!showConfirmButtom)
          ? Container(
              height: 0.0,
              width: 0.0,
            )
          : Material(
              elevation: 5.0,
              child: Container(
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
                            child:
                                //GoogleMapPlacePicker()
                                AppointmentDetails(

                                professionel: widget.professionel,
                                interventionType: widget.interventionType,
                                region: widget.region,

                              date: date,
                                  heurFin: heurFin,
                                    heurDebut:heurDebut ,
                            )));
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
                      'Confirmer',
                      style: whiteColorButtonTextStyle,
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
              padding: EdgeInsets.only(top: fixPadding * 2.0),
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
                          tag: widget.professionel!=null && widget.professionel.profile!=null&& widget.professionel.profile.profileImage!=null ?
                          widget.professionel.profile.profileImage.mediaURL: 'uploads/avatar.jpg',
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
                                image: NetworkImage(
                                   widget.professionel!=null && widget.professionel.profile!=null&& widget.professionel.profile.profileImage!=null ?
                                   apiUrl +
                                       'user-service/'+  widget.professionel.profile.profileImage.mediaURL: apiUrl +
                                       'user-service/uploads/avatar.jpg',
                                ),
                                onError: (exception, stackTrace) => Image(
                                    image: NetworkImage(
                                  apiUrl + 'user-service/uploads/avatar.jpg',
                                )),
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
                                      ' ${ widget.professionel!=null  ? widget.professionel.username:''}',
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
                                                        '',
                                                    artisanType:
                                                        '',
                                                    experience:
                                                        '',
                                                  )));
                                        },
                                        child: Text(
                                          'Voir Profil',
                                          style: primaryColorsmallBoldTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                widget.professionel!=null && widget.professionel.profile!=null&& widget.professionel.speciality!=null
                                    && widget.professionel.speciality.isNotEmpty?
                                widget.professionel.speciality[0].name:' ' ,
                                style: greyNormalTextStyle,
                              ),
                              SizedBox(height: 7.0),
                              //Text(
                              //  '${widget.experience} ans  d\'Experience',
                               // style: primaryColorNormalTextStyle,
                              //),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  HorizontalCalendar(
                    key: forceRender ? UniqueKey() : Key('Calendar'),
                    selectedDateTextStyle: TextStyle(color: whiteColor),
                    selectedMonthTextStyle: TextStyle(color: whiteColor),
                    selectedWeekDayTextStyle: TextStyle(color: whiteColor),
                    spacingBetweenDates: 10.0,
                    height: 105,
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    firstDate: firstDate,
                    lastDate: lastDate,
                    dateFormat: dateFormat,
                    weekDayFormat: weekDayFormat,
                    monthFormat: monthFormat,
                    defaultDecoration: BoxDecoration(
                      color: defaultDecorationColor,
                      shape: defaultDecorationShape,
                      borderRadius:
                          defaultDecorationShape == BoxShape.rectangle &&
                                  isCircularRadiusDefault
                              ? BorderRadius.circular(8)
                              : null,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: selectedDecorationColor,
                      shape: selectedDecorationShape,
                      borderRadius:
                          selectedDecorationShape == BoxShape.rectangle &&
                                  isCircularRadiusSelected
                              ? BorderRadius.circular(8)
                              : null,
                    ),
                    disabledDecoration: BoxDecoration(
                      color: disabledDecorationColor,
                      shape: disabledDecorationShape,
                      borderRadius:
                          disabledDecorationShape == BoxShape.rectangle &&
                                  isCircularRadiusDisabled
                              ? BorderRadius.circular(8)
                              : null,
                    ),
                    isDateDisabled: (date) => date.weekday == DateTime.sunday,
                    labelOrder: order.map(toLabelType).toList(),
                    maxSelectedDateCount: maxSelectedDateCount,
                    initialSelectedDates: initialSelectedDates,
                    onDateSelected: (e) async {
                      setState(() {
                        testvars(e);
                        selectedDate =
                            '${e.day}-${convertNumberMonthToStringMonth(e.month)}';
                        date=e;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: slots(),
          ),
        ],
      ),
    );
  }

  LabelType toLabelType(String label) {
    LabelType type;
    switch (label) {
      case labelMonth:
        type = LabelType.month;
        break;
      case labelDate:
        type = LabelType.date;
        break;
      case labelWeekDay:
        type = LabelType.weekday;
        break;
    }
    return type;
  }

  slots() {
    return ListView(
      children: [
        heightSpace,
        // Morning Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sunrise.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                'Matin',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: timeCalendar['morningSlotList']
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      //ontap verif value
                      setState(() {
                        selectedTime = e['time'];
                        updateTimeSelected(int.parse(e['value'].toString()));
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: (e['isSelected'] ==
                                true) //  (e['value'] >=startHour &&e['value'] <=endHour )
                            ? primaryColor
                            : whiteColor,
                      ),
                      child: Text(e['time'],
                          style: (e['isSelected'] ==
                                  true) //(e['value'] >=startHour &&e['value'] <=endHour )
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),

        // Morning Slot End

        // Afternoon Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sun.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                'Aprés-midi',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: timeCalendar['afternoonSlotList']
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      //ksjdksjfks
                      setState(() {
                        selectedTime = e['time'];
                        updateTimeSelected(int.parse(e['value'].toString()));
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: (e['isSelected'] ==
                                true) //(e['value'] >=startHour &&e['value'] <=endHour )
                            ? primaryColor
                            : whiteColor,
                      ),
                      child: Text(e['time'],
                          style: (e['isSelected'] ==
                                  true) // (e['value'] >=startHour &&e['value'] <=endHour )
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),
        // Afternoon Slot End

        // Evening Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sun-night.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                'Soir',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: timeCalendar['eveningSlotList']
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = e['time'];
                        updateTimeSelected(int.parse(e['value'].toString()));
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: (e['isSelected'] == true)
                            ? primaryColor
                            : whiteColor,
                      ),
                      child: Text(e['time'],
                          style: (e['isSelected'] == true)
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),
        // Evening Slot End
      ],
    );
  }
}
