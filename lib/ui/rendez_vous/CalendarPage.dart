import 'package:doctor_pro/bloc/AppointmentBloc.dart';
import 'package:doctor_pro/model/Appointment.dart';
import 'package:flutter/material.dart';
import 'package:cell_calendar/cell_calendar.dart';

class CalendarPage extends StatefulWidget {

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Appointment> RDVList=[];
  List<Appointment> enattentelist=[];
  List<Appointment> acceptedlist=[];
  List<Appointment> acheavedlist=[];


  AppointmentBloc appointmentBloc=new AppointmentBloc();
  void fetchRDV() async {

    RDVList = await appointmentBloc.getMyAppointmentAsClient();

    setState(() {
      RDVList ;
    });
    print("RDVList");
    print(RDVList);

  }
  @override
  void initState(){
    super.initState();
    fetchRDV() ;

  }

  insertAppointmentToCalendar(){
    for(Appointment a in RDVList ){
      setState(() {

      });
    }
  }

  List<CalendarEvent> sampleEvents() {
    final today = DateTime.now();
    final sampleEvents = [];

    for(Appointment a in RDVList ){
      setState(() {
        sampleEvents.add(
          new CalendarEvent(
            eventName:a.title,
            eventDate: today.add(Duration(days: today.day - a.appointmentPK.startDate.day)),
            //  eventDate: today.add(Duration(days: 0,hours: getHoursBetween())),
            eventBackgroundColor: Colors.green),
        );
      });
    }

    return sampleEvents;
  }

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: CellCalendar(
        cellCalendarPageController: cellCalendarPageController,
        events: _sampleEvents,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime.year.toString();
          final month = datetime.month.monthName;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$month  $year",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    cellCalendarPageController.animateToDate(
                      DateTime.now(),
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 300),
                    );
                  },
                )
              ],
            ),
          );
        },
        onCellTapped: (date) {
          final eventsOnTheDate = _sampleEvents.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
          }).toList();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title:
                Text(date.month.monthName + " " + date.day.toString()),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: eventsOnTheDate
                      .map(
                        (event) => Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(bottom: 12),
                      color: event.eventBackgroundColor,
                      child: Text(
                        event.eventName,
                        style: TextStyle(color: event.eventTextColor),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ));
        },
        onPageChanged: (firstDate, lastDate) {
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ),
    );
  }
}

