import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Speciality.dart';
import 'package:doctor_pro/pages/artisan/drawer_1.dart';
import 'package:doctor_pro/ui/rendez_vous/TypeDintervention.dart';
import 'package:doctor_pro/ui/util/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SpecialityPage extends StatefulWidget {
  @override
  _SpecialityPageState createState() => _SpecialityPageState();
}

class _SpecialityPageState extends State<SpecialityPage> {
  List<Speciality> specialityList = [];
  UserBloc userBloc = new UserBloc();

  void fetchSpeciality() async {
    List<Speciality> specialityList2 = await userBloc.fetchSpeciality();

    setState(() {
      specialityList = specialityList2;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSpeciality();
    print(specialityList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu().build(context),
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: blackColor),
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'spécialité',
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
                        interventions: item.interventionTypes,
                        speciality: item.name,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: item.name,
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
                        Expanded(
                          child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            image: DecorationImage(
                              image:
                              NetworkImage(
                                item.media != null ?
                                apiUrl +
                                    'user-service/uploads/specialities/' +
                                    item.media.fileName :apiUrl + 'user-service/uploads/image-not-available.jpg',
                              ),
                              onError: (exception, stackTrace) => Image(
                                  image: NetworkImage(
                                apiUrl + 'user-service/uploads/avatar.jpg',
                              )

                              ),

                              fit: BoxFit.cover,
                            ),
                          ),
                          ),

                        ),
                        SizedBox(height: 10.0),
                        SizedBox(height: 10.0),
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
