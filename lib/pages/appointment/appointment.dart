import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctor_pro/constant/constant.dart';
import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final String Url = apiUrl+"rendez-vous-service/rdv/all";

  List<dynamic> RDVList=[];
  List<dynamic> enattentelist=[];

  List<String> labels = [];
  int currentIndex = 0;

  void fetchRDV() async {

    var result = await http.get(Uri.parse(Url));
    if(result.statusCode==200){
      setState(() {
        RDVList= json.decode(result.body);
        RDVList.forEach((element) =>{
          print(element),
          if (element['status'].toString()=='en_attente')
            enattentelist.add(element)
        });
      });
    }
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
    return DefaultTabController(
      length: 3,
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
            // isScrollable: true,
            tabs: [

              Tab(
                child: tabItem('en attente ', enattentelist.length),
              ),
              Tab(
                child: tabItem(' accepté', RDVList.length),
              ),
              Tab(
                child: tabItem('terminé', RDVList.length),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            activeAppointment(),
            pastAppointment(),
            cancelledAppointment(),
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

  activeAppointment() {
    return (enattentelist.length == 0)
        ? Center(
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
        : ListView.builder(
            itemCount: enattentelist.length,
            itemBuilder: (context, index) {
              final item = enattentelist[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: Colors.green),
                            color: Colors.green[50],
                          ),
                          child: Text(
                            item['date'],
                            textAlign: TextAlign.center,
                            style: greenColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item['startDate'],
                                    style: blackHeadingTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () => deleteAppointmentDialog(index),
                                    child: Icon(
                                      Icons.close,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                '${item['client']['username']}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                '${item['client']['phone']}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
  }

  pastAppointment() {
    return (RDVList.length == 0)
        ? Center(
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
        : ListView.builder(
            itemCount: RDVList.length,
            itemBuilder: (context, index) {
              final item = RDVList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: primaryColor),
                            color: primaryColor.withOpacity(0.15),
                          ),
                          child: Text(
                            item['date'],
                            textAlign: TextAlign.center,
                            style: primaryColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['time'],
                                style: blackHeadingTextStyle,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                'Dr. ${item['doctorName']}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                '${item['doctorType']}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
  }

  cancelledAppointment() {
    return (RDVList.length == 0)
        ? Center(
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
        : ListView.builder(
            itemCount: RDVList.length,
            itemBuilder: (context, index) {
              final item = RDVList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: Colors.red),
                            color: Colors.red[50],
                          ),
                          child: Text(
                            item['date'],
                            textAlign: TextAlign.center,
                            style: redColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['time'],
                                style: blackHeadingTextStyle,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                'Dr. ${item['doctorName']}',
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                '${item['doctorType']}',
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }
}
