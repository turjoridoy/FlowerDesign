import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:wadaaro/API.dart';
import 'package:wadaaro/test.dart';

import 'Model.dart';
import 'constant.dart';
import 'flower_details_page.dart';
import 'navigation_bar.dart';

class FlowerSearch extends StatefulWidget {
  static String tag = 'login_page';
  final String name, id;
  bool isArabic;

  FlowerSearch(this.id, this.name, this.isArabic);

  @override
  FlowerSearchState createState() => new FlowerSearchState();
}

class FlowerSearchState extends State<FlowerSearch> {
  List<ProductListModel> _list = new List<ProductListModel>();
  List<ProductListModel> mainList = new List<ProductListModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllFlowers().then((f) {
      setState(() {
        mainList = f;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
          body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 8,
              width: 8,
            ),
            Container(
              height: 50,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.grey[100],
                  icon: Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  label: Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                        onChanged: (v) {
                          _list.clear();
                          if (v.length < 1) {

                          } else {
                            for (int i = 0; i < mainList.length; i++) {
                              if (mainList[i].name_en.toLowerCase().contains(v.toLowerCase()) ||
                                  mainList[i].name_ar.contains(v) ||
                                  mainList[i].description_en.toLowerCase().contains(v.toLowerCase())) {
                                setState(() {
                                  _list.add(mainList[i]);
                                });
                              }
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: widget.isArabic ? 'بحث' : 'Search',
                          border: InputBorder.none,
                        )),
                  ),
                ),
              ),
              margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
            ),
            _list == null
                ? Center(
                    child: Container(
                      height: 300,
                      color: Colors.white,
                      width: 300,
                      child: FlareActor("images/empty.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "empty"),
                    ),
                  )
                : _list.length == 0
                    ? Center(
                        child: Container(
                          color: Colors.white,
                          height: 300,
                          width: 300,
                          child: FlareActor("images/empty.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "empty"),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16.0),
                          child: _list == null
                              ? Container()
                              : Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[],
                                    ),
                                    for (int i = 0;
                                        i <= (_list.length / 2).floor();
                                        i += 2)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                print("tapped $i");
                                                Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    300),
                                                        pageBuilder:
                                                            (_, __, ___) =>
                                                                FlowerDetails(
                                                                      _list[i],isArabic
                                                                )));
                                              },
                                              child: Container(
                                                height: 270,
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
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
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  Colors.black87,
                                                                  Colors
                                                                      .black87
                                                                ]),
                                                            border: Border.all(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        0.5)),
                                                            borderRadius: BorderRadius.only(
                                                                topRight:
                                                                    Radius.circular(
                                                                        32),
                                                                topLeft:
                                                                    Radius.circular(
                                                                        32))),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 8,
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "${widget.isArabic ? _list[i].name_ar : _list[i].name_en}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                                            color: Colors
                                                                .transparent,
                                                            border: Border.all(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        0.5)),
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        32),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        32))),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              "${_list[i].price} \$",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                40) /
                                                            2,
                                                        decoration:
                                                            BoxDecoration(
                                                                //                              gradient: LinearGradient(
                                                                //                                  colors: [
                                                                //                                    Colors.blue,
                                                                //                                    Colors.lightBlue
                                                                //                                  ]
                                                                //                              ),
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      '${_list[i].image.contains('18.221') ? _list[i].image : '$baseURL${_list[i].image}'}'),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0,
                                                                        top:
                                                                            8.0),
                                                                child:
                                                                    Image.asset(
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
                                            i < _list.length - 1
                                                ? GestureDetector(
                                                    onTap: () {
                                                      print("tapped ${i + 1}");
                                                      Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                              transitionDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          300),
                                                              pageBuilder: (_,
                                                                      __,
                                                                      ___) =>
                                                                  FlowerDetails(
                                                                        _list[i +
                                                                            1],isArabic
                                                                  )));
                                                    },
                                                    child: Container(
                                                      height: 270,
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
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
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                        Colors
                                                                            .black87,
                                                                        Colors
                                                                            .black87
                                                                      ]),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5)),
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              32),
                                                                      topLeft:
                                                                          Radius.circular(32))),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                    height: 8,
                                                                    width: 8,
                                                                  ),
                                                                  Text(
                                                                    "${widget.isArabic ? _list[i + 1].name_ar : _list[i + 1].name_en}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
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
                                                                  color: Colors
                                                                      .transparent,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5)),
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              32),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              32))),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    "${_list[i + 1].price} \$",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
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
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              width: (MediaQuery.of(
                                                                              context)
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
                                                                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                                                  borderRadius: BorderRadius.circular(20)),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(20),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                          '${_list[i + 1].image.contains('18.221') ? _list[i+1].image : '$baseURL${_list[i + 1].image}'}',
                                                                        ),
                                                                        fit: BoxFit.fill)),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8.0,
                                                                          top:
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'images/sm_flower.png',
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            40,
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
                      ),
          ],
        ),
      bottomNavigationBar: Material(
        shadowColor: Colors.black,
        elevation: 10,
        child: CurvedNavigationBar(
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
                Text('Explore'),
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
                  SizedBox(
                    height: 20,
                  ),
                  Text('Make it'),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.menu, color: Colors.grey, size: 30),
                SizedBox(
                  height: 8,
                ),
                Text('Orders'),
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
            setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlowerPage(),
                    ));

            });
          },
        ),
      ),


    );
  }
}
