import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mycircleavatar.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

class ReceivedMessagesWidget extends StatelessWidget {
  final String userName;
  final String content;
  const ReceivedMessagesWidget({
    Key key,
    this.userName, this.content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          MyCircleAvatar(
            imgUrl: './assets/images/image3.png',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: Theme.of(context).textTheme.caption,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xfff9f9f9),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  content,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
