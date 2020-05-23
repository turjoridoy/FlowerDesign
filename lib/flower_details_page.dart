import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:wadaaro/Choose.dart';
import 'package:wadaaro/Model.dart';

import 'LogIn.dart';
import 'config/constant.dart';

class FlowerDetails extends StatefulWidget {
  static String tag = 'flower_details';
  bool Lang;
  User user;
  final ProductListModel flowerListModel;

  FlowerDetails(this.flowerListModel, this.Lang);

  @override
  FlowerDetailsState createState() => new FlowerDetailsState();
}

bool isArabic = true;

class FlowerDetailsState extends State<FlowerDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          isArabic ? "ملخص الطلب" : "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Center(
          child: Container(
//            color: Colors.red,
            margin: EdgeInsets.only(left: 8),
            constraints: BoxConstraints(maxHeight: 42),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(32)),
            width: 42,
//            padding: EdgeInsets.all(9),
            child: BackButton(
              color: Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Container(
//              color: Colors.grey,
              constraints: BoxConstraints(maxHeight: 42),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(32)),
              width: 42,
              //Share.share('check out my website https://example.com');
              child: GestureDetector(
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
//                size: 16,
                  ),
                  onTap: () {
                    Share.share(
                        'check out ${widget.flowerListModel.name_en} from this app wwww.play.google.com/id=flower.app');
                  }),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFFF9C00), Color(0xFFFFB101)]),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 400,
//                color: Colors.red,
                  width: (MediaQuery.of(context).size.width - 40),
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 160,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black87, Colors.black87]),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(32),
                                  topLeft: Radius.circular(32))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 16),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child:

//                              Text(
//                                widget.flowerListModel.name_en + "\nBouquets",
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontSize: 14,
//                                    fontWeight: FontWeight.w500
//                                ),
//                              ),
                                      RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: isArabic
                                                ? widget.flowerListModel.name_ar
                                                : widget
                                                    .flowerListModel.name_en,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),

                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 50,
                        child: Container(
                          height: 350,
                          padding: EdgeInsets.all(8),
                          width: (MediaQuery.of(context).size.width - 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${widget.flowerListModel.image.contains('18.221') ? widget.flowerListModel.image : '$baseURL${widget.flowerListModel.image}'}'),
                                    fit: BoxFit.fill)),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
//                            child: Image.asset(
//                              'images/sm_flower.png',
//                              height: 40,
//                              width: 40,
//                            ),
//                          ),
//                        ],
//                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.all(1.0),
                  child: Text(
                    "${isArabic ? widget.flowerListModel.description_ar : widget.flowerListModel.description_en} ",
                    style: TextStyle(fontWeight: isArabic?FontWeight.normal:FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFFFF9C00), Color(0xFFFFB101)]),
        ),
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 37,
                  width: 108,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFB101),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.white.withOpacity(0.5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity += 1;
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                      Container(
                          width: 38,
                          child: Center(
                              child: Text(
                            "$quantity",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity -= 1;
                            if (quantity < 0) {
                              quantity = 0;
                            }
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  isArabic
                      ? '\n${quantity * widget.flowerListModel.price} \$  مجموع'
                      : "Total\n${quantity * widget.flowerListModel.price} \$",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {
                if(quantity>0){

                  if (widget.user == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Choose(widget.flowerListModel,quantity, widget.Lang)),
                    );
                  }
                }else{
                  Toast.show(widget.Lang?"الرجاء اختيار كمية صالحة!":"Please choose valid quantity !", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                }
              },
              color: Colors.white,
              height: 48,
              minWidth: MediaQuery.of(context).size.width - 64,
              elevation: 5,
              child: Text(
                isArabic ? 'إصدار أمر' : "Make an Order",
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang().then((l) {
      setState(() {
        isArabic = l;
      });
    });

    getUser().then((u) {
      setState(() {
        widget.user = u;
      });
    });
  }
}
