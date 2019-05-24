import 'package:final_01/friend.dart';
import 'package:final_01/home.dart';
import 'package:final_01/login.dart';
import 'package:final_01/profile.dart';
import 'package:final_01/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Final',
    theme: ThemeData(primaryColor: Color(0xff9c27d0)),
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => Login(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/register': (context) => Register(),
      '/home': (context) => Home(),
      '/profile': (context) => Profile(),
      '/friend': (context) => myfriend(),
    },
  ));
}