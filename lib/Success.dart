import 'package:flutter/material.dart';
import 'package:wadaaro/test.dart';

class Success extends StatefulWidget {
  static String tag = 'login_page';
  bool Lang;
  Success(this.Lang);
  @override
  SuccessState createState() => new SuccessState();
}

class SuccessState extends State<Success> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlowerPage()),
              );

            },
          ),
          centerTitle: true,
          title: Text(
           Lang?"أجل النجاح" :'Order Success',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Container(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 32,
                  width: 32,
                ),
                Center(
                  child: Image.asset(
                    'images/orderdone.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                Text(
                Lang?"من أجل النجاح!":  'Order Succesful !',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                MaterialButton(
                  onPressed: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlowerPage()),
                    );
                  },
                  color: Colors.white,
                  height: 48,
                  minWidth: MediaQuery.of(context).size.width - 64,
                  elevation: 5,
                  child: Text(
                  Lang?"استكشاف المزيد" : "Explore More",
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.all(Radius.circular(25))

                  ),
                ),
              ],
            ),
          ),
        ));
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
