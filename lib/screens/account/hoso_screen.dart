import 'package:englcenterapp/models/class.dart';
import 'package:englcenterapp/models/classStudying_response..dart';
import 'package:englcenterapp/models/class_response.dart';
import 'package:englcenterapp/models/hoso.dart';
import 'package:englcenterapp/models/course.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:englcenterapp/models/hoso_response.dart';
import 'package:englcenterapp/widgets/ItemClassList.dart';
import 'package:englcenterapp/widgets/ItemUserClassList.dart';
import 'package:englcenterapp/widgets/item_course_home.dart';
import 'package:englcenterapp/widgets/item_hoso.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/class_provider.dart';

class HosoScreen extends StatefulWidget {
  static const routeName = 'detail_screen';
  const HosoScreen({Key key}) : super(key: key);
  @override
  _HosoScreenState createState() => _HosoScreenState();
}

class _HosoScreenState extends State<HosoScreen> {
  Hoso hoso;
  @override
  Widget build(BuildContext context) {
    hoso = ModalRoute.of(context).settings.arguments;
    final classProvider = Provider.of<ClassProvider>(context);
    classProvider.getClassStudying(hoso.idHocVien);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text('Tài khoản'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: 175,
              decoration: BoxDecoration(color: Colors.teal),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //   Text('Tài khoản', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                    //   Spacer(),
                    //   Text('...', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600))
                    // ],),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('./assets/images/image3.png'),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: <Widget>[
                              Text(hoso.hoTen + '\n',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              Text('Sinh năm: ' + hoso.ngaySinh,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 2),
                          blurRadius: 2,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Mã học viên: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: hoso.maHocVien,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        text: 'Giới tính: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: hoso.gioiTinh,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(1, 2),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lớp đang học',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today, color: Colors.pink),
                            Text('Các lớp đang quản lý',
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                        SizedBox(height: 14),
                        Container(
                            height: 380,
                            child: StreamBuilder<ClassStudyingResponse>(
                              stream: classProvider.subjectStudying.stream,
                              builder: (context,
                                  AsyncSnapshot<ClassStudyingResponse>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.error != null &&
                                      snapshot.data.error.length > 0) {
                                    return _buildWithError(snapshot.data.error);
                                  }
                                  return _buildClassItem(snapshot.data.classes);
                                } else if (snapshot.hasError) {
                                  return _buildWithError(snapshot.error);
                                } else {
                                  return _buildLoading();
                                }
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildClassItem(List<Class> classes) {
    return ListView.builder(
        itemCount: classes.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (conext, index) {
          return ItemUserClassList(hoso.idHocVien, 'assets/images/image1.png', classes[index]);
        });
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
