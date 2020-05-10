import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englcenterapp/widgets/receivedmessagewidget.dart';
import 'package:englcenterapp/widgets/sentmessagewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../providers/auth.dart';



class ChatScreen extends StatefulWidget {
  // final FirebaseUser user;
  static const routeName = '/chat_creen';
  final String userName;

  const ChatScreen({Key key, this.userName}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Firestore _firestore = Firestore.instance;

  _ChatScreenState() {
    _firestore.settings(persistenceEnabled: false);
  }
  
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    print('usernName');
    print(widget.userName);
    if (messageController.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': widget.userName,
        'classId': '01',
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<Auth>(context);
    // userName = auth.userName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhận xét của giáo viên')
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .where("classId", isEqualTo: '01')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {

                  if(snapshot.hasData) {
                        
                        return _buildItem(snapshot);
                      } else if (snapshot.hasError) {
                        return _buildWithError(snapshot.error);
                      } else {
                        return _buildLoading();
                      }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],),
              child: 
              Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.face), onPressed: () {}),
                              Expanded(
                                child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                        hintText: "Enter a Message...",
                        border: InputBorder.none,
                      ),
                      controller: messageController,
                    ),
                              ),SendButton(
                    text: "Send",
                    callback: callback,
                  )
                            ],
                          ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: TextField(
              //         onSubmitted: (value) => callback(),
              //         decoration: InputDecoration(
              //           hintText: "Enter a Message...",
              //           border: const OutlineInputBorder(),
              //         ),
              //         controller: messageController,
              //       ),
              //     ),
              //     SendButton(
              //       text: "Send",
              //       callback: callback,
              //     )
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _buildItem(AsyncSnapshot snapshot) {
    List<DocumentSnapshot> docs = snapshot.data.documents;
                  
                  List<Widget> messages = docs
                      .map((doc) => Message(
                            from: doc.data['from'],
                            text: doc.data['text'],
                            me: widget.userName == doc.data['from'],  
                            time: DateTime.parse(doc.data['date'].toString())
                          ))
                      .toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
  }

  Widget _buildWithError(String error) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Error occured: $error")),
      ],
    ));
  }
}
  

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.transparent)),
      color: Colors.orange,
      onPressed: callback,
      child: Text(text),
    );
  }
}

class Message extends StatelessWidget {
  
  final String from;
  final String text;
  final DateTime time;

  final bool me;

  const Message({Key key, this.from, this.text, this.me, this.time}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          me ? SentMessageWidget(userName: from, content: text) 
          : ReceivedMessagesWidget(userName: from, content: text)
          // Text(
          //   from == null ? '' : from,
          // ),
          // Material(
          //   color: me ? Colors.teal : Colors.red,
          //   borderRadius: BorderRadius.circular(10.0),
          //   elevation: 6.0,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          //     child: Text(
          //       text,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }


}