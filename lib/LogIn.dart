import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wadaaro/Language.dart';
import 'package:wadaaro/SignUp.dart';
import 'package:wadaaro/explore_widget.dart';
import 'package:wadaaro/test.dart';

import 'MaterialButton.dart';
import 'Model.dart';
import 'constant.dart';

class LogIn extends StatefulWidget {
  static String tag = 'after_splash';

  @override
  LogInState createState() => new LogInState();
}

class LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool Lang=true;
  @override
  void initState() {
    super.initState();
    getLang().then((l){
      setState(() {
        Lang=l;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.grey.withOpacity(0.15),
            ),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black87,
                size: 30,
              ),onTap: (){

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlowerPage(),
                  ));
            },
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
           Lang?"تسجيل الدخول":'Sign In',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body:




        Directionality(
          textDirection:Lang?  TextDirection.rtl:TextDirection.ltr,
          child: new Container(
            child: new GestureDetector(
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 32.0),
                    SizedBox(height: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 16),
                      child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: Lang?"البريد الإلكتروني":'Email', border: OutlineInputBorder())),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 16),
                      child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText:Lang?"كلمه السر": 'Password',
                              border: OutlineInputBorder())),
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.black87,
                          onPressed: () async {
                            String url='$baseURL/user/login?email=${emailController.text}&password=${passwordController.text}';
                            final responseBody = (await http.get(
                              url,
                            ));
                            print(url);
                            if (responseBody.statusCode == 200) {
                              saveUser(responseBody.body);
                              print(responseBody.body);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FlowerPage(),
                                  ));
                            } else {
                              AlertBox(Lang?"معرف / كلمة مرور غير صالحة":'Invalid ID/Password', context);
                            }
                          },
                          label: Text(Lang?'       تسجيل الدخول          ':'       SIGN IN        '),
                        ),
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 0, bottom: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),





        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Lang?"ليس لديك حساب؟":'Don\'t have an account?'),
            SizedBox(
              height: 8,
              width: 8,
            ),
            Container(
              height: 50,
              child: FloatingActionButton.extended(
                heroTag: "btn9",
                backgroundColor: Colors.grey[100],
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
                label: Text(Lang?'       سجل        ':
                  '       SIGN UP        ',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
            )
          ],
        ),
      ),
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;

          return Future.value(false);
        }
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(true);
      },
    );
  }

  void AlertBox(message, context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              SizedBox(
                height: 8,
                width: 8,
              ),
              new Text(
                message,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 8,
                width: 8,
              ),
              CustomButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                edgeInsetVertical: 0.0,
                edgeInsetHorizontal: 0.0,
                text: Lang?"حسنا":'Okay',
              ),
            ],
          ),
        );
      },
    );
  }
}

DateTime currentBackPressTime;
