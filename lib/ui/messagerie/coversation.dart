import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// use this if you are using emulator. localhost is mapped to 10.0.2.2 by default.
final socketUrl = 'http://196.168.1.13:8081/gkz-stomp-endpoint';//http://localhost:8081/gkz-stomp-endpoint


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StompClient stompClient;

  String message = '';

  void onConnect(StompClient client, StompFrame frame) {
    client.subscribe(
        destination: '/user/7'+'/queue/messages',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> result = json.decode(frame.body);
            //print(result['message']);
            setState(() => message = result['message']);
          }
        });
  }

  @override
  void initState() {
    super.initState();

    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.SockJS(
            url: socketUrl,
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString()),
          ));

      stompClient.activate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your message from server:',
            ),
            Text(
              '$message',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    if (stompClient != null) {
      stompClient.deactivate();
    }

    super.dispose();
  }
}