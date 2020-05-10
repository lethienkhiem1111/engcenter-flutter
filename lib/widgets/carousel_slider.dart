import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselCourse extends StatefulWidget {
  @override
  _CarouselCourseState createState() => _CarouselCourseState();
}

class _CarouselCourseState extends State<CarouselCourse> {

  int _current = 0;
  List imageList = [
    'assets/images/course.png',
    'assets/images/course.png',
    'assets/images/course.png',
    'assets/images/course.png',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i=0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget> [
            CarouselSlider(
        height: 140,
        initialPage: 0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        items: imageList.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 8),
                // decoration: BoxDecoration(
                //   color: Colors.green,
                // ),
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(imageUrl, fit: BoxFit.cover,)),
              );
            },
          );
        }).toList(),
      ),
      SizedBox(height: 2,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(imageList, (index, url) {
          return Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index ? Colors.teal : Colors.grey
            ),
          );
        })
      )
          ]
    );
  }
}