import 'package:englcenterapp/models/hoso.dart';
import 'package:englcenterapp/screens/class/class_screen.dart';
import 'package:englcenterapp/screens/account/hoso_screen.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemHoso extends StatelessWidget {
  final String image;
  final String gioiTinh;
  final String hoTen;
  final String ngaySinh;
  final int idHocVien;
  final String maHocVien;

  ItemHoso(this.image, this.gioiTinh, this.hoTen, this.ngaySinh, this.idHocVien, this.maHocVien);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, HosoScreen.routeName, 
          arguments: 
            Hoso(
              gioiTinh,
              hoTen,
              ngaySinh,
              idHocVien,
              maHocVien));
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
                      Text(hoTen, style: TextStyle(
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
                                  child: Text('Ngày sinh: \n' + ngaySinh,
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
