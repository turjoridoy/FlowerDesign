import 'package:flutter/material.dart';
import 'package:wadaaro/Language.dart';
import 'package:wadaaro/SignUp.dart';
import 'package:wadaaro/login_page.dart';
import 'package:wadaaro/test.dart';

import 'LogIn.dart';
import 'SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,),
      home: SafeArea(child: SplashScreen()),

    );
  }
}
