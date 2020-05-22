import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wadaaro/Model.dart';

import 'MaterialButton.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_moment/simple_moment.dart';

import 'config/constant.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUs extends StatefulWidget {
  static String tag = 'after_splash';
  Information info;
  bool Lang;
  ContactUs(this.Lang);
  @override
  ContactUsState createState() => new ContactUsState();
}

class ContactUsState extends State<ContactUs> {

  @override
  void initState() {
    super.initState();
    getPosts().then((v){
      setState(() {
        widget.info=v;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

  }


  Future<Information> getPosts() async {
    final responseBody = (await http.get(
      '$baseURL/user/info/',
    ))
        .bodyBytes;

    return Information.fromJsonList(json.decode(utf8.decode(responseBody)))[0];
  }

  Future<void> openCall() async {
    String googleUrl = 'tel://${widget.info.phone}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
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
           widget. Lang?"اتصل بنا": 'Contact Us',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: new Container(
          child: new GestureDetector(
            child: new Container(
              child: widget.info==null?Container():new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 32.0),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    child: ListTile(
                      title: Text(widget.Lang?widget.info.addressAr:widget.info.address),
                      leading: Icon(Icons.location_city,color: Colors.blue,),
                    ),
                    onTap: (){
                      openMap();

                    },
                  ), GestureDetector(
                    child: ListTile(
                      title: Text(widget.Lang?widget.info.workingHourAr:widget.info.workingHour),
                      leading: Icon(Icons.hourglass_empty,color: Colors.blue,),
                    ),
                    onTap: (){

                    },
                  ), GestureDetector(
                    child: ListTile(
                      title: Text(widget.Lang?widget.info.phoneAr:widget.info.phone),
                      leading: Icon(Icons.call,color: Colors.blue,),
                    ),
                    onTap: (){
                      openCall();
                    },
                  ),

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

  Future<void> openMap() async {
String googleUrl = 'https://goo.gl/maps/eFi8a2QQ4gDs93Ng7';
if (await canLaunch(googleUrl)) {
await launch(googleUrl);
} else {
throw 'Could not open the map.';
}
}



DateTime currentBackPressTime;
