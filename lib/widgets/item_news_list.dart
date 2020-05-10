import 'package:englcenterapp/models/news.dart';
import 'package:englcenterapp/screens/class/class_screen.dart';
import 'package:englcenterapp/screens/news/news_detail_screen.dart';
import 'package:englcenterapp/widgets/ClassScreenArgument.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemNewsList extends StatelessWidget {
  final News news;
  ItemNewsList(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ]),
          alignment: Alignment.center,
      child: ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Image.network(news.anhDaiDien, fit: BoxFit.cover),
        ),
        subtitle: Text(
            'Ngày đăng: ' + news.ngayDang,
            style: TextStyle(fontSize: 14)),
        title: Text(
          news.tieuDe,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.pushNamed(context, NewsDetailScreen.routeName, 
          arguments: News(
            news.loaiTinTuc,
            news.trangThaiTinTuc,
            news.noiDung,
            news.ngayDang,
            news.tieuDe,
            news.anhDaiDien,
            news.tenLoaiTinTuc,
            news.tomTat,
            news.idTrangThaiTinTuc,
            news.idTinTuc,
          ));
        },
      ),
    );
  }
}
