
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/Competence.dart';
import 'package:doctor_pro/model/DraggableList.dart';
import 'package:doctor_pro/model/InterventionType.dart';
import 'package:doctor_pro/model/Speciality.dart';
import 'package:doctor_pro/model/User.dart';

import 'package:doctor_pro/pages/profile/Setting1.dart';
import 'package:doctor_pro/ui/setting/profile_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class CompetanceList extends StatefulWidget {
  User user ;
  CompetanceList({Key key , @required this.user }) : super(key: key);

  @override
  CompetanceListState createState() => CompetanceListState();
}

class CompetanceListState extends State<CompetanceList> {

   List<DragAndDropList> lists=[];
   UserBloc userBloc =new UserBloc();
   List<DraggableList> allLists =[];
   DraggableList drag=new DraggableList();
   User user =new User();
   List<InterventionType>listFinal = [] ;
   bool loading = true ;
   initCurrentUser() async{
     user=await userBloc.getUserByKeycloak();
     initListIntervention();
   }
   void  fetchInterventionsBySpecialityName()async{
     List<InterventionType>list = [] ;
     await widget.user.speciality.forEach((element) async {
       list =   await userBloc.fetchInterventionsBySpecialityName(element.name) ;
       await list.forEach((e) async{
         await listFinal.add(e);
         setState(() {
           listFinal;
         });
       });

     });

   }


   initListIntervention() async {

     await fetchInterventionsBySpecialityName() ;
     Future.delayed(const Duration(milliseconds: 500), () {

       print("list") ;
       print(listFinal) ;



    if(listFinal!=null){
      setState(() {
        loading=false ;
      });
      print("listtttt after IF") ;
      print(listFinal) ;


      drag.header="Disponible";
      drag.items=listFinal;
      allLists.add(drag);
      drag=new DraggableList();
      drag.header="choix";
      if(user!=null&&user.profile!=null&&user.profile.competences!=null)
        user.profile.competences.map((e) => drag.items.add(e.interventionType)) ;
      drag.items=[];
      allLists.add(drag);
      setState(() {
        allLists;
      });
      lists = allLists.map(buildList).toList();

    }
     });
   }
  @override
  void initState() {
    super.initState();
    initCurrentUser();

  }

  updateCompetence()async{
    List<Competence>listComptence =[];
    allLists.forEach((element) {
      print(element.toString());
      element.items.forEach((i) {
        listComptence.add(new Competence.name(i));
      });
    });

    print(listComptence);
    User user = await  userBloc.updateCompetence(listComptence, widget.user.id.toString());
    (user!=null)?
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 600),
            child: ProfileSetting()
        ))
        :print(user);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor : color : Colors,
        appBar: AppBar(
        title: Text('Competences'),
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
              updateCompetence();
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
     body:  (loading==false) ?

     DragAndDropLists(
        // lastItemTargetHeight: 50,
        // addLastItemTargetHeightToTop: true,
        // lastListTargetSize: 30,
        listPadding: EdgeInsets.all(16),
        listInnerDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        children: lists,
        itemDivider: Divider(thickness: 2, height: 2, color: Colors.black12),
        itemDecorationWhileDragging: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        listDragHandle: buildDragHandle(isList: true),
        itemDragHandle: buildDragHandle(),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
     )
         :Container(),
      );
  }


  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
    header: Container(
      padding: EdgeInsets.all(8),
      child: Text(
        list.header,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    children:  list.items
        .map((item) => DragAndDropItem(
      child:  Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: ListTile (

          leading: Image.network(
            (widget.user.speciality!=null)?
            apiUrl+'user-service/uploads/specialities/'+widget.user.speciality[0].media.fileName:"",
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          title: Text(item.name),

        ) ,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.015, 0.015],
            colors: [Colors.deepPurpleAccent, Colors.white],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
      )



    )
    )
        .toList(),
  );

  void onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
      )
  {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
      int oldListIndex,
      int newListIndex,
      ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }

}

