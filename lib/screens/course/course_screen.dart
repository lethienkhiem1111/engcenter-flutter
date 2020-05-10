import 'package:englcenterapp/models/course.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:englcenterapp/widgets/item_course_list.dart';
import 'package:englcenterapp/widgets/item_gridview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key key}) : super(key: key);
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    courseProvider.getAllCourses();
    return DefaultTabController(
        length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Khóa học'),
              bottom: TabBar(tabs: <Widget>[
                Tab(text: 'Tất cả',),
                Tab(text: 'Giao tiếp',),
                Tab(text: 'Toeic',),
                Tab(text: 'IELTS',),
              ],)
            ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white            
              ),
            child: StreamBuilder<CourseResponse>(
            stream: courseProvider.subject.stream,
            builder: (context, AsyncSnapshot<CourseResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildWithError(snapshot.data.error);
                }
                return _buildItem(snapshot.data.courses);
              } else if (snapshot.hasError) {
                return _buildWithError(snapshot.error);
              } else {
                return _buildLoading();
              }
            },
          ))
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildItem(List<Course> courses) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: courses.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (conext, index) {
          return ItemCourseList(courses[index].idKhoa, 'assets/images/image1.png',
              courses[index].tenKhoa, courses[index].ngayBD);
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
