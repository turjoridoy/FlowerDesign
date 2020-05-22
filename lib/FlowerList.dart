import 'dart:convert' as convert;

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'API.dart';
import 'constant.dart';
import 'flower_details_page.dart';
import 'Model.dart';

class FlowerListWidget extends StatefulWidget {
  static String tag = 'login_page';
  final CategoryModel categoryModel;
  bool Language;
  FlowerListWidget(this.categoryModel, this.Language);

  @override
  FlowerListWidgetState createState() => new FlowerListWidgetState();
}

class FlowerListWidgetState extends State<FlowerListWidget> {
  List<ProductListModel> _list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFlowerFromCategory(widget.categoryModel.id).then((f){
      setState(() {
        _list =  f;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        title: Text('${widget.Language?widget.categoryModel.nameAr:widget.categoryModel.name}',style: TextStyle(color: Colors.black87)
        ),
      ),


      body:



      Directionality(
        textDirection:isArabic?  TextDirection.rtl:TextDirection.ltr,
        child: _list == null
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
//                     color: Colors.red,
            padding: EdgeInsets.all(16.0),
            child: _list == null
                ? Container()
                : Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[],
                ),
                for (int i = 0;
                i <= (_list.length / 2).floor();
                i += 2)
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                    transitionDuration: Duration(
                                        milliseconds: 300),
                                    pageBuilder: (_, __, ___) =>
                                        FlowerDetails(
                                          _list[i],widget.Language
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
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black87,
                                              Colors.black87
                                            ]),
                                        border: Border.all(
                                            color: Colors.grey
                                                .withOpacity(
                                                0.5)),
                                        borderRadius:
                                        BorderRadius.only(
                                            topRight: Radius
                                                .circular(32),
                                            topLeft: Radius
                                                .circular(
                                                32))),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                          width: 8,
                                        ),
                                        Text(
                                          "${widget.Language? _list[i].name_ar: _list[i].name_en}"
                                          ,
                                          style: TextStyle(
                                              color: Colors.white,
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
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.grey
                                                .withOpacity(
                                                0.5)),
                                        borderRadius:
                                        BorderRadius.only(
                                            bottomLeft: Radius
                                                .circular(32),
                                            bottomRight:
                                            Radius
                                                .circular(
                                                32))),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "${_list[i].price} IQD",
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
                                                .withOpacity(
                                                0.5)),
                                        borderRadius:
                                        BorderRadius.circular(
                                            20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${_list[i].image.contains('18.221')?_list[i].image:'$baseURL${_list[i].image}'}'),
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
                                    pageBuilder: (_, __,
                                        ___) =>
                                        FlowerDetails(
                                          _list[i + 1],widget.Language
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
                                              Colors.blue,
                                              Colors
                                                  .lightBlue
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

                                          "${widget.Language? _list[i+1].name_ar: _list[i+1].name_en}"  ,
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
                                          "${_list[i + 1].price} IQD",
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
                                                '${_list[i+1].image.contains('18.221')?_list[i].image:'$baseURL${_list[i+1].image}'}',),
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
                        )
                            : Container(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),





    );
  }
}
