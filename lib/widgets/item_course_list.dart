import 'package:englcenterapp/screens/class/class_screen.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCourseList extends StatelessWidget {
  final int idKhoa;
  final String image;
  final String tenKhoa;
  final String startDay;
  ItemCourseList(this.idKhoa, this.image, this.tenKhoa, this.startDay);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ]),
          alignment: Alignment.center,
      child: ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        subtitle: Text(
            'Khai giảng: ' + startDay,
            style: TextStyle(fontSize: 14)),
        title: Text(
          tenKhoa,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.pushNamed(context, ClassScreen.routeName, arguments: ClassScreenArgument(idKhoa, tenKhoa));
        },
      ),

      // Row(
      //   children: <Widget>[
      //     Expanded(
      //         flex: 3,
      //         child: Placeholder()
      //         // Container(
      //         //     child: FittedBox(
      //         //         child: Image.asset(image),
      //         //         fit: BoxFit.contain),
      //         //     decoration: BoxDecoration(
      //         //         color: Colors.teal,
      //         //         borderRadius: BorderRadius.circular(4)))
      //         ),
      //     Expanded(
      //         flex: 4,
      //         child: Placeholder()
      //         // Padding(
      //         //   padding: EdgeInsets.all(8),
      //         //   child: Column(
      //         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         //     crossAxisAlignment: CrossAxisAlignment.start,
      //         //     children: <Widget>[
      //         //       Text(title, style: TextStyle(
      //         //         fontWeight: FontWeight.bold
      //         //       ),),
      //         //       Padding(
      //         //         padding: EdgeInsets.symmetric(horizontal: 5),
      //         //         child: Row(
      //         //           children: <Widget>[
      //         //             Container(
      //         //               child: Center(
      //         //                   child:
      // Text('Khai giảng: \n' +
      //         //                     DateFormat('dd-MM-yyyy').format(DateTime.parse(startDay)),
      //         //                     style: TextStyle(
      //         //                       fontSize: 14
      //         //                     ),
      //         //                     )
      //         //               ),
      //         //             )
      //         //           ],
      //         //         ),
      //         //       )
      //         //     ],
      //         //   ),
      //         // )
      //         ),
      //   ],
      // ),
    );
  }
}
