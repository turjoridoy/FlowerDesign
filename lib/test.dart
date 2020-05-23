import 'package:flutter/material.dart';
import 'package:wadaaro/Orders.dart';

import 'AllCategories.dart';
import 'CategoryList.dart';
import 'LogIn.dart';
import 'Model.dart';
import 'explore_widget.dart';
import 'navigation_bar.dart';

class FlowerPage extends StatefulWidget {
  static String tag = 'login_page';

  @override
  FlowerPageState createState() => new FlowerPageState();
}

User user = null;
bool Lang = true;

class FlowerPageState extends State<FlowerPage> {
  int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _children = [
    AllCategories(Lang),
    ExploreWidget(null),
    Orders(user),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: Lang ? TextDirection.rtl : TextDirection.ltr,
          child: _children[_page],
        ),
        bottomNavigationBar: Material(
          shadowColor: Colors.black,
          elevation: 10,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 70.0,
            items: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    'images/explore.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(Lang ? "أصنعها" : 'Make it'),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
              Container(
//            color: Colors.green,
                height: 90,
                constraints: BoxConstraints(minHeight: 90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      color: Colors.red,
                    ),
                    Lang
                        ? SizedBox(
                      height: 10,
                    )
                        : SizedBox(
                      height: 20,
                    ),
                    Text(Lang ? "يكتشف" : 'Explore'),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.menu,
                    color: Color(0xFF6B70DE),
                    size: 35,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(Lang ? "طلب" : 'Orders'),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
//          Image.asset(
//            'images/explore.png',
//            height: 10,
//            width: 10,
//          ),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.transparent,
            backgroundColor: Colors.white,
            onTap: (index) {
              if (index == 2) {
                if (user == null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      ));
                } else {
                  setState(() {
                    _page = index;
                  });
                }
              } else {
                setState(() {
                  _page = index;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((v) {
      setState(() {
        user = v;
      });
    });
    getLang().then((c) {
      setState(() {
        Lang = c;
      });
    });
  }
}
