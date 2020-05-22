import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  static String tag = 'login_page';

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {


    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/background.png',
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          left: MediaQuery.of(context).size.width * 0.3,
          top: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.red,
          ),
        ),

      ],
    );
  }

}
