import 'dart:async';
import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as ints;
import 'package:wadaaro/Model.dart';

import 'constant.dart';

class Orders extends StatefulWidget {
  static String tag = 'alarm_list';
  User user;

  Orders(this.user);

  @override
  TrackingHistoryState createState() => new TrackingHistoryState();
}

class TrackingHistoryState extends State<Orders> {
  List<OrderModel> entry = new List<OrderModel>();

  bool Language = false;

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      itemCount: entry.length,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            decoration: new BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
            child: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Text(
                        Language
                            ? entry[index].product.nameAr
                            : entry[index].product.nameEn,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 8, bottom: 2),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(24.0),
                          )),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 16,
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                  height: 25,
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: new BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(12.0),
                                      )),
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: new BoxDecoration(
                                            color: Color(0xFF403EE7),
                                            shape: BoxShape.circle,
                                          ),
                                          height: 24,
                                          child: Center(
                                            child: Icon(
                                              Icons.event_note,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          width: 24,
                                        ),
                                        SizedBox(
                                          height: 10,
                                          width: 10,
                                        ),
                                        Text(
                                          getDate(DateTime.parse(
                                              entry[index].date)),
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  )),
                              flex: 3,
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                  height: 25,
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: new BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(12.0),
                                      )),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: new BoxDecoration(
                                          color: Color(0xFF403EE7),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 24,
                                        child: Center(
                                          child: Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        width: 24,
                                      ),
                                      SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        '99F${entry[index].id}',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  )),
                              flex: 3,
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                  height: 25,
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: new BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(12.0),
                                      )),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: new BoxDecoration(
                                          color: Color(0xFF403EE7),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 24,
                                        child: Center(
                                          child: Icon(
                                            Icons.attach_money,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        width: 24,
                                      ),
                                      SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                      Text(
                                        '${entry[index].product.price} IQD',
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  )),
                              flex: 3,
                            ),
                            SizedBox(
                              height: 16,
                              width: 16,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Scaffold(
          backgroundColor: Color(0xfff8fafe),
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius:
                    new BorderRadius.only(bottomLeft: Radius.circular(30))),
            centerTitle: true,
            title: Text(
              Language ? "طلب" : 'Orders',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
          body: Directionality(
            textDirection: Language ? TextDirection.rtl : TextDirection.ltr,
            child: entry == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : entry.length < 1
                    ? getEmpty(context)
                    : Container(
                        child: _myListView(context),
                        margin: EdgeInsets.only(bottom: 32),
                      ),
          ),
        ),
      ],
    );
  }

  Future<List<OrderModel>> getPosts() async {
    final responseBody = (await http.get(
      '$baseURL/flower/api/orderget/',
    ))
        .bodyBytes;

    // The response body is an array of items
    print(json.decode(utf8.decode(responseBody)));
    return OrderModel.fromJsonList(json.decode(utf8.decode(responseBody)));
  }

  @override
  void initState() {
    super.initState();

    getUser().then((v){
      getPosts().then((V) {
        setState(() {
          for (int i = V.length - 1; i > 0; i--) {
            if (V[i].user.id == v.id) {
              setState(() {
                entry.add(V[i]);
              });
            }
          }
        });
      });
      getLang().then((v) {
        setState(() {
          Language = v;
        });
      });
    });

  }

  Widget getEmpty(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: new FlareActor("assets/empty.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "empty"),
            ),
          ),
          Text(
//            widget ? 'কোন তথ্য পাওয়া যায়নি।' : 'Information not available !',
            '',
            style: TextStyle(color: Color(0xFF715DF1), fontSize: 20),
          )
        ],
      ),
    );
  }
}

String getDate(DateTime timestamp) {
  final f = new ints.DateFormat('hh:mm a');
  return f.format(timestamp.add(Duration(hours: 3)));
}

enum ConfirmAction { CANCEL, ACCEPT }
