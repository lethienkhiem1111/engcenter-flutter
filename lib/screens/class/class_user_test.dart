import 'package:englcenterapp/models/schedule.dart';
import 'package:englcenterapp/models/schedule_response.dart';
import 'package:englcenterapp/models/session.dart';
import 'package:englcenterapp/screens/account/score_screen.dart';
import 'package:englcenterapp/screens/class/contact_screen.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/schedule_provider.dart';
import '../../providers/auth.dart';

class ClassUserTest extends StatefulWidget {
  static const routeName = '/class_user_test';
  @override
  _ClassUserTestState createState() => _ClassUserTestState();
}

class _ClassUserTestState extends State<ClassUserTest> {
  ClassScreenArgument args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    final schedules = Provider.of<ScheduleProvider>(context);
    print('getAllScheduls');
    schedules.getAllSchedules(args.idHocVien, args.idLop);

    final heightDevice = MediaQuery.of(context).size.height;
    final widthDevice = MediaQuery.of(context).size.width;

    return StreamBuilder<ScheduleResponse>(
      stream: schedules.subject.stream,
      builder: (context, AsyncSnapshot<ScheduleResponse> snapshot) {
        List<Schedule> _temSchedule = [];
        List<String> _tempTuan = [];
        List<Tab> _kTabs = [];
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _scheduleIsEmpty(snapshot.data.error);
          }
          try {
            _temSchedule = snapshot.data.schedules;
            if (_temSchedule.isEmpty) {
              return _scheduleIsEmpty(snapshot.data.error);
            }
            _kTabs = snapshot.data.schedules
                .map((schedule) =>
                    Tab(text: 'Tuần ' + schedule.tuan.tuanHoc.toString()))
                .toList();
            print('tuan hoc');
            // _kTabs = _tempTuan.map((e)=>
            //   Tab(text: 'Tuần ' + e)).toList();

          } catch (error) {
            return _buildWithError(error);
          }
          return _buildItem(_temSchedule, _kTabs, context);
        } else if (snapshot.hasError) {
          return _buildWithError(snapshot.error);
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildItem(
      List<Schedule> schedules, List<Tab> _tabs, BuildContext context) {
    // final _kTabs = <Tab>[
    //   Tab(text: 'Tuần 1'),
    //   Tab(text: 'Tuần 2'),
    //   Tab(text: 'Tuần 3')
    // ];
    print('scheduls length ' + schedules.length.toString());
    print('tabs length ' + _tabs.length.toString());
    final heightDevice = MediaQuery.of(context).size.height;
    final widthDevice = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context);

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Lớp TOEIC 350+',
              style: TextStyle(fontSize: 20),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: _tabs,
            ),
            backgroundColor: Colors.teal,
            elevation: 0,
          ),
          backgroundColor: Colors.teal,
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                height: heightDevice * 2,
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: heightDevice * 1,
                      child: TabBarView(
                        children: schedules
                            .map((schedule) =>
                                _buildSchedule(schedule.buoi, context))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Điểm',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonTheme(
                        minWidth: 200.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Xem điểm',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          color: Color(0xFF1565c0),
                          onPressed: () {
                            Navigator.pushNamed(context, ScoreScreen.routeName,
                                arguments: ClassScreenArgument.studyingUser(
                                    args.idHocVien, args.idLop));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nhận xét',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonTheme(
                        minWidth: 200.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Nhận xét của giáo viên',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          color: Color(0xFF1565c0),
                          onPressed: () {
                            Navigator.pushNamed(context, ContactScreen.routeName,
                                arguments: ClassScreenArgument.studyingUser(
                                    args.idHocVien, args.idLop));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))
          // Container(
          //   height: 1000,
          //       padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          //       width: 500,
          // //       decoration: BoxDecoration(
          // // color: Colors.white,
          // // borderRadius: BorderRadius.only(
          // //     topRight: Radius.circular(30),
          // //     topLeft: Radius.circular(30))),
          //   child: Column(children: <Widget>[
          // //       Text(
          // // 'Thời khóa biểu',
          // // style: TextStyle(fontSize: 18),
          // //         ),
          // //         SizedBox(
          // // height: 20,
          // //         ),
          //     TabBarView(
          //       children: schedules
          // .map((schedule) => _buildSchedule(schedule.buoi))
          // .toList(),
          //     ),
          //   ],
          //   ),
          // ),
          ),
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

  Widget _scheduleIsEmpty(String message) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thời khóa biểu'),
        ),
        body: Column(children: <Widget>[
          Center(
            child: Text(message),
          ),
          Text(
            'Điểm',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Xem điểm',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                color: Color(0xFF1565c0),
                onPressed: () {
                  Navigator.pushNamed(context, ScoreScreen.routeName,
                      arguments: ClassScreenArgument.studyingUser(
                          args.idHocVien, args.idLop));
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Nhận xét',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Nhận xét của giáo viên',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                color: Color(0xFF1565c0),
                onPressed: () {
                  Navigator.pushNamed(context, ContactScreen.routeName,
                                arguments: ClassScreenArgument.studyingUser(
                                    args.idHocVien, args.idLop));
                },
              ),
            ),
          ),
        ]));
  }

  Widget _buildSchedule(List<Session> sessions, BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sessions.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
        itemBuilder: (conext, index) {
          return _buildSesion(
              sessions[index].lop,
              sessions[index].caDay,
              sessions[index].batDau,
              sessions[index].thu,
              sessions[index].giaoVien,
              sessions[index].phong,
              context,
              true);
        });

    // Column(
    //   children: <Widget>[
    //     SizedBox(
    //       height: 20,
    //     ),
    //     _buildSesion(
    //         "Thu 2",
    //         "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng",
    //         context,
    //         true),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     _buildSesion("Thu 3", "", context, false),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     _buildSesion(
    //         "Thu 4",
    //         "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng ",
    //         context,
    //         true),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     _buildSesion("Thu 5", "", context, false),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     _buildSesion(
    //         "Thu 6",
    //         "Thời gian: 18h30 - 20h30 Giảng viên: Trần Hoàng Nam Kỉ năng: Nghe - Nói Phòng: 109, toàn nhà 9/9A, Đinh Công Tráng ",
    //         context,
    //         true),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     _buildSesion("Thu 7", "", context, false),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     _buildSesion("Chu nhat", "", context, false),
    //   ],
    // );
  }

  Widget _buildSesion(String lop, String caDay, String batDau, String thu,
      String giaoVien, String phong, BuildContext context, bool hasContent) {
    return Row(
      children: <Widget>[
        Container(child: Text(thu)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Giao vien: ' + giaoVien,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Lớp: ' + lop,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'Ngay: ' + batDau,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
