import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'MaterialButton.dart';
import 'Model.dart';
import 'config/constant.dart';

class SignUp extends StatefulWidget {
  static String tag = 'as';

  @override
  SignUpState createState() => new SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool Lang = true;

  @override
  void initState() {
    super.initState();
    getLang().then((l) {
      setState(() {
        Lang = l;
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
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            Lang ? "سجل" : 'Sign Up',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Directionality(
          textDirection: Lang ? TextDirection.rtl : TextDirection.ltr,
          child: SingleChildScrollView(
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
                            controller: nameController,
                            decoration: InputDecoration(
                                hintText: Lang ? "اسم" : 'Name',
                                border: OutlineInputBorder())),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.grey.withOpacity(0.15),
                        ),
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 0, bottom: 16),
                        child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                labelText: Lang ? "رقم الهاتف" : 'Phone Number',
                                hintText: Lang ? "رقم الهاتف" : 'Phone Number',
                                border: OutlineInputBorder())),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.grey.withOpacity(0.15),
                        ),
                        margin: EdgeInsets.only(
                            left: 16, right: 16, top: 0, bottom: 16),
                        child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                                hintText: Lang ? "عنوان" : 'Address',
                                border: OutlineInputBorder())),
                      ),
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
                                hintText:   'Email',
                                border: OutlineInputBorder())),
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
                                hintText: Lang ? "كلمه السر" : 'Password',
                                border: OutlineInputBorder())),
                      ),
                      Center(
                        child: Container(
                          height: 50,
                          child: FloatingActionButton.extended(
                            heroTag: "btn1",
                            backgroundColor: Colors.black87,
                            onPressed: () async {
                              var body = {
                                'email': emailController.text,
                                'name': nameController.text,
                                'phone': phoneController.text,
                                'address': addressController.text,
                                'password':passwordController.text
                              };
                              String url = '$baseURL/user/api/signup/';
                              print(json.encode(body));
                              final responseBody = (await http
                                  .post(url, body: json.encode(body), headers: {'Content-Type': 'application/json'}));
                              print(url);
                              print(responseBody.body);
                              if (responseBody.statusCode == 201) {
                                Navigator.pop(context);
                              } else {
                                _AlertBox(responseBody.body, context);
                              }
                            },
                            label: Text(Lang
                                ? '       سجل        '
                                : '       SIGN UP        '),
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
}

void _AlertBox(message, context) {
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
              text: 'Okay',
            ),
          ],
        ),
      );
    },
  );
}

DateTime currentBackPressTime;
