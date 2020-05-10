import 'package:englcenterapp/screens/class/class_screen.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCourseHome extends StatelessWidget {
  final int idKhoa;
  final String image;
  final String tenKhoa;
  final String startDay;
  ItemCourseHome(this.idKhoa, this.image, this.tenKhoa, this.startDay);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ClassScreen.routeName, arguments: ClassScreenArgument(idKhoa, tenKhoa));
        },
          child: Container(
        margin: EdgeInsets.only(right: 16, bottom: 10),
        width: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
              )
            ]),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                    width: 140,
                    child: FittedBox(
                        child: Image.asset(image),
                        fit: BoxFit.contain),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(4)))),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(tenKhoa, style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: <Widget>[
                            // Icon(
                            //   Icons.star,
                            //   color: Colors.yellow,
                            //   size: 12,
                            // ),
                            // Icon(
                            //   Icons.star,
                            //   color: Colors.yellow,
                            //   size: 12,
                            // ),
                            // Icon(
                            //   Icons.star,
                            //   color: Colors.yellow,
                            //   size: 12,
                            // ),
                            // Icon(
                            //   Icons.star,
                            //   color: Colors.yellow,
                            //   size: 12,
                            // ),
                            // Icon(
                            //   Icons.star,
                            //   color: Colors.grey,
                            //   size: 12,
                            // ),
                            // Spacer(),
                            Container(
                              child: Center(
                                  child: Text('Khai giảng: \n' + startDay,
                                    style: TextStyle(
                                      fontSize: 14
                                    ),
                                    )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
