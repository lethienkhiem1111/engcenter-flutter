import 'package:provider/provider.dart';
import 'package:englcenterapp/models/info.dart';
import 'package:flutter/material.dart';
import '../../providers/info_provider.dart';

class IntroDetailScreen extends StatefulWidget {

  static const routeName = 'detail_intro_screen';

  @override
  _IntroDetailScreenState createState() => _IntroDetailScreenState();
}

class _IntroDetailScreenState extends State<IntroDetailScreen> {
  String segment; 
  InfoResponse info = InfoResponse(info: 'Loading', error: '');
  

  @override
  Widget build(BuildContext context) {
    segment = ModalRoute.of(context).settings.arguments;
    final bloc = Provider.of<Introduction>(context);
    bloc.getInfo(segment);
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
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(15)),
                            image: DecorationImage(
                                image: AssetImage('assets/images/giaviet.png'),
                                fit: BoxFit.contain))),
                    Positioned(
                      right: 0,
                      top: 10,
                      child: Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/firstimage.png'),
                                fit: BoxFit.contain),
                          )),
                    ),
                    Positioned(
                        bottom: 40,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Vì mục tiêu chất lượng,',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 10),
                            Text('Chúng tôi tự tin bước vào tương lai',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ],
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: StreamBuilder<InfoResponse>(
                  stream: bloc.subject.stream,
                  builder: (context, AsyncSnapshot<InfoResponse> snapshot) {
                    if(snapshot.hasData) {
                      if(snapshot.data.error != null && snapshot.data.error.length > 0) {
                        print('hasData');
                        return _buildWithError(snapshot.data.error);
                      }
                      
                      return _buildContent(snapshot.data);
                    } else if (snapshot.hasError){
                      print('have error');
                      print(snapshot.data.error);
                      return _buildWithError(snapshot.error);
                    } else {
                      print('ewfew');
                      return _buildLoading();
                    }
                  },
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _buildContent(InfoResponse data) {
    return Container(
                  child: Column(children: <Widget>[
                    Text(data.info.toString(), style: TextStyle(fontSize: 18),),
                    // SizedBox(height: 5,),
                    // Text('ĐỘI NGŨ GIÁO VIÊN VÀ NHÂN VIÊN\n\nGia Việt vinh dự và rất tự hào có được sự kết hợp nhịp nhàng giữa lực lượng giáo viên giàu kinh nghiệm giảng dạy với đội ngũ giáo viên trẻ năng động và nhiệt tình với hơn 150 giáo viên Việt Nam cùng với lực lượng giáo viên bản xứ từ các nước Mỹ, Anh, Úc, Hà Lan và Philippines. Với nhiều chính sách chăm sóc tốt quyền lợi của giáo viên đi đôi với định hướng quản lý và đầu tư cho chuyên môn và chất lượng giảng dạy hợp lý, Gia Việt tự hào luôn là môi trường giảng dạy đầu tiên để cộng tác của nhiều thế hệ giáo viên tiếng Anh.\nBên cạnh Gia Việt được cộng tác với lực lượng giáo viên giàu kinh nghiệm, đội ngũ giáo viên trẻ năng động mà Gia Việt còn được làm chung một mái nhà với một đội ngũ nhân viên tràn đầy nhiệt huyết, hết lòng vì công việc.\nVới phương châm “chất lượng đi đầu”, đội ngũ nhân viên Gia Việt đã thật sự cho thấy sự tin tưởng và huyết tâm của mình để làm việc với quý Thầy/ Cô, quý Phụ huynh và các bạn học viên một cách hiệu quả nhất.',
                    // style: TextStyle(fontSize: 18),
                    // textAlign: TextAlign.justify,
                    // ),
                    // SizedBox(height: 10,),
                    // Text('TẦM NHÌN VÀ SỨ MỆNH', style: TextStyle(fontSize: 18),),
                    // SizedBox(height: 5,),
                    // Text(content == null ? '' : content,
                    // style: TextStyle(fontSize: 18),
                    // textAlign: TextAlign.justify,
                    // )
                  ],)
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
