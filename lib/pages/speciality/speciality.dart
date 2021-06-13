import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/pages/doctor/TypeDintervention.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;


class Speciality extends StatefulWidget {
  @override
  _SpecialityState createState() => _SpecialityState();


}

class _SpecialityState extends State<Speciality> {
  List<dynamic> specialityList=[];


  void fetchSpeciality() async {

    var result = await http.get(Uri.parse(apiUrl+'user-service/speciality/all'),headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});

    if(result.statusCode==200){
      setState(() {
        specialityList= json.decode(result.body);
      });
    }
  }
   @override
  void initState(){
    super.initState();
    fetchSpeciality() ;
    print(specialityList);
  }
  @override

  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'spécialité',
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: Container(
            color: whiteColor,
            height: 65.0,
            padding: EdgeInsets.only(
              left: fixPadding * 2.0,
              right: fixPadding * 2.0,
              top: fixPadding,
              bottom: fixPadding,
            ),
            alignment: Alignment.center,
            child: Container(
              height: 55.0,
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8.0),
                border:
                Border.all(width: 1.0, color: greyColor.withOpacity(0.6)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Recherche par  specialities',
                  hintStyle: greyNormalTextStyle,
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                      top: fixPadding * 0.78, bottom: fixPadding * 0.78),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(fixPadding),
        child: GridView.builder(
          itemCount: specialityList.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            final item = specialityList[index];
            return Padding(
              padding: EdgeInsets.all(fixPadding),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 800),
                      type: PageTransitionType.fade,
                      child: TypeDintervention(
                        interventions: item['interventionTypes'],
                        speciality : item['name'],
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: item['name'],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 1.0,
                            spreadRadius: 1.5,
                            color: Colors.grey[300]),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Container(
                            width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23.0),
                          image: DecorationImage(
                            image: NetworkImage(apiUrl+'user-service/uploads/specialities/'+item['media']['fileName']),
                            fit: BoxFit.cover,
                          ),
                        ),

                        ),
                        SizedBox(height: 10.0),
                        Text(
                          item['name'],
                          style: blackNormalBoldTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
