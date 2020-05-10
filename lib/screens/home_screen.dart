import 'package:englcenterapp/models/course.dart';
import 'package:englcenterapp/models/course_response.dart';
import 'package:englcenterapp/screens/introductions/intro_screen.dart';
import 'package:englcenterapp/widgets/carousel_slider.dart';
import 'package:englcenterapp/widgets/item_course_home.dart';
import 'package:englcenterapp/widgets/item_gridview.dart';
import '../providers/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    courseProvider.getAllCourses();
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        SafeArea(
            top: true,
            left: true,
            right: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Text(
                  //       "Home Page",
                  //       style: TextStyle(
                  //           fontSize: 24, fontWeight: FontWeight.bold),
                  //     ),
                  //     SizedBox(height: 8),
                  //     RichText(
                  //       text: TextSpan(children: [
                  //         TextSpan(
                  //             text: "Chouse your course",
                  //             style:
                  //                 TextStyle(color: Colors.grey, fontSize: 12)),
                  //         TextSpan(
                  //             text: "right way",
                  //             style:
                  //                 TextStyle(color: Colors.teal, fontSize: 12))
                  //       ]),
                  //     )
                  //   ],
                  // ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * (2 / 3),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.search, size: 14),
                          hintText:
                              "Search for your grade, course, training type..",
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none),
                    ),
                  ),
                  Spacer(),
                  Badge(
                    child: Icon(
                      Icons.notifications,
                      color: Colors.teal,
                    ),
                    showBadge: true,
                    badgeContent:
                        Text('1', style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            )),
        SizedBox(height: 5),
        Container(
            height: 165,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: CarouselCourse()),
        // SizedBox(height: 0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Introduction",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 2),
                      blurRadius: 2,
                      spreadRadius: 1
                    )]
                    ),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.pushNamed(context, IntroScreen.routeName)
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text('CHI TIẾT',
                            style: TextStyle(color: Colors.white)),
                        color: Theme.of(context).buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(2),
                        child: Image.asset('./assets/images/ec_center.png'))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Training Program",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(height: 10),
        Container(
          height: 120,
          child: GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.horizontal,
            childAspectRatio: 15/14,
            children: <Widget>[
              ItemGridView(Color(0xFFFFA432), 'Tiếng anh thiếu nhi', 'assets/images/icons/child.png'),
              ItemGridView(Color(0xFF2D8A7F), 'Tiếng anh thiếu niên', 'assets/images/icons/person.png'),
              ItemGridView(Color(0xFFE24959), 'Tiếng anh doanh nghiệp', 'assets/images/icons/business.png'),
              ItemGridView(Color(0xFF3399FF), 'Tiếng anh học thuật', 'assets/images/icons/graduation.png'),
              ItemGridView(Color(0xFF8C8830), 'Tiếng anh Flexi-time', 'assets/images/icons/flextime.png'),
              ItemGridView(Color(0xFF85D704), 'Tiếng anh cam kết đầu ra', 'assets/images/icons/check.png'),
            ],
          )
        ),
            ])),
        
        Container(
          height: 240,
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Recommend course",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text("More")
                  ],
                ),
              ),
              Text("You may also like"),
              SizedBox(height: 16),
              Container(
                  height: 170,
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
            ],
          ),
        ),
      ])),
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
                        return ItemCourseHome(courses[index].idKhoa, 'assets/images/image1.png' , courses[index].tenKhoa, courses[index].ngayBD);
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
