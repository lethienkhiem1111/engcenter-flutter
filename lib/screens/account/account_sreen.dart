import 'package:englcenterapp/models/hoso.dart';
import 'package:englcenterapp/models/course.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:englcenterapp/models/hoso_response.dart';
import 'package:englcenterapp/widgets/item_course_home.dart';
import 'package:englcenterapp/widgets/item_hoso.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/course_provider.dart';
import '../../providers/hoso_provider.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({ Key key }) : super(key:key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final hosoProvider = Provider.of<HosoProvider>(context);
    final auth = Provider.of<Auth>(context);
    courseProvider.getAllCourses();
    hosoProvider.getHosos();
    return Scaffold(
      body: SingleChildScrollView(
        child: auth.isAuth == false || auth.userName == null ? _buildLoading() : Column(children: <Widget>[
          Container(
              height: 175,
              decoration: BoxDecoration(
                color: Colors.teal
              ),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20,
              horizontal: 10), 
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                  Text('Tài khoản', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),),
                  Spacer(),
                  Text('...', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600))
                ],),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage('./assets/images/image3.png'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: <Widget>[
                      Text(auth.hoten + '\n', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
                      Text('Sinh năm: ' + auth.ngaysinh, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w200)),
                      
                    ],)
                  ],),
                )
              ],),),
            ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 2),
                      blurRadius: 2,
                      spreadRadius: 1
                    )]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Email: ',
                    style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(text: auth.email, style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w200),)
                    ],
                  ),
                ),
                Divider(),RichText(
                  text: TextSpan(
                    text: 'Số điện thoại: ',
                    style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(text: auth.phone, style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w200),)
                    ],
                  ),
                ),
                RaisedButton(child: Text('Logout'), onPressed: () {
                        auth.logout();
                      },)
              ],)
          ),
          
          Container(
            height: 280,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 2),
                      blurRadius: 2,
                      spreadRadius: 1
                    )]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('Quản lý hồ sơ cá nhân', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.calendar_today, color: Colors.pink),
                    Text('Các hồ sơ đang quản lý', style: TextStyle(fontSize: 16))
                  ],),
                  SizedBox(height: 14),
                  Container(
                  height: 169,
                  child: StreamBuilder<HosoResponse>(
                    stream: hosoProvider.subject.stream,
                    builder: (context, AsyncSnapshot<HosoResponse> snapshot) {
                      if(snapshot.hasData) {
                        if(snapshot.data.result != null && snapshot.data.result == 'false'){
                          return _buildWithError('Some wrong');
                        }
                        return _buildHoso(snapshot.data.hosos);
                      } else if (snapshot.hasError) {
                        return _buildWithError(snapshot.error);
                      } else {
                        return _buildLoading();
                      }
                      
                    },
                                      
                  )),
                ],),
              )
            ],),
          )
        ],)
      )
    );
  }
  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator()
    );
  }


  Widget _buildHoso(List<Hoso> hosos) {
    return ListView.builder(
                      itemCount: hosos.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (conext, index) {
                        return ItemHoso(
                          'assets/images/image1.png', 
                          hosos[index].gioiTinh , 
                          hosos[index].hoTen,
                          hosos[index].ngaySinh,
                          hosos[index].idHocVien,
                          hosos[index].maHocVien);
                      }
                      
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