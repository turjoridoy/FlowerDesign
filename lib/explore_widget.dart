import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wadaaro/API.dart';
import 'package:wadaaro/AboutUs.dart';
import 'package:wadaaro/CategoryList.dart';
import 'package:wadaaro/FlowerList.dart';
import 'package:wadaaro/FlowerSearch.dart';
import 'package:wadaaro/Language.dart';
import 'package:wadaaro/LogIn.dart';
import 'package:wadaaro/Model.dart';
import 'package:wadaaro/test.dart';

import 'ContactUs.dart';
import 'flower_details_page.dart';



class ExploreWidget extends StatefulWidget {
  bool Language = true;
  User user;
    List<String> imgList = [
    'https://www.beautycolorcode.com/cdcdcd-2880x1800.png'
  ];
  ExploreWidget(this.user);

  @override
  ExploreWidgetState createState() => new ExploreWidgetState();
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

void _settingModalBottomSheet(user, context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: new Wrap(
            children: <Widget>[
              user != null
                  ? GestureDetector(
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            user.name,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      onTap: () {},
                    )
                  : Container(),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey.withOpacity(0.27),
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Lang ? "اتصل بنا" : 'Contact Us',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(Lang),
                      ));
                },
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey.withOpacity(0.27),
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Lang ? "لغة" : 'Language',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Language(),
                      ));
                },
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey.withOpacity(0.27),
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Lang ? "حول" : 'About',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(Lang),
                      ));
                },
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueGrey.withOpacity(0.27),
              ),
              user == null
                  ? GestureDetector(
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Lang ? "تسجيل الدخول" : 'Log In',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogIn(),
                            ));
                      },
                    )
                  : GestureDetector(
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Lang ? "تسجيل خروج" : 'Log Out',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      onTap: () {
                        saveUser(null);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FlowerPage(),
                            ));
                      },
                    )
            ],
          ),
        );
      });
}

class ExploreWidgetState extends State<ExploreWidget> {
  AsyncSnapshot snapshotData;
  List<ProductListModel> _listFlower = new List<ProductListModel>();
  List<CategoryModel> _listCategory = new List<CategoryModel>();
  int _current = 0;



