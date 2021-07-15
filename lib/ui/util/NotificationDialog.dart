





import 'package:doctor_pro/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  NotificationDialog extends StatefulWidget {


  final String title,body,status;
  const NotificationDialog(

        @required this.title,
        @required this.body,
        @required this.status,

      )
      : super();
  @override
  _State createState() => _State();
}

class _State extends State<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return successOrderDialog(context,widget.title,widget.body,widget.status );
  }
}



successOrderDialog(BuildContext context, String headerTitle,String bodyMessage,String status) {

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Dialog(
        elevation: 0.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 170.0,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                height: 70.0,
                width: 70.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  border: Border.all(color: primaryColor, width: 1.0),
                ),
                child: Icon(
                  Icons.check,
                  size: 40.0,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                headerTitle ,
                style: greySmallBoldTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                bodyMessage,
                style: greyVerySmallBoldTextStyle,
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      );
    },
  );
}

