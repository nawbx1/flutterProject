import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:doctor_pro/bloc/TokenStorageBloc.dart';
import 'package:doctor_pro/bloc/UserBloc.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/model/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String name;
  final int targetId;

  const ChatScreen({Key key, @required this.name, @required this.targetId})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();
  DateTime now = DateTime.now();
  ScrollController _scrollController = new ScrollController();
  String amPm;

/*  final chatData = [
    {
      'role': 'me',
      'msg': 'I\'m feeling sick for 2 days.',
      'time': '9:38 AM',
      'read': 'unread'
    },
    {
      'role': 'sender',
      'msg': 'How can i help you?',
      'time': '9:37 AM',
      'read': 'read'
    },
    {'role': 'sender', 'msg': 'Hello', 'time': '9:36 AM', 'read': 'read'},
    {'role': 'me', 'msg': 'Hello Doctor', 'time': '9:35 AM', 'read': 'read'},
  ];*/
  List<dynamic> chatData;

  int id;

  conversation() async {
    id = await TokenStorageBloc.getStoredUserId();
    setState(() {
      id;
    });
    Response response = await http.get(
        Uri.parse('http://192.168.1.13:8081/msg/convertation/7' + '/' +
            widget.targetId.toString()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        });


    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));

    String source = Utf8Decoder().convert(response.bodyBytes);
    var chatData2 = json.decode(source.toString());
    setState(() {
      chatData = chatData2;
      print('message os');
      print(chatData);
    });
  }

  dynamic chatRoom;

  chatroom() async {
    id = await TokenStorageBloc.getStoredUserId();
    setState(() {
      id;
    });
    Response response = await http.get(
        Uri.parse('http://192.168.1.13:8081/msg/room/7' + '/' +
            widget.targetId.toString()),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
        });


    //User u = json.decode(result.body).map((tagJson) => User.fromJson(tagJson));

    String source = Utf8Decoder().convert(response.bodyBytes);
    var chatData2 = json.decode(source.toString());
    setState(() {
      chatRoom = chatData2;
      print('message os');
      print(chatRoom);
    });
  }

  UserBloc userBloc = new UserBloc();
  dynamic owner = {
    "id": 7,
    "keycloak": "6b3659f9-1306-4c37-821e-0ba621e2942c",
    "username": "pb@bh.js",
    "password": null,
    "email": "pb@bh.js",
    "phone": 53518927,
    "cin": 12345678,
    "name": null,
    "verified": true,
    "matriculeFiscale": "123MJH789LMO",
    "speciality": [],
    "address": {
      "id": 9,
      "region": {
        "id": 151,
        "gouvernorat": {"id": 15, "name": "MONASTIR"},
        "region": "Teboulba"
      },
      "street": "lkefnleskfn",
      "zipCode": 0,
      "longitude": null,
      "lattitude": null
    },
    "role": [{"id": 3, "name": "PROFESSIONNEL"}],
    "profile": {
      "id": 8,
      "profileImage": null,
      "coverImage": null,
      "regions": [],
      "experiences": [],
      "information": "je suis creatif et serieux",
      "competences": [
        {
          "id": 47,
          "interventionType": {
            "id": 2,
            "name": "Réparation de chasse d'eau - WC simple"
          },
          "position": 1
        },
        {
          "id": 48,
          "interventionType": {"id": 4, "name": "Fuite de gaz"},
          "position": 2
        }
      ]
    },
    "otp": 50315
  };

  dosent() {
    var msg = {
      'id':null,
    'owner': null,
    'message': msgController.text,
    'date': DateTime.now(),
    'sender': 7,
    'reciever':widget.targetId,
    'chatRoom': {
    "id": 1,
    "room": "room1"
    }};


    http.post(Uri.parse('http://192.168.1.13:8081/msg/sendmessage'),
        body: json.encode(msg.toString()),
        headers: {'Content-Type': 'application/json'});
    print('fffff-1');
    print(chatData.length);
    chatData.insert(0, {
      'owner': owner,
      'message': msgController.text,
      'date': DateTime.now(),
      'sender': id,
      'reciever': widget.targetId,
      'chatRoom': {
        "id": 1,
        "room": "room1"
      },
    });
    setState(() {
      print('fffff0');
      print(chatData.length);
      chatData;
      print('fffff1');
      print(chatData.length);
    });
  }

    /* getowner()async{

    for(dynamic i in chatData){
      if(i['owner']['id']=='7')
        owner=i['owner'];
    }

    // var rep = await http.get(Uri.parse(apiUrl+'user-service/user/keycloak?keycloak=6b3659f9-1306-4c37-821e-0ba621e2942c'),
    // headers: {HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"});
    // print(rep.toString());
    // String source = Utf8Decoder().convert(rep.bodyBytes);
    // owner = jsonDecode(rep.toString());
setState(() {
  owner;
  print('uyuyuy');
  print(owner);
   });
  }*/@override
    void initState() {
    super.initState();
    conversation();
    chatroom();
    //getowner();

    _scrollToBottom();
    }

    void _scrollToBottom() {
    if (_scrollController.hasClients) {
    _scrollController.animateTo(0.0,
    duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
    Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
    }

    @override
    Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
    child: Scaffold(
    backgroundColor: whiteColor,
    appBar: AppBar(
    backgroundColor: whiteColor,
    centerTitle: true,
    elevation: 1.0,
    title: Text(
    ' ${widget.name}',
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
    ),
    body: (chatData ==null || chatData.length == 0)
    ? Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Icon(
    Icons.chat,
    color: greyColor,
    size: 70.0,
    ),
    heightSpace,
    Text(
    'No Messages',
    style: greyNormalTextStyle,
    ),
    ],
    ),
    )
        : Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Expanded(
    child: ListView.builder(
    controller: _scrollController,
    itemCount: chatData.length,
    physics: BouncingScrollPhysics(),
    reverse: true,
    itemBuilder: (context, index) {
    final item = chatData[index];
    return Container(
    width: width,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: (item['owner']['id'].toString()== widget.targetId.toString())
    ? CrossAxisAlignment.start
        : CrossAxisAlignment.end,
    children: <Widget>[
    Wrap(
    children: <Widget>[
    Padding(
    padding: (item['owner']['id'].toString()== widget.targetId.toString())
    ? EdgeInsets.only(right: 100.0)
        : EdgeInsets.only(left: 100.0),
    child: Column(
    mainAxisAlignment:
    MainAxisAlignment.start,
    crossAxisAlignment:
    (item['owner']['id'].toString()== widget.targetId.toString())
    ? CrossAxisAlignment.start
        : CrossAxisAlignment.end,
    children: <Widget>[
    Container(
    padding: EdgeInsets.all(fixPadding),
    margin: EdgeInsets.symmetric(
    horizontal: fixPadding),
    decoration: BoxDecoration(
    borderRadius: (item['owner']['id'].toString()== widget.targetId.toString())
    ? BorderRadius.only(
    topLeft:
    Radius.circular(5.0),
    topRight:
    Radius.circular(5.0),
    bottomLeft:
    Radius.circular(0.0),
    bottomRight:
    Radius.circular(5.0),
    )
        : BorderRadius.only(
    topLeft:
    Radius.circular(5.0),
    topRight:
    Radius.circular(5.0),
    bottomLeft:
    Radius.circular(5.0),
    bottomRight:
    Radius.circular(0.0),
    ),
    color: (item['owner']['id'].toString()== widget.targetId.toString())
    ? Colors.grey[300]
        : primaryColor,
    ),
    child: Text(
    item['message'],
    style: (item['owner']['id'].toString()== widget.targetId.toString())
    ? blackNormalTextStyle
        : whiteColorNormalTextStyle,
    ),
    ),
    Padding(
    padding: EdgeInsets.all(10.0),
    child: Row(
    mainAxisAlignment:
    (item['owner']['id'].toString()== widget.targetId.toString())
    ? MainAxisAlignment.start
        : MainAxisAlignment.end,
    crossAxisAlignment:
    CrossAxisAlignment.center,
    children: <Widget>[
    (item['owner']['id'].toString()== widget.targetId.toString())
    ? Container()
        : Icon(
    (item['status'] == null)
    ? Icons.done_all
        : Icons.check,
    color: Colors.blueAccent,
    size: 14.0,
    ),
    SizedBox(
    width: 7.0,
    ),
    Text(
    item['date'].toString(),
    style: greySmallTextStyle,
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ],
    ),
    );
    },
    ),
    ),
    Container(
    width: width,
    height: 70.0,
    padding: EdgeInsets.all(10.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Expanded(
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: primaryColor,
    ),
    child: TextField(
    controller: msgController,
    style: TextStyle(
    fontSize: 13.0,
    color: Colors.white,
    ),
    cursorColor: whiteColor,
    decoration: InputDecoration(
    hintText: 'Type a Message',
    hintStyle: whiteColorSmallTextStyle,
    contentPadding: EdgeInsets.only(left: 10.0),
    border: InputBorder.none,
    ),
    ),
    ),
    ),
    SizedBox(width: 10.0),
    InkWell(
    borderRadius: BorderRadius.circular(20.0),
    onTap: () {
    dosent();
    if (msgController.text != '') {
    if (now.hour > 11) {
    amPm = 'PM';
    } else {
    amPm = 'AM';
    }
    setState(() {

    msgController.text = '';
    _scrollController.animateTo(
    0.0,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 300),
    );
    });
    }
    },
    child: Container(
    width: 40.0,
    height: 40.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: greyColor.withOpacity(0.40),
    ),
    child: Icon(
    Icons.send,
    color: primaryColor,
    size: 18.0,
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
    }
  }
