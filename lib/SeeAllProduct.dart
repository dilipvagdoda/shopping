import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopping/CartPage.dart';
import 'package:shopping/cartModel.dart';
import 'dart:convert';

import 'package:shopping/myfun.dart';

class SeeAll extends StatefulWidget {
  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  List list = [];

  //List<String> listImage = new List();
  List<Color> listItemColor = new List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //addImage();
    getdata();
  }

  getdata() async {
    String url = "http://192.168.1.17/shopping/product.php";
    http.Response res = await http.get(url);
    print("res.body" + res.body);
    setState(() {
      list = jsonDecode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("GROUP BY"),
          elevation: 1,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 44),
            child: Container(
              color: Colors.white,
              child: Row(children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.filter_list),
                      ),
                      Text("Filter")
                    ],
                  ),
                ),
                divider(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.sort),
                      ),
                      Text("Sort")
                    ],
                  ),
                ),
                divider(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.list),
                      ),
                      Text("List")
                    ],
                  ),
                ),
              ]),
            ),
          ),
          actions: [
            Image(
              image: AssetImage("images/ic_search.png"),
              color: Colors.white,
              width: 48,
              height: 16,
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 24,
                  ),
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => CartPage()));
                  },
                  iconSize: 12,
                ),
                Container(
                  height: 16,
                  width: 18,
                  child: Center(child: Consumer<CartModel>(
                    builder: (context, cart, child) {

                      return Text(
                        cart.getList().length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      );
                    },
                  )),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
              ],
            )
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Builder(builder: (context) {
          return Container(
            color: Colors.grey.shade100,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.68),
              itemBuilder: (context, i) {
                return gridItem(context, i);
              },
              itemCount: list.length,
            ),
          );
        }));
  }

  gridItem(BuildContext context, int position) {
    return GestureDetector(
      onTap: () {
        //filterBottomSheetContent();
        filterBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: Colors.grey.shade200)),
        padding: EdgeInsets.only(left: 10, top: 10),
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 12),
              alignment: Alignment.topRight,
              child: Container(
                alignment: Alignment.center,
                width: 24,
                height: 24,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.indigo),
                child: Text(
                  "30%",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 9),
                  //style: Color : Colors.white, fontSize: 10,
                ),
              ),
            ),
            Image(
              image: NetworkImage(url + list[position]['image']),
              height: 170,
              fit: BoxFit.none,
            ),
            gridBottomView(position)
          ],
        ),
      ),
    );
  }

  gridBottomView(int position) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              list[position]["p_name"],
              //style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 12),
              textAlign: TextAlign.start,
            ),
            alignment: Alignment.topLeft,
          ),
          //Utils.getSizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                list[position]["price"],
              ),
              //Utils.getSizedBox(width: 8),
              Text(
                list[position]["mrp"],
              ),
            ],
          ),
          //Utils.getSizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlutterRatingBar(
                initialRating: 4,
                itemSize: 14,
                itemCount: 5,
                fillColor: Colors.amber,
                borderColor: Colors.amber.withAlpha(50),
                allowHalfRating: true,
                onRatingUpdate: (rating) {},
              ),
              //Utils.getSizedBox(width: 4),
              Text(
                "4.5",
              ),
            ],
          )
        ],
      ),
    );
  }

  filterBottomSheet(BuildContext context) {
    _scaffoldKey.currentState.showBottomSheet(
      (context) {
        return filterBottomSheetContent();
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
    );
  }

  filterBottomSheetContent() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.close,
              ),
              Text(
                "Filter",
              ),
              Text(
                "Reset",
              ),
            ],
          ),
          Container(
            child: Text("Price Range"),
            margin: EdgeInsets.only(left: 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Minimum",
                      contentPadding: EdgeInsets.only(
                          right: 8, left: 8, top: 12, bottom: 12),
                    ),
                  ),
                ),
                flex: 47,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 4),
                  height: 1,
                  color: Colors.grey,
                ),
                flex: 6,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 4),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Maximum",
                      contentPadding: EdgeInsets.only(
                          right: 8, left: 8, top: 12, bottom: 12),
                    ),
                  ),
                ),
                flex: 47,
              ),
            ],
          ),
          Container(
            child: Text(
              "Item Filter",
            ),
            margin: EdgeInsets.only(left: 4),
          ),
          ListView.builder(
            primary: false,
            itemBuilder: (context, position) {
              return Container(
                margin: EdgeInsets.only(top: 4, bottom: 4, left: 4),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Discount",
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.indigo,
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            },
            itemCount: 3,
            shrinkWrap: true,
          ),
          Container(
            child: Text("Item Color"),
            margin: EdgeInsets.only(left: 4),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 30),
            child: ListView.builder(
              primary: false,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4, left: 4),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                );
              },
              shrinkWrap: true,
            ),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(
                "Apply Filter",
              ),
            ),
            color: Colors.indigo,
          ),
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: 2,
      color: Colors.grey.shade400,
      height: 20,
    );
  }
}
