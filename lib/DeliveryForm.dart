import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wadaaro/Model.dart';
import 'package:wadaaro/credit_card.dart';
import 'package:wadaaro/test.dart';

import 'API.dart';
import 'Language.dart';
import 'Model.dart';
import 'Success.dart';
import 'config/constant.dart';

class DeliveryForm extends StatefulWidget {
  static String tag = 'flower_details';

  ProductListModel flowerListModel;
  int type;
  int quantity;
  bool Lang = true;
  User user = null;



  DeliveryForm(this.flowerListModel, this.quantity, this.type, this.Lang);

  @override
  DeliveryFormState createState() => new DeliveryFormState();
}

class DeliveryFormState extends State<DeliveryForm> {
  final nameController = TextEditingController();
  String _error;
  bool isPaid = false;
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String cardNumber = '';
  String month = '';
  String year = '';

  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((u) {
      setState(() {
        widget.user = u;
        print(u.email);
      });
    });

    //stripe
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Container(
          child: BackButton(
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.Lang ? "ملخص الطلب" : "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

      ),
      body: Directionality(
        textDirection: widget.Lang ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          color: Colors.amber,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 370,
                  width: (MediaQuery.of(context).size.width - 40),
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 16,
                        right: 0,
                        height: 160,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF403EE7),
                                Color(0xFF6B68F5)
                              ]),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(32),
                                  topLeft: Radius.circular(32))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 12,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Image.asset(
                                  'images/bg_flower.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  widget.Lang
                                      ? 'توصيل' + "\nمعلومات"
                                      : 'Delivery' + "\nInformation",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 0,
                        top: 40,
                        child: Container(
                          height: 300,
                          padding: EdgeInsets.all(8),
                          width: (MediaQuery.of(context).size.width - 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(Lang ? "اسم" : 'Name'),
                                  subtitle: Text(Lang ? "المتلقي" : "Receiver"),
                                  trailing: Container(
                                    child: TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                            hintText: Lang ? "أحمد" : "Ahmed",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w300))),
                                    width: 200,
                                  ),
                                ),
                                ListTile(
                                  title: Text(Lang ? "عنوان" : 'Addess'),
                                  subtitle:
                                      Text(Lang ? "منزل كامل" : 'Full Home'),
                                  trailing: Container(
                                    child: TextField(
                                        controller: addressController,
                                        decoration: InputDecoration(
                                            hintText:
                                                Lang ? "أنت ش." : "Kayo st.",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w300))),
                                    width: 200,
                                  ),
                                ),
                                ListTile(
                                  title: Text(Lang ? "رقم" : 'Number'),
                                  subtitle: Text(Lang ? "رقم" : 'Number'),
                                  trailing: Container(
                                    child: TextField(
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                            hintText: "0756...",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w300))),
                                    width: 200,
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.amber,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            MaterialButton(
              onPressed: () {
//
                makeTheOrder(
                    widget.flowerListModel,
                    widget.type,
                    nameController.text,
                    addressController.text,
                    phoneController.text,
                    false);
              },
              color: Colors.white,
              height: 48,
              minWidth: MediaQuery.of(context).size.width - 64,
              elevation: 5,
              child: Text(
                widget.Lang ? "التالى" : "Cash On Delivery",
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            SizedBox(
              height: 8,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CreditCards(widget.Lang)),
                );


//                makePayment(cardNumber, month, year, cvvCode,
//                        widget.flowerListModel.price * widget.quantity)
//                    .then((res) {
//                  if (res.statusCode == 200) {
//                    makeTheOrder(
//                        widget.flowerListModel,
//                        widget.type,
//                        nameController.text,
//                        addressController.text,
//                        phoneController.text,
//                        true);
//                  }
//                });
              },
              color: Colors.white,
              height: 48,
              minWidth: MediaQuery.of(context).size.width - 64,
              elevation: 5,
              child: Text(
                widget.Lang ? "قم بالدفع" : "Make Payement",
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  Future makeTheOrder(ProductListModel flower, int deliveryType, String name,
      String address, String phone, bool isPaid) async {
    var client = new http.Client();
    try {
      var body = {
        'product': widget.flowerListModel.id,
        'delivery_type': widget.type == 0 ? 'Pick Up' : 'Home Delivery',
        'name': name,
        'quantity': widget.quantity,
        'address': address,
        'phone': phone,
        'image': '${flower.image}',
        'user': widget.user.id,
        'is_paid': isPaid
      };
      var response = await client.post('$baseURL/flower/api/order/',
          body: json.encode(body),
          headers: {'content-type': 'application/json; charset=utf-8'});
      print(body);
      if (response.statusCode == 201) {
        print("Order success");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Success(Lang)),
        );
      }
      print(response.body);
    } finally {
      client.close();
    }
  }
}
