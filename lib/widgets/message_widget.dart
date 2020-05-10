import 'package:englcenterapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _firebaseMessaging.configure(
  //       onMessage: (Map<String, dynamic> message) async {
  //     print("onMessage: $message");
  //     final notification = message['notification'];
  //     setState(() {
  //       messages.add(Message(
  //         title: notification['title'], body: notification['body']
  //       ));
  //     });
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print("onLauch: $message");
  //   }, onResume: (Map<String, dynamic> message) async {
  //     print("onResume: $message");
  //   });
  // }
  
   @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        // setState(() {
        //   messages.add(Message(
        //     title: '${notification['title']}',
        //     body: '${notification['body']}',
        //   ));
        // });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        final notification = message['data'];
        // setState(() {
        //   messages.add(Message(
        //     title: '${notification['title']}',
        //     body: '${notification['body']}',
        //   ));
        // });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  
  }

  @override
  Widget build(BuildContext context) {
    print(messages);
    print('messages');
    print(messages.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Message')
      ),
      body: ListView(
      children: messages.map(buildMessage).toList(),
    ),
    );
  }

   Widget buildMessage(Message message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}
