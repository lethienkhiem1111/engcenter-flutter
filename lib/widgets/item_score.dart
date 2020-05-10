import 'package:flutter/material.dart';

class ItemScore extends StatelessWidget {

  final Color color;
  final String skill;
  final String score;

  ItemScore(this.color, this.skill, this.score);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        child:
        Align(
          alignment: Alignment.center,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(score, style: TextStyle(
            color: Colors.white,
            fontSize: 30, 
          ),textAlign: TextAlign.center,
          ),
          SizedBox(height: 5,),
          Text(skill, style: TextStyle(
            color: Colors.white,
            fontSize: 25, 
          ),
          )
        ],),
        )
      ),
    );
  }
}