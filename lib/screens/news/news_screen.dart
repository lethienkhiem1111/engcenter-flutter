import 'package:englcenterapp/models/news.dart';
import 'package:englcenterapp/models/news_response.dart';
import 'package:englcenterapp/widgets/item_news_list.dart';
import 'package:flutter/material.dart';
import 'package:englcenterapp/models/course.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:englcenterapp/widgets/item_course_list.dart';
import 'package:englcenterapp/widgets/item_gridview.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    newsProvider.getAllNews();
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return DefaultTabController(
        length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Tin tức'),
              bottom: TabBar(tabs: <Widget>[
                Tab(text: 'Tất cả',),
                Tab(text: 'Du học',),
                Tab(text: 'Sự kiện',),
                Tab(text: 'Nghề nghiệp',),
              ],)
            ),
          body: Container(
                      child: StreamBuilder<NewsResponse>(
            stream: newsProvider.subject.stream,
            builder: (context, AsyncSnapshot<NewsResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildWithError(snapshot.data.error);
                }
                return _buildItem(snapshot.data.news);
              } else if (snapshot.hasError) {
                return _buildWithError(snapshot.error);
              } else {
                return _buildLoading();
              }
            },
              ),
          )
      )
      );}
    );
      
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildItem(List<News> news) {
    return ListView.builder(
        itemCount: news.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (conext, index) {
          return ItemNewsList(news[index]);
        }

        // Container(
        //   margin: EdgeInsets.only(right: 16, bottom: 10),
        //   width: 140,
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(4),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.2),
        //           blurRadius: 5,
        //           spreadRadius: 2,
        //         )
        //       ]),
        //   child: Column(
        //     children: <Widget>[
        //       Expanded(
        //           flex: 3,
        //           child: Container(
        //               width: 140,
        //               child: FittedBox(
        //                   child: Image.asset(
        //                       'assets/images/image1.png'),
        //                   fit: BoxFit.contain),
        //               decoration: BoxDecoration(
        //                   color: Colors.teal,
        //                   borderRadius:
        //                       BorderRadius.circular(4)))),
        //       Expanded(
        //           flex: 4,
        //           child: Padding(
        //             padding: EdgeInsets.all(8),
        //             child: Column(
        //               mainAxisAlignment:
        //                   MainAxisAlignment.spaceEvenly,
        //               crossAxisAlignment:
        //                   CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Text("Morning textbook"),
        //                 Text("8.6"),
        //                 Padding(
        //                   padding:
        //                       EdgeInsets.symmetric(horizontal: 5),
        //                   child: Row(
        //                     children: <Widget>[
        //                       Icon(
        //                         Icons.star,
        //                         color: Colors.yellow,
        //                         size: 12,
        //                       ),
        //                       Icon(
        //                         Icons.star,
        //                         color: Colors.yellow,
        //                         size: 12,
        //                       ),
        //                       Icon(
        //                         Icons.star,
        //                         color: Colors.yellow,
        //                         size: 12,
        //                       ),
        //                       Icon(
        //                         Icons.star,
        //                         color: Colors.yellow,
        //                         size: 12,
        //                       ),
        //                       Icon(
        //                         Icons.star,
        //                         color: Colors.grey,
        //                         size: 12,
        //                       ),
        //                       Spacer(),
        //                       Container(
        //                         height: 24,
        //                         width: 24,
        //                         decoration: BoxDecoration(
        //                             color: Colors.red,
        //                             shape: BoxShape.circle),
        //                         child: Center(
        //                             child: Icon(
        //                           Icons.favorite,
        //                           color: Colors.white,
        //                           size: 12,
        //                         )),
        //                       )
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //           )),
        //     ],
        //   ),
        // ),

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