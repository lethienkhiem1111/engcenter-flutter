import 'package:englcenterapp/models/class.dart';
import 'package:englcenterapp/widgets/MyFlexiableAppBar.dart';
import 'package:englcenterapp/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class ClassDetailScreen extends StatefulWidget {
  static const routeName = '/class_detail';
  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  Class classDetail;
  @override
  Widget build(BuildContext context) {
  final heightDevice = MediaQuery.of(context).size.height;
  classDetail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: MyAppBar(classDetail.tenLop),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            background: MyFlexiableAppBar()
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Row(children: <Widget>[
                  Text('Lớp ' + classDetail.tenLop, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                ],),
                Row(children: <Widget>[
                  FlatButton(color: Colors.blue, child: Text('Khóa ' + classDetail.tenKhoa, style: TextStyle(color: Colors.white, fontSize: 18),), onPressed: () {},)
                ],),
                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text('Mô tả\n',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  Text('Phương pháp, quan điểm giảng dạy: - Giảng chi tiết, tỉ mỉ, tập trung hướng dẫn cụ thể trình tự tiếp cận, giải quyết từng mảng kiến thức theo từng part. Điểm nổi bật của khóa học: - 3 chuyên đề trong khóa học tương ứng với các nội dung trong đề thi TOEIC. - Luyện tập phản xạ với đề thi TOEIC. ') 
                ],),
                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text('Đề cương\n',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  Text('Chuyên đề I. VOCABULARY\nBài 1. Word formation and word order\nBài 2. Noun/Pronoun\nBài 3. Adjective & Adverb\nBài 4. Review & Exercise\n') 
                ],)
              ],),
            ),
          ])
        )
      ],),
    );
  }
}