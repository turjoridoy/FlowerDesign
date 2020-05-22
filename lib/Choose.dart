import 'package:flutter/material.dart';
import 'package:wadaaro/DeliveryForm.dart';
import 'package:wadaaro/Model.dart';

import 'DeliveryAddress.dart';

class Choose extends StatefulWidget {
  static String tag = 'login_page';
  ProductListModel flower;
  bool Lang;
  int quantity;
  Choose(this.flower,this.quantity,this.Lang);

  @override
  ChooseState createState() => new ChooseState();
}

class ChooseState extends State<Choose> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body:

      Directionality(
    textDirection:widget.Lang?  TextDirection.rtl:TextDirection.ltr,
      child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('images/choose.png'),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Image.asset('images/pick.png'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryForm(this.widget.flower,widget.quantity,0,widget.Lang)),
                );
              },
            ),
            GestureDetector(
              child: Image.asset('images/deli.png'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryForm(widget.flower,widget.quantity,1,widget.Lang)),
                );
              },
            ),
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
                    '25,000 IQD',
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
