import 'package:flutter/material.dart';

class ItemGridView extends StatelessWidget {

  final Color color;
  final String content;
  final String icon;

  ItemGridView(this.color, this.content, this.icon);
  
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
          Image(image: AssetImage(icon), height: 20, color: Colors.white,),
          SizedBox(height: 5,),
          Text(content, style: TextStyle(
            color: Colors.white,
            fontSize: 18, 
          ),
          textAlign: TextAlign.center,
          )
        ],),
        )
      ),
    );
  }
}

// Container(
//       padding: EdgeInsets.all(4),
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
     
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10)
//       ),
//       child: 
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Image(image: AssetImage(icon), height: 20,),
//           SizedBox(height: 5,),
//           Text(content, style: TextStyle(
//             fontSize: 15, 
//           ),
//           textAlign: TextAlign.justify,
//           )
//         ],),
//     );