import 'package:englcenterapp/models/class.dart';
import 'package:englcenterapp/models/news.dart';
import 'package:englcenterapp/widgets/MyFlexiableAppBar.dart';
import 'package:englcenterapp/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  static const routeName = '/news_detail';
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  News newsDetail;
  @override
  Widget build(BuildContext context) {
  final heightDevice = MediaQuery.of(context).size.height;
  newsDetail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: MyAppBar('Chi tiết tin tức'),
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
              width: MediaQuery.of(context).size.width*.8,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(newsDetail.tieuDe, textAlign: TextAlign.left, 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  Row(children: <Widget>[
                    FlatButton(color: Colors.blue, child: Text('Loại tin:  ' + newsDetail.tenLoaiTinTuc, style: TextStyle(color: Colors.white),), onPressed: () {},)
                  ],),
                  SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text('Nội dung\n',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                    Text(newsDetail.noiDung,style: TextStyle(fontSize: 16)) 
                  ],),
                  SizedBox(height: 15,),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //   Text('Đề cương\n',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  //   Text('Chuyên đề I. VOCABULARY\nBài 1. Word formation and word order\nBài 2. Noun/Pronoun\nBài 3. Adjective & Adverb\nBài 4. Review & Exercise\n') 
                  // ],
                  // )
                ],),
            ),
          ])
        )
      ],),
    );
  }
}