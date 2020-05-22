import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:wadaaro/API.dart';

import 'FlowerList.dart';
import 'Model.dart';

class CategoryList extends StatefulWidget {
  static String tag = 'login_page';

  bool Language;

  CategoryList(this.Language);

  @override
  CategoryListState createState() => new CategoryListState();
}

class CategoryListState extends State<CategoryList> {
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
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body:





      Directionality(
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
          margin: EdgeInsets.only(left: 8),
          height: 1000,
          width: MediaQuery.of(context).size.width,
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
          width: ((MediaQuery.of(context).size.width - 20) / 2) - 4,
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
