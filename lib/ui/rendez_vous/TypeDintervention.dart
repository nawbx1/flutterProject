import 'dart:convert';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/ui/rendez_vous/Gouvernorat_Page.dart';

import 'package:doctor_pro/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

import '../../pages/artisan/drawer_1.dart';


class TypeDintervention extends StatefulWidget {
  final List<InterventionType> interventions ;
  final String speciality  ;
  const TypeDintervention({Key key, @required this.interventions,@required this.speciality }) : super(key: key);
  @override
  _TypeDinterventionState createState() => _TypeDinterventionState();
}
class _TypeDinterventionState extends State<TypeDintervention> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer1().build(context),
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
         widget.speciality ,
          style: appBarTitleTextStyle,
        ),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: blackColor,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
              child:
              TextField(
                decoration: InputDecoration(
                  hintText: 'Choisir une ville ',
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
        color: Colors.white ,
        padding: EdgeInsets.all(fixPadding),
        child: GridView.builder(

          itemCount: widget.interventions.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            final item = widget.interventions[index];
            return Padding(
              padding: EdgeInsets.all(fixPadding),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 800),
                      type: PageTransitionType.fade,
                      child: GouvernoratPage(
                        speciality: widget.speciality ,
                        intervention: item.name
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: item.name,
                  child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(17.0),

                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 1.0,
                            spreadRadius: 1.5,
                            color: primaryColor),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 75,
                        //   height: 75,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(23.0),
                        //     image: DecorationImage(
                        //       image: NetworkImage(apiUrl+'user-service/uploads/specialities/'+item['media']['fileName']),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        //
                        // ),
                        // SizedBox(height: 10.0),
                        Text(
                        item.name,
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
