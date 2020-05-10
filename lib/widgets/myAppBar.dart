import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  final double barHeight = 66.0;
  final String title;
  MyAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width*.8;
    return Container(
      width: width,
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black54,
            fontFamily: 'Poppins',
            fontSize: 20.0
        ),
      ),);
    // return Container(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: <Widget>[
      
    //       Container(child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Text(
    //           title,
    //           style: TextStyle(
    //             color: Colors.black54,
    //               fontFamily: 'Poppins',
    //               fontSize: 20.0
    //           ),
    //         ),

    //       ),),


    //     ],
    //   ),
    // );
  }}