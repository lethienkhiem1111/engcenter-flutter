import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englcenterapp/models/contact.dart';
import 'package:englcenterapp/models/contact_response.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:englcenterapp/widgets/receivedmessagewidget.dart';
import 'package:englcenterapp/widgets/sentmessagewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../../providers/contact_provider.dart';



class ContactScreen extends StatefulWidget {
  // final FirebaseUser user;
  static const routeName = '/contact_creen';


  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ClassScreenArgument args;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<Auth>(context);
    // userName = auth.userName;
    args = ModalRoute.of(context).settings.arguments;
    final contacts = Provider.of<ContactProvider>(context);
    contacts.getContactOfClass(args.idHocVien, args.idLop);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sổ  liên lạc')
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<ContactResponse>(
                stream: contacts.subject.stream,
                builder: (context, snapshot) {
                  List<Contact> _temContact = [];
                  if (snapshot.hasData) {
                    if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                      return _contactIsEmpty(snapshot.data.error);
                    }
                    try {
                      _temContact = snapshot.data.contacts;
                      if(_temContact.isEmpty) {
                        return _contactIsEmpty(snapshot.data.error);
                      }
                          
                    } catch (error) {
                      return _contactIsEmpty(error);
                    }
                    return _buildContacts(_temContact);
                  } else if (snapshot.hasError) {
                    return _contactIsEmpty(snapshot.error);
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
                      onSubmitted: (value) => null,
                      decoration: InputDecoration(
                        hintText: "Enter a Message...",
                        border: InputBorder.none,
                      ),
                      controller: null,
                    ),
                              ),SendButton(
                    text: "Send",
                    callback: null,
                  )
                            ],
                          ),
              // Row
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

  Widget _buildContacts(List<Contact> contacts) {
                  
                  List<Widget> messages = contacts
                      .map((contact) => Message(
                            tenGv: contact.tenGiaoVien,
                            gvNhanxet: contact.nhanXetGiaoVien,
                            phuHuynh: 'Phụ huynh',  
                            phNhanxet: contact.phanHoiPhuHuynh
                          ))
                      .toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
  }

  Widget _contactIsEmpty(String message) {
    return Center(child: Text(message));
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
  
  final String tenGv;
  final String gvNhanxet;
  final String phuHuynh;
  final String phNhanxet;

  const Message({Key key, this.tenGv, this.gvNhanxet, this.phuHuynh, this.phNhanxet}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ReceivedMessagesWidget(userName: tenGv, content: gvNhanxet)
        ],
      ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SentMessageWidget(userName: phuHuynh, content: phNhanxet)
        ],
      )
      ],
    ));
  }}


