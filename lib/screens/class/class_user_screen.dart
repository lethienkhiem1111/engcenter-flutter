import 'dart:convert';
import 'package:englcenterapp/models/schedule.dart';
import 'package:englcenterapp/models/schedule_response.dart';
import 'package:englcenterapp/models/schedules.dart';
import 'package:englcenterapp/widgets/item_course_list.dart';
import 'package:englcenterapp/widgets/item_score.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';
import '../../providers/schedule_provider.dart';

class ClassUserScreen extends StatefulWidget {
  static const routeName = '/class_user';
  @override
  _ClassUserScreenState createState() => _ClassUserScreenState();
}

class _ClassUserScreenState extends State<ClassUserScreen> {
  int _currentSelection = 0;
  int idHocVien;
  int idLop;
  @override
  Widget build(BuildContext context) {
    final schedules = Provider.of<ScheduleProvider>(context);
    schedules.getAllSchedules(idHocVien, idLop);

    final heightDevice = MediaQuery.of(context).size.height;
    final widthDevice = MediaQuery.of(context).size.width;

    Map<int, Widget> _children = {
      0: Text(
        'Tuần 4',
        style: TextStyle(fontSize: 18),
      ),
      1: Text(
        'Tuần 5',
        style: TextStyle(fontSize: 18),
      ),
      2: Text(
        'Tuần 6',
        style: TextStyle(fontSize: 18),
      ),
    };

    final _kTabPages = <Widget>[
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
      _buildSchedule(),
    ];
    final _kTabs = <Tab>[
      Tab(text: 'Tuần 1'),
      Tab(text: 'Tuần 2'),
      Tab(text: 'Tuần 3'),
      Tab(text: 'Tuần 4'),
      Tab(text: 'Tuần 5'),
      Tab(text: 'Tuần 6'),
      Tab(text: 'Tuần 7'),
      Tab(text: 'Tuần 8'),
      Tab(text: 'Tuần 9'),
      Tab(text: 'Tuần 10'),
    ];

    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Lớp TOEIC 350+', style: TextStyle(fontSize: 20),),
          //   backgroundColor: Colors.teal,
          // ),
          appBar: AppBar(
            title: Text(
              'Lớp TOEIC 350+',
              style: TextStyle(fontSize: 20),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: _kTabs,
            ),
            backgroundColor: Colors.teal,
            elevation: 0,
          ),
          backgroundColor: Colors.teal,
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              // SafeArea(
              //     child: Container(
              //   height: heightDevice * .1,
              //   decoration: BoxDecoration(color: Colors.teal),
              //   child: Row(
              //     children: <Widget>[
              //       IconButton(
              //           icon: Icon(Icons.arrow_back),
              //           onPressed: () {
              //             Navigator.pop(context);
              //           }),
              //       Text(
              //         'Lớp TOEIC 350+',
              //         style: TextStyle(fontSize: 20),
              //       )
              //     ],
              //   ),
              // )),
              Container(
                height: heightDevice * 3,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: widthDevice,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Thời khóa biểu',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
              
                    Container(
                      height: heightDevice,
                      child: TabBarView(
                        children: _kTabPages,
                      ),
                    ),

                    // Column(
                    //   children: <Widget>[
                    //     SizedBox(
                    //       height: 20,
                    //     ),
                    //     _buildSchedule(
                    //         "Thu 2",
                    //         "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng",
                    //         context,
                    //         true),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     _buildSchedule("Thu 3", "", context, false),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     _buildSchedule(
                    //         "Thu 4",
                    //         "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng ",
                    //         context,
                    //         true),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     _buildSchedule("Thu 5", "", context, false),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     _buildSchedule(
                    //         "Thu 6",
                    //         "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng ",
                    //         context,
                    //         true),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     _buildSchedule("Thu 7", "", context, false),
                    //     SizedBox(
                    //       height: 10,
                    //     ),
                    //     _buildSchedule("Chu nhat", "", context, false),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Điểm',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(children: <Widget>[
                        ItemScore(Color(0xFFFFA432), 'Listening', '8'),
                        ItemScore(Color(0xFF2D8A7F), 'Speaking', '7'),
                        ItemScore(Color(0xFFE24959), 'Reading', '9'),
                        ItemScore(Color(0xFF3399FF), 'Write', '9'),
                      ]),
                    ),
                    Container(
                      height: 500,
                      child: Center(
                          // Use future builder and DefaultAssetBundle to load the local JSON file
                          child: StreamBuilder<ScheduleResponse>(
                        stream: schedules.subject.stream,
                        builder: (context,
                            AsyncSnapshot<ScheduleResponse> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.error != null &&
                                snapshot.data.error.length > 0) {
                              return _buildWithError(snapshot.data.error);
                            }
                            return null;
                            // return _buildItem(snapshot.data.data);
                          } else if (snapshot.hasError) {
                            return _buildWithError(snapshot.error);
                          } else {
                            return _buildLoading();
                          }
                        },
                      )),
                    )
                  ],
                ),
              )
            ],
          ))),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  // Widget _buildItem(List<Schedule> schedules) {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: schedules.length,
  //       scrollDirection: Axis.vertical,
  //       itemBuilder: (conext, index) {
  //         return ItemCourseList(1,'assets/images/image1.png',
  //             schedules[index].tuan, schedules[index].ngayBatDau);
  //       });
  // }

  Widget _buildWithError(String error) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Error occured: $error")),
      ],
    ));
  }

  Widget _buildSchedule() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _buildSesion(
            "Thu 2",
            "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng",
            context,
            true),
        SizedBox(
          height: 10,
        ),
        _buildSesion("Thu 3", "", context, false),
        SizedBox(
          height: 10,
        ),
        _buildSesion(
            "Thu 4",
            "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng ",
            context,
            true),
        SizedBox(
          height: 10,
        ),
        _buildSesion("Thu 5", "", context, false),
        SizedBox(
          height: 10,
        ),
        _buildSesion(
            "Thu 6",
            "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng ",
            context,
            true),
        SizedBox(
          height: 10,
        ),
        _buildSesion("Thu 7", "", context, false),
        SizedBox(
          height: 10,
        ),
        _buildSesion("Chu nhat", "", context, false),
      ],
    );
  }

  Widget _buildSesion(
      String day, String content, BuildContext context, bool hasContent) {
    return Row(
      children: <Widget>[
        Container(child: Text(day)),
        SizedBox(
          width: MediaQuery.of(context).size.width * .1,
        ),
        Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width * .7,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  color: hasContent ? Color(0xFF42A77C) : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                content,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ),
      ],
    );
  }
}
