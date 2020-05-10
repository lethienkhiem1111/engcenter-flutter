import 'package:englcenterapp/providers/auth.dart';
import 'package:englcenterapp/providers/class_provider.dart';
import 'package:englcenterapp/providers/contact_provider.dart';
import 'package:englcenterapp/providers/course_provider.dart';
import 'package:englcenterapp/providers/hoso_provider.dart';
import 'package:englcenterapp/providers/info_provider.dart';
import 'package:englcenterapp/providers/news_provider.dart';
import 'package:englcenterapp/providers/schedule_provider.dart';
import 'package:englcenterapp/providers/score_provider.dart';
import 'package:englcenterapp/screens/app.dart';
import 'package:englcenterapp/screens/auth/auth_screen.dart';
import 'package:englcenterapp/screens/class/chat_screen.dart';
import 'package:englcenterapp/screens/class/class_detail_screen.dart';
import 'package:englcenterapp/screens/class/class_screen.dart';
import 'package:englcenterapp/screens/class/class_user_screen.dart';
import 'package:englcenterapp/screens/class/class_user_test.dart';
import 'package:englcenterapp/screens/class/contact_screen.dart';
import 'package:englcenterapp/screens/home_screen.dart';
import 'package:englcenterapp/screens/account/hoso_screen.dart';
import 'package:englcenterapp/screens/introductions/intro_detail_screen.dart';
import 'package:englcenterapp/screens/introductions/intro_screen.dart';
import 'package:englcenterapp/screens/account/score_screen.dart';
import 'package:englcenterapp/screens/news/news_detail_screen.dart';
import 'package:englcenterapp/screens/slashcreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ProxyProvider<Auth, Introduction>(
          update: (context, auth, previousInfo) => Introduction(
              auth.sessionId, previousInfo == null ? '' : previousInfo.info),
        ),
        ProxyProvider<Auth, CourseProvider>(
          update: (context, auth, previousCourse) => CourseProvider(
            auth.sessionId, previousCourse == null ? [] : previousCourse.courses
          ),
        ),
        ProxyProvider<Auth, ClassProvider>(
          update: (context, auth, previousClass) => ClassProvider(
            auth.sessionId, previousClass == null ? [] : previousClass.classes
          ),
        ),
        ProxyProvider<Auth, HosoProvider>(
          update: (context, auth, previousClass) => HosoProvider(
            auth.sessionId, previousClass == null ? [] : previousClass.hosos
          ),
        ),
        ProxyProvider<Auth, ScheduleProvider>(
          update: (context, auth, previousSchedule) => ScheduleProvider(
            auth.sessionId, previousSchedule == null ? [] : previousSchedule.schedules
          ),
        ),
        ProxyProvider<Auth, ScoreProvider>(
          update: (context, auth, previousScore) => ScoreProvider(
            auth.sessionId, previousScore == null ? [] : previousScore.scores
          ),
        ),
        ProxyProvider<Auth, ContactProvider>(
          update: (context, auth, previousContact) => ContactProvider(
            auth.sessionId, previousContact == null ? [] : previousContact.contacts
          ),
        ),
        Provider<NewsProvider>(
          create: (_) => new NewsProvider()
        ) 
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            theme: ThemeData(
              primaryColor: Color(0xFF33AF85),
              accentColor: Color(0xFFeb4034),
              buttonColor: Color(0xFF188774),
              buttonTheme: ButtonThemeData(buttonColor: Color(0xFF188774)),
            ),
            title: 'ECApp',
            initialRoute: '/',
            routes: {
              '/': (ctx) => auth.isAuth
                  ? AppScreen()
                  : FutureBuilder(
                      future: auth.tryLogin(),
                      builder: (ctx, authResultSnapshot) => authResultSnapshot.data != null ? AuthScreen() : SlashScreen(),
                    ),
              HomePage.routeName: (ctx) => HomePage(),
              IntroScreen.routeName: (ctx) => IntroScreen(),
              IntroDetailScreen.routeName: (ctx) => IntroDetailScreen(),
              ClassScreen.routeName: (ctx) => ClassScreen(),
              ClassDetailScreen.routeName: (ctx) => ClassDetailScreen(),
              ClassUserScreen.routeName: (ctx) => ClassUserScreen(),
              ClassUserTest.routeName: (ctx) => ClassUserTest(),
              ScoreScreen.routeName: (ctx) => ScoreScreen(),
              ChatScreen.routeName: (ctx) => ChatScreen(),
              HosoScreen.routeName: (ctx) => HosoScreen(),
              ContactScreen.routeName: (ctx) => ContactScreen(),
              NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
            }),
      ),
    );
  }
}
