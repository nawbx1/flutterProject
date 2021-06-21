import 'dart:convert';

import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Region.dart';
import 'package:doctor_pro/pages/artisan/drawer_1.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doctor_pro/ui/rendez_vous/ArtisanProfile_Page.dart';
import 'package:doctor_pro/bloc/RegionBloc.dart';
import 'package:doctor_pro/ui/rendez_vous/ArtisanCalendar_Page.dart';
import 'package:http/http.dart' as http;
class ArtisanList extends StatefulWidget {
  final String speciality;
  final int gouvernoratId ;

  const ArtisanList({Key key, @required this.speciality,@required this.gouvernoratId}) : super(key: key);

  @override
  _ArtisanListState createState() => _ArtisanListState();
}

class _ArtisanListState extends State<ArtisanList> {

  RegionBloc regionBloc=new RegionBloc();
  final String Url = apiUrl+"user-service/user/all";

  List<dynamic> ArtisanList=[];

  //List<Region> labels = [];
  int currentIndex = 0;

  List<Region> regions ;

  getRegions()async{
    print("getRegions");
    print(widget.gouvernoratId);
    print("getRegions 2222222222");
    regions = await regionBloc.fetchRegionByGouvernoartId(widget.gouvernoratId);
      setState(() {
        regions;
      });

  }
  void fetchUserBySpeciality(String region) async {

    var result = await http.get(Uri.parse(Url));//algo de recommandation
    if(result.statusCode==200){
      setState(() {
        ArtisanList= json.decode(result.body);
      });
    }
  }

  @override
  void initState(){
    super.initState();
    getRegions();
    print("list region after");
    print(regions);
    //fetchUserBySpeciality() ;//algo
    /*labels.add('Tous');
    for(int i=0;i<regions.length;i++)
      labels.add(regions[i].region.toString());*/
  }
  @override
  Widget build(BuildContext context) {
    drawer: Drawer1().build(context);
    iconTheme: IconThemeData(color: blackColor);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Hero(
        tag: widget.speciality,
        child: Scaffold(
          drawer: Drawer1().build(context),
          backgroundColor: whiteColor,

          appBar: AppBar(
            iconTheme: IconThemeData(color: blackColor),
            backgroundColor: whiteColor,
            titleSpacing: 0.0,
            elevation: 0.0,
            title: Text(
              widget.speciality,
              style: appBarTitleTextStyle,
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
                      hintText: 'Chercher ${widget.speciality}',
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
          body:Column(
              children: <Widget>[
                Stack(
                    children: [
                      Container(
                        height: (height * 0.15),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: (height * 0.15) - 50.0,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: regions.length,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = regions[index];
                                  return InkWell(
                                    onTap: () {
                                      fetchUserBySpeciality(item.region);

                                    },
                                    child: Padding(
                                      padding: (index == regions.length - 1)
                                          ? EdgeInsets.symmetric(horizontal: 5.0)
                                          : EdgeInsets.only(left: 5.0),
                                      child: Container(
                                        //height: (height * 0.15) - 50.0,
                                        //width: (height * 0.15) - 50.0,
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(0.07),
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(
                                                width: 0.7, color: primaryColor),
                                          ),
                                          child: Text(
                                            item.region,
                                            style: primaryColorNormalBoldTextStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),

                Expanded( child:
                ListView.builder(
                  itemCount: ArtisanList.length,
                  itemBuilder: (context, index) {
                    final item = ArtisanList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (ArtisanList!=null)?
                        Container(
                          padding: EdgeInsets.all(fixPadding * 2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(50.0),
                                      border:
                                      Border.all(width: 0.3, color: primaryColor),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0,
                                          color: Colors.grey[300],
                                        ),
                                      ],

                                    ),
                                  ),
                                  widthSpace,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' ${item['username']}',
                                          style: blackNormalBoldTextStyle,
                                        ),
                                        SizedBox(height: 7.0),
                                        Text(
                                          widget.speciality,
                                          style: greyNormalTextStyle,
                                        ),
                                        SizedBox(height: 7.0),
                                        Text(
                                          '${item['username']}  ans  d\'Experience',
                                          style: primaryColorNormalTextStyle,
                                        ),
                                        SizedBox(height: 7.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.lime, size: 20.0),
                                            SizedBox(width: 5.0),
                                            Text(
                                              item['username'],
                                              style: blackNormalTextStyle,
                                            ),
                                            widthSpace,
                                            widthSpace,
                                            Icon(Icons.rate_review,
                                                color: Colors.grey, size: 20.0),
                                            SizedBox(width: 5.0),
                                            Text(
                                              '${item['username']} Reviews',
                                              style: blackNormalTextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              heightSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(milliseconds: 600),
                                          type: PageTransitionType.fade,
                                          child:
                                          ArtisanProfilePage (
                                            artisanImage: item['username'],
                                            artisanName: item['username'],
                                            artisanType: widget.speciality,
                                            experience: item['username'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: (width - fixPadding * 6 + 1.4) / 2.0,
                                      padding: EdgeInsets.all(fixPadding),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.07),
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(
                                            width: 0.7, color: Colors.orange),
                                      ),
                                      child: Text(
                                        'Voir profil',
                                        style: orangeButtonBoldTextStyle,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(milliseconds: 600),
                                          type: PageTransitionType.fade,
                                          child: ArtisanCalendar(
                                            artisanImage: item['username'],
                                            artisanName: item['username'],
                                            artisanType: widget.speciality,
                                            experience: item['username'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: (width - fixPadding * 6 + 1.4) / 2.0,
                                      padding: EdgeInsets.all(fixPadding),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.07),
                                        borderRadius: BorderRadius.circular(8.0),
                                        border:
                                        Border.all(width: 0.7, color: primaryColor),
                                      ),
                                      child: Text(
                                        'Rendez-vous ',
                                        style: primaryColorsmallBoldTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                            :
                        Container(),
                        divider(),
                      ],
                    );
                  },
                ),
                )
              ]
          ),
        ));
  }

  divider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      height: 0.8,
      color: greyColor.withOpacity(0.3),
    );
  }
}
