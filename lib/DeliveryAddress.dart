import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wadaaro/Language.dart';
import 'package:wadaaro/Model.dart';

import 'Success.dart';
import 'Model.dart';

final nameController = TextEditingController();
final addressController = TextEditingController();
final phoneController = TextEditingController();

class DeliveryAddress extends StatefulWidget {
  static String tag = 'login_page';
  ProductListModel flower;
  int DeliveryType;
  bool Language;

  DeliveryAddress(this.flower, this.DeliveryType,this.Language);

  @override
  DeliveryAddressState createState() => new DeliveryAddressState();
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class DeliveryAddressState extends State<DeliveryAddress> {
  int _page = 0;
  int _current = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  List<ProductListModel> entry;
  int length = 0;
  var event_types;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.white,
                actions: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  )
                ],
                title: Text(
                  'Order Summary',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Center(
                child: Container(
                  child: Container(
                      margin: EdgeInsets.only(left: 4, top: 8),
                      decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: new BorderRadius.all(
                            Radius.circular(12.0),
                          )),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 16, right: 16),
                        child: Container(
                          height: 10000,
                          width: (MediaQuery.of(context).size.width - 30),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: 200,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color(0xFF5956F0),
                                        Color(0xFF5956F0)
                                      ]),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          topLeft: Radius.circular(32))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Delivery',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Information',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 80,
                                child: Container(
                                  height: 300,
//                                    margin: EdgeInsets.only(top: 16),
                                  padding: EdgeInsets.all(8),
                                  width:
                                      (MediaQuery.of(context).size.width - 40) /
                                          2,
                                  decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Colors.blue,
//                                    Colors.lightBlue
//                                  ]
//                              ),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ListTile(
                                          title: Text('Name'),
                                          subtitle: Text('Reciever'),
                                          trailing: Container(
                                            child: TextField(
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                    hintText: "Ahmed",
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300))),
                                            width: 200,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text('Addess'),
                                          subtitle: Text('Full Home'),
                                          trailing: Container(
                                            child: TextField(
                                                controller: addressController,
                                                decoration: InputDecoration(
                                                    hintText: "Kayo st.",
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300))),
                                            width: 200,
                                          ),
                                        ),
                                        ListTile(
                                          title: Text('Number'),
                                          subtitle: Text('Number'),
                                          trailing: Container(
                                            child: TextField(
                                                controller: phoneController,
                                                decoration: InputDecoration(
                                                    hintText: "0756...",
                                                    hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300))),
                                            width: 200,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 400,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFEB300),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                        },
                                        color: Colors.white,
                                        child: Container(
                                            width: 150,
                                            height: 40,
                                            child: GestureDetector(
                                              child: Center(
                                                child: Text(
                                                  widget.Language?"إصدار أمر":'Make An Order',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black87),
                                                ),
                                              ),
                                              onTap: () {

                                              },
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)))),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}

class FlowerCard extends StatelessWidget {
  final String title, count, imagePath;

  FlowerCard(
    this.title,
    this.count,
    this.imagePath,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.blue, Colors.lightBlue]),
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Mixed Tulip Flowers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 40,
              child: Container(
                height: 190,
//                                    margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(8),
                width: (MediaQuery.of(context).size.width - 40) / 2,
                decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Colors.blue,
//                                    Colors.lightBlue
//                                  ]
//                              ),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Image.asset(
                          imagePath,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'price here',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
