
import 'package:englcenterapp/screens/introductions/intro_detail_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = '/introduction';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Giới thiệu',
          style: TextStyle(fontSize: 25, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                        image: DecorationImage(image: AssetImage('assets/images/giaviet.png'),
                        fit: BoxFit.contain)
                        )
                      ),
                    
                    Positioned(
                      right: 0,
                      top: 10,
                                          child: Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/firstimage.png'),
                              fit: BoxFit.contain
                              ),
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text('Vì mục tiêu chất lượng,', style: TextStyle(fontSize: 20, color: Colors.white,)),
                      SizedBox(height: 10),
                      Text('Chúng tôi tự tin bước vào tương lai', style: TextStyle(fontSize: 20, color: Colors.white,)),
                    ],))
                  ],
                )),
                _buildCardIntro(
                  context: context,
                  color: Color(0xFFedf8ff),
                  title: "Sứ mệnh và tầm nhìn",
                  content: "Trung tâm Anh ngữ Gia Việt cam kết luôn phấn đấu \n\nvà đổi mới để luôn là đơn vị tiên phong về \n\nchất lượng giảng dạy và phục vụ",
                  image: 'assets/images/image2.png',
                  segment: 'tamnhin'
                ),
                _buildCardIntro(
                  context: context,
                  color: Color(0xFFFDF4F5),
                  title: "Giá trị cốt lõi",
                  content: "Chất lượng giảng dạy tốt nhất \n\nChương trình học thuật xuất sắc \n\nPhát triển toàn diện",
                  image: 'assets/images/image3.png',
                  segment: 'giatri'
                ),
                _buildCardIntro(
                  context: context,
                  color: Color(0xFFefffd9),
                  title: "Đội ngủ giáo viên và nhân viên",
                  content: "Trung tâm Anh ngữ Gia Việt cam kết luôn phấn đấu \n\nvà đổi mới để luôn là đơn vị tiên phong về \n\nchất lượng giảng dạy và phục vụ",
                  image: 'assets/images/image1.png',
                  segment: 'doingu'
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   height: 200,
                //   decoration: BoxDecoration(
                //     color: Color(0xFFFDF4F5),
                //     borderRadius: BorderRadius.circular(15)),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   height: 200,
                //   decoration: BoxDecoration(
                //     color: Color(0xFFefffd9),
                //     borderRadius: BorderRadius.circular(15)),
                // ),
          ],
        ),
      ),
    );

    
  }

  Widget _buildCardIntro({BuildContext context, Color color, String title, String content, String image, String segment}) {
      return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 5,
                      bottom: 15,
                                          child: Container(
                        height: 70,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.contain
                              ),
                        )
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(title == null ? '' : title, style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      Text(content == null ? '' : content, style: TextStyle(fontSize: 14, color: Colors.black87,)),
                      SizedBox(height: 10),
                      RaisedButton(onPressed: () {
                        Navigator.pushNamed(context, IntroDetailScreen.routeName, arguments: segment);
                      },
                      child: Text('CHI TIẾT',
                            style: TextStyle(color: Colors.white)),
                        color: Theme.of(context).buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],))
                  ],
                )
                );
    }
}
