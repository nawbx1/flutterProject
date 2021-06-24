import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:doctor_pro/ui/util/SideMenu.dart';
import 'package:flutter/material.dart';

class ExperiencePage extends StatefulWidget {
  User user ;
  ExperiencePage({Key key , @required this.user }) : super(key: key);

  @override
  _ExperienceState createState() => _ExperienceState();
}

  TextEditingController titleController=new TextEditingController();
  TextEditingController DescriptionController=new TextEditingController();

  updateExprience(){
    print('updateExprience');


  }
class _ExperienceState extends State<ExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor : color : Colors,
      appBar: AppBar(
        title: Text('Experience'),
        centerTitle: true,
      ),
      bottomNavigationBar:
      Material(
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
              updateExprience();
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
                'Enregistrer',
                style: whiteColorButtonTextStyle,
              ),
            ),
          ),
        ),
      ),
      body:
          Column(
              children: [
                Container(
                  padding:  EdgeInsets.fromLTRB(30, 30, 10,30),
                  child:
                    TextField(
                      onChanged: (value) {

                      },
                      controller: titleController,
                      textInputAction: TextInputAction.next,

                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Titre"),
                    ),

                ),
                //SizedBox(height: 10),
                Container(
                  padding:  EdgeInsets.fromLTRB(30, 30, 10,30),
                  child:  TextField(
                    onChanged: (value) {

                    },
                    maxLines: 8,
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Description"),
                  ),

                ),



              ],
              )


    );
  }
}
