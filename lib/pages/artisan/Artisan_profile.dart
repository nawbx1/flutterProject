import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doctor_pro/pages/screens.dart';

import 'drawer_1.dart';

class artisanProfile extends StatefulWidget {
  final String artisanImage, artisanName, artisanType, experience;

  const artisanProfile(
      {Key key,
      @required this.artisanImage,
      @required this.artisanName,
      @required this.artisanType,
      @required this.experience})
      : super(key: key);
  @override
  _artisanProfileState createState() => _artisanProfileState();
}

class _artisanProfileState extends State<artisanProfile> {
  Set<Marker> markers;

  final ratingList = [
    {
      'name': 'amine aamaar ',
      'image': 'assets/user/user_1.jpg',
      'rating': 5,
      'review': 'yaatik saahha  .',
      'time': 'August 2022'
    },
    {
      'name': 'mohamed salah ',
      'image': 'assets/user/user_2.jpg',
      'rating': 5,
      'review': 'merci mohamed ',
      'time': 'August 2020'
    },
    {
      'name': 'walid aarbi ',
      'image': 'assets/user/user_3.jpg',
      'rating': 1,
      'review': 'maa3ejbetnich l 5edma ',
      'time': 'July 2020'
    },
    {
      'name': 'Med ali weslati',
      'image': 'assets/user/user_4.jpg',
      'rating': 5,
      'review': '3awentni barcha aycheek ',
      'time': 'June 2020'
    },
    {
      'name': 'lina temani ',
      'image': 'assets/user/user_5.jpg',
      'rating': 5,
      'review': 'aychek ',
      'time': 'May 2020'
    },
    {
      'name': 'fida messadi ',
      'image': 'assets/user/user_6.jpg',
      'rating': 5,
      'review': 'nchalleh nes l kol kifek .',
      'time': 'April 2020'
    },

  ];

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer1().build(context),
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: whiteColor,
        //   ),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: Stack(
        children: [
          Container(
            height: (height * 0.36),
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: (width - fixPadding * 11.0) / 2.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.artisanName,
                        style: whiteColorHeadingTextStyle,
                      ),
                      heightSpace,
                      Text(
                        widget.artisanType,
                        style: whiteColorSmallTextStyle,
                      ),
                      heightSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.lime, size: 20.0),
                          SizedBox(width: 5.0),
                          Text(
                            '4.5 Rating',
                            style: whiteColorNormalTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: widget.artisanImage,
                  child: Image.asset(
                    widget.artisanImage,
                    width: (width) / 2.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 1.0,
            builder: (BuildContext context, myscrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                child: Container(
                  color: whiteColor,
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: ListView(
                    controller: myscrollController,
                    children: [
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        style: greyNormalTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                      heightSpace,
                      heightSpace,
                      experience(),
                      heightSpace,
                      heightSpace,
                      availability(),
                      heightSpace,
                      heightSpace,
                      location(),
                      heightSpace,
                      heightSpace,
                      review(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  experience() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Text(
          '${widget.experience} Years',
          style: greyNormalTextStyle,
        ),
      ],
    );
  }

  availability() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Text(
          '8:00 AM - 10:30 PM',
          style: greyNormalTextStyle,
        ),
      ],
    );
  }

  location() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Container(
          width: double.infinity,
          height: 250.0,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 1.0,
                spreadRadius: 1.0,
                color: Colors.grey[300],
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: GoogleMap(
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                Marker m = Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(51.361005, -0.1746394));
                setState(() {
                  markers.add(m);
                });
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(51.361005, -0.1746394), zoom: 8),
            ),
          ),
        ),
      ],
    );
  }

  review() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        ColumnBuilder(
          itemCount: 3,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          itemBuilder: (context, index) {
            final item = ratingList[index];
            return Container(
              margin: (index == 0)
                  ? EdgeInsets.symmetric(horizontal: 2.0)
                  : EdgeInsets.only(
                      top: fixPadding * 2.0, right: 2.0, left: 2.0),
              padding: EdgeInsets.all(fixPadding * 2.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          image: DecorationImage(
                            image: AssetImage(item['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: blackNormalBoldTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              item['time'],
                              style: greySmallTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            ratingBar(item['rating']),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightSpace,
                  Text(
                    item['review'],
                    style: blackNormalTextStyle,
                  ),
                ],
              ),
            );
          },
        ),
        heightSpace,
        heightSpace,
        InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 600),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: Review(
                      reviewList: ratingList,
                    )));
          },
          child: Container(
            padding: EdgeInsets.all(fixPadding * 1.5),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1.0, color: primaryColor),
            ),
            child: Text(
              'Voir tous ',
              style: primaryColorsmallBoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  ratingBar(number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1 Star
        Icon(
          (number == 1 ||
                  number == 2 ||
                  number == 3 ||
                  number == 4 ||
                  number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 2 Star
        Icon(
          (number == 2 || number == 3 || number == 4 || number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 3 Star
        Icon(
          (number == 3 || number == 4 || number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 4 Star
        Icon(
          (number == 4 || number == 5) ? Icons.star : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 5 Star
        Icon(
          (number == 5) ? Icons.star : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),
      ],
    );
  }
}
