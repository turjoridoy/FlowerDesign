import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:wadaaro/API.dart';

import 'FlowerList.dart';
import 'Model.dart';

class AllCategories extends StatefulWidget {
  static String tag = 'login_page';

  bool Language;

  AllCategories(this.Language);

  @override
  AllCategoriesState createState() => new AllCategoriesState();
}

class AllCategoriesState extends State<AllCategories> {
  List<CategoryModel> _listCategory = new List<CategoryModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories().then((c) {
      setState(() {

        for(int i=0;i<c.length;i++){

          print('asd');
          if(c[i].id<22 || c[i].id>25){
            setState(() {
              print('asd');
              _listCategory.add(c[i]);
            });
          }
        }

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,

        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Directionality(
        textDirection:widget.Language?  TextDirection.rtl:TextDirection.ltr,
        child:  _listCategory == null
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
            : _listCategory.length == 0
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
            : Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2),
            itemCount: _listCategory.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: CategoryWidget(_listCategory[index], context),
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FlowerListWidget(_listCategory[index],widget.Language)),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget CategoryWidget(CategoryModel categoryModel, context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 90,
          margin: EdgeInsets.only(top: 4),
          width: ((MediaQuery.of(context).size.width - 20) / 2) - 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                  image: NetworkImage(categoryModel.image), fit: BoxFit.fill)),
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
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
              color: Colors.black87),
        )
      ],
    );
  }
}
