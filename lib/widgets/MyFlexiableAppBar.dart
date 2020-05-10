import 'package:flutter/material.dart';

class MyFlexiableAppBar extends StatelessWidget {


  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 300,
      decoration: new BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/class_details.jpg'),
                        fit: BoxFit.cover)
      ),
    );
  }
}
