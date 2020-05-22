import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wadaaro/Model.dart';
import 'package:wadaaro/test.dart';

import 'MaterialButton.dart';

class Language extends StatefulWidget {
  static String tag = 'after_splash';

  @override
  LanguageState createState() => new LanguageState();
}

class LanguageState extends State<Language> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool Language=true;
  @override
  void initState() {
    super.initState();
    getLang().then((V){
      setState(() {
        Language=V;
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
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Language',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: new Container(
          child: new GestureDetector(
            child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 32.0),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    child: ListTile(
                      title: Text('Arabic'),
                      subtitle: Text('Arabic'),
                      trailing: Language?Icon(Icons.check_box,color: Colors.blue,):Icon(Icons.check_box_outline_blank,color: Colors.blue,),
                    ),
                    onTap: (){
                      saveLang(true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlowerPage(),
                          ));
                    },
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueGrey.withOpacity(0.27),
                  ),
                  GestureDetector(
                    child: ListTile(
                      title: Text('English'),
                      subtitle: Text('English'),
                      trailing:!Language?Icon(Icons.check_box,color: Colors.blue,):Icon(Icons.check_box_outline_blank,color: Colors.blue,),
                    ),
                    onTap: (){
                      saveLang(false);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlowerPage(),
                          ));

                    },
                  )
                ],
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