  @override
  void initState() {
    super.initState();
    getAllFlowers().then((v) {
      setState(() {
        _listFlower = v;
      });
    });
    getSliders().then((SliderList) {
      setState(() {
        widget.imgList.clear();
      });

      for (int i = 0; i < SliderList.length; i++) {
        setState(() {
          widget.imgList.add(SliderList[i].image);
        });
      }
    });

    getCategories().then((c) {
      setState(() {
        for (int i = 0; i < c.length; i++) {
          print('asd');
          if (c[i].id < 22 || c[i].id > 25) {
            setState(() {
              print('asd');
              _listCategory.add(c[i]);
            });
          }
        }
      });
    });

    getUser().then((v) {
      setState(() {
        widget.user = v;
      });
    });

    getLang().then((V) {
      setState(() {
        widget.Language = V;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 180,
          pinned: true,
          leading: GestureDetector(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FlowerSearch('22', 'Bouquet', widget.Language)),
                );
              }),
          flexibleSpace: Stack(fit: StackFit.expand, children: [
            CarouselSlider(
              items:   map<Widget>(
                widget.imgList,
                    (index, i) {
                  return Container(
//        margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      child: Stack(children: <Widget>[
                        Image.network(
                          i,
                          fit: BoxFit.fitWidth,
                          width: 1000.0,
                        ),
                      ]),
                    ),
                  );
                },
              ).toList(),
//                autoPlay: true,
              viewportFraction: 1.0,
//                aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            Positioned(
              bottom: 8.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                  widget.imgList,
                  (index, url) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _current == index ? Colors.white : Colors.grey),
                    );
                  },
                ),
              ),
            )
          ]),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                _settingModalBottomSheet(widget.user, context);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                ),
                width: 40,
                child: Icon(
                  Icons.more_horiz,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
//
//          SliverPersistentHeader(
//              pinned: true,
//              delegate: _SliverAppBarDelegate()),

        SliverList(
            delegate: SliverChildListDelegate([

          Divider(
            height: 0,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[

                SizedBox(
                  height: 10,
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.Language
                          ? 'تسوق حسب المناسبات'
                          : 'Shop By Categories',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Center(
                        child: GestureDetector(
                          child:
                              Text(widget.Language ? 'عرض الكل' : 'View All'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryList(widget.Language)),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                _listCategory.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CategoryWidget(_listCategory[0], context),
                          SizedBox(
                            width: 8,
                            height: 8,
                          ),
                          CategoryWidget(_listCategory[1], context),
                        ],
                      )
                    : Container(),
                _listCategory.length > 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CategoryWidget(_listCategory[2], context),
                          SizedBox(
                            height: 8,
                            width: 8,
                          ),
                          CategoryWidget(_listCategory[3], context),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            color: Colors.white,
            height: _listFlower.length < 1
                ? 0
                : (_listFlower.length / 2).floor() * 270 + 90.0,
//                     color: Colors.red,
            padding: EdgeInsets.all(16.0),
            child: _listFlower.length < 1
                ? Container()
                : Column(
                    children: <Widget>[

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.Language ? 'أوامر شعبية' : 'Popular Orders',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      for (int i = 0;
                          i <= (_listFlower.length / 2).floor();
                          i += 2)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print("tapped $i");
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 300),
                                          pageBuilder: (_, __, ___) =>
                                              FlowerDetails(_listFlower[i],
                                                  widget.Language)));
                                },
                                child: Container(
                                  height: 270,
                                  width:
                                      (MediaQuery.of(context).size.width - 40) /
                                          2,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: <Widget>[
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        height: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.black87,
                                                Colors.black87
                                              ]),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(32),
                                                  topLeft:
                                                      Radius.circular(32))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 8,
                                                width: 8,
                                              ),
                                              Text(
                                                widget.Language
                                                    ? _listFlower[i].name_ar
                                                    : _listFlower[i].name_en,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        height: 50,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(32),
                                                  bottomRight:
                                                      Radius.circular(32))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "${_listFlower[i].price} \$",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 8,
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
                                          height: 200,
                                          //                                    margin: EdgeInsets.only(top: 16),
                                          padding: EdgeInsets.all(8),
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40) /
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
                                                  color: Colors.grey
                                                      .withOpacity(0.5)),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${_listFlower[i].image}'),
                                                    fit: BoxFit.fill)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 8.0),
                                                  child: Image.asset(
                                                    'images/sm_flower.png',
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              i < _listFlower.length - 1
                                  ? GestureDetector(
                                      onTap: () {
                                        print("tapped ${i + 1}");
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    Duration(milliseconds: 300),
                                                pageBuilder: (_, __, ___) =>
                                                    FlowerDetails(
                                                        _listFlower[i + 1],
                                                        widget.Language)));
                                      },
                                      child: Container(
                                        height: 270,
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    40) /
                                                2,
                                        child: Stack(
                                          fit: StackFit.loose,
                                          children: <Widget>[
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              height: 60,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black87,
                                                          Colors.black87
                                                        ]),
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.5)),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(32),
                                                            topLeft:
                                                                Radius.circular(
                                                                    32))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 8,
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      widget.Language
                                                          ? _listFlower[i + 1]
                                                              .name_ar
                                                          : _listFlower[i + 1]
                                                              .name_en,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              height: 50,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.5)),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(32),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    32))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      "${_listFlower[i + 1].price} \$",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
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
                                                height: 200,
                                                //                                    margin: EdgeInsets.only(top: 16),
                                                padding: EdgeInsets.all(8),
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        40) /
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
                                                        color: Colors.grey
                                                            .withOpacity(0.5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              '${_listFlower[i + 1].image}'),
                                                          fit: BoxFit.fill)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                top: 8.0),
                                                        child: Image.asset(
                                                          'images/sm_flower.png',
                                                          height: 40,
                                                          width: 40,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
          Divider(
            height: 0,
          ),
//          Container(
//
          SizedBox(
            height: 50,
          )
        ]))
      ],
    );
  }

  Widget CategoryWidget(CategoryModel categoryModel, context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            height: 90,
            margin: EdgeInsets.only(top: 4),
            width: ((MediaQuery.of(context).size.width - 40) / 2) - 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                    image: NetworkImage(categoryModel.image),
                    fit: BoxFit.fill)),
          ),
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 4),
            width: (MediaQuery.of(context).size.width - 40) / 4,
            child: Center(
              child: Text(
                widget.Language ? categoryModel.nameAr : categoryModel.name,
                style: TextStyle(color: Colors.amber),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30)),
                color: Colors.black87),
          )
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FlowerListWidget(categoryModel, widget.Language)),
        );
      },
    );
  }
}
