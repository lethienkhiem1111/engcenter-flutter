import 'package:englcenterapp/screens/account/account_sreen.dart';
import 'package:englcenterapp/screens/auth/management_screen.dart';
import 'package:englcenterapp/screens/course/course_screen.dart';
import 'package:englcenterapp/screens/home_screen.dart';
import 'package:englcenterapp/screens/news/news_screen.dart';
import 'package:englcenterapp/widgets/message_widget.dart';
import 'package:flutter/material.dart';


class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>{

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            HomePage(),
            CourseScreen(),
            // NewsScreen(),
            NewsScreen(),
            AccountScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
           onTap: (int index) {
          setState(() {
              _currentIndex = index;
            });
          },
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Colors.green),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedIconTheme: IconThemeData(color: Colors.green),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text('Home'),
                ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                ),
                title: Text('Courses')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.note,
                ),
                title: Text('News')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text('Quản lý')),
          ]),
    );
  }
}