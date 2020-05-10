import 'package:englcenterapp/models/course.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:englcenterapp/widgets/item_course_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../providers/course_provider.dart';


class MangementScreen extends StatefulWidget {
  const MangementScreen({ Key key }) : super(key:key);
  @override
  _MangementScreenState createState() => _MangementScreenState();
}

class _MangementScreenState extends State<MangementScreen> {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final auth = Provider.of<Auth>(context);
    courseProvider.getAllCourses();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
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
                    Text(' Quản lý thông tin lớp học', style: TextStyle(fontSize: 16))
                  ],),
                  SizedBox(height: 14),
                  Container(
                  height: 169,
                  child: StreamBuilder<CourseResponse>(
                    stream: courseProvider.subject.stream,
                    builder: (context, AsyncSnapshot<CourseResponse> snapshot) {
                      if(snapshot.hasData) {
                        if(snapshot.data.error != null && snapshot.data.error.length > 0){
                          return _buildWithError(snapshot.data.error);
                        }
                        return _buildItem(snapshot.data.courses);
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
                    Text(' Quản lý thông tin lớp học', style: TextStyle(fontSize: 16))
                  ],),
                  SizedBox(height: 14),
                  Container(
                  height: 169,
                  child: StreamBuilder<CourseResponse>(
                    stream: courseProvider.subject.stream,
                    builder: (context, AsyncSnapshot<CourseResponse> snapshot) {
                      if(snapshot.hasData) {
                        if(snapshot.data.error != null && snapshot.data.error.length > 0){
                          return _buildWithError(snapshot.data.error);
                        }
                        return _buildItem(snapshot.data.courses);
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

  Widget _buildItem(List<Course> courses) {
    return ListView.builder(
                      itemCount: courses.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (conext, index) {
                        return ItemCourseHome( courses[index].idKhoa,'assets/images/image1.png', courses[index].tenKhoa , courses[index].ngayKT.toString());
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