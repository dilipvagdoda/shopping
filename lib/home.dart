import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/CartPage.dart';
import 'package:shopping/ProductDetails.dart';
import 'package:shopping/SeeAllProduct.dart';
import 'package:shopping/myfun.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/profile.dart';

import 'bottom.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _save() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("mydata", "dilip");
  }

  GlobalKey<ScaffoldState> _globalScaffoldkey = new GlobalKey();
  List listproduct = [];
  List listdashbord = [];

  //List<String> listImage = new List();
  //List<String> listShoesImage = new List();
  int selectedSliderPosition = 0;

  @override
  void initState() {
    super.initState();
    //sliderImage();
    //shoesImage();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //getdata();
      loadData();
      //getdashborddata();
    });
  }

  //
  // void sliderImage() {
  //   listImage.add("images/slider_img.webp");
  //   listImage.add("images/slider_img.webp");
  //   listImage.add("images/slider_img.webp");
  // }
  //
  // void shoesImage() {
  //   listShoesImage.add("images/shoes_1.png");
  //   listShoesImage.add("images/shoes_2.png");
  //   listShoesImage.add("images/shoes_3.png");
  //   listShoesImage.add("images/shoes_4.png");
  //   listShoesImage.add("images/shoes_5.png");
  //   listShoesImage.add("images/shoes_6.png");
  //   listShoesImage.add("images/shoes_7.png");
  // }
  SharedPreferences prefs;

  loadData() async {
    prefs = await _prefs;
    String dataStr = prefs.getString("data");
    //print("dataStr" + dataStr);
    if (dataStr != null && dataStr != "") {
      setState(() {
        var data = jsonDecode(dataStr);
        listdashbord = data["dashboardList"];
        listproduct = data["productList"];
      });
    }
    getdashborddata();
  }

  getdata() async {
    _globalScaffoldkey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 30),
        content: new Row(
          children: [CircularProgressIndicator(), Text("   Loading")],
        )));
    String url = "http://192.168.1.17/shopping/product.php";
    http.Response res = await http.get(url);
    print(res.body);
    setState(() {
      _globalScaffoldkey.currentState.hideCurrentSnackBar();
      listproduct = jsonDecode(res.body);
    });
  }

  getdashborddata() async {
    var connectivityResult = await new Connectivity().checkConnectivity();
    //print(connectivityResult.toString());
    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      Fluttertoast.showToast(
          //msg: "Record inserted successfully",
          msg: "Please check your internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    _globalScaffoldkey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 30),
        content: new Row(
          children: [CircularProgressIndicator(), Text("   Loading")],
        )));
    String url = "http://192.168.1.17/shopping/d_image.php";
    http.Response res = await http.get(url);
    print(res.body);
    setState(() {
      var data = jsonDecode(res.body);

      prefs.setString("data", res.body);

      listdashbord = data["dashboardList"];
      listproduct = data["productList"];
      _globalScaffoldkey.currentState.hideCurrentSnackBar();
      //getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalScaffoldkey,
      backgroundColor: Colors.grey.shade100,

      /*bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Search")),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Get.to(CartPage());
                },
                child: Icon(Icons.shopping_cart)),
            title: Text("Cart"),
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Get.to(Profile());
                  },
                  child: Icon(Icons.person)),
              title: Text("Account")),
        ],
        backgroundColor: Colors.grey.shade100,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),*/
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.lightBlueAccent,
                  height: height / 6,

                  padding: const EdgeInsets.only(
                      top: 24, right: 14, left: 24, bottom: 25),
                  //margin: const EdgeInsets.only(top: 25, right: 0, left: 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Search",
                            enabledBorder: CustomBorder.enabledBorder.copyWith(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            contentPadding: EdgeInsets.only(
                                top: 16, left: 12, right: 12, bottom: 8),
                            border: CustomBorder.enabledBorder.copyWith(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            enabled: false,
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: (height / 4) + 25,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: (height / 4) + 50,
                      child: PageView.builder(
                        itemBuilder: (context, position) {
                          return createSlider(listdashbord[position]);
                        },
                        controller: PageController(viewportFraction: .8),
                        itemCount: listdashbord.length,
                        onPageChanged: (position) {
                          /*setState(() {
                              selectedSliderPosition = position;
                            });*/
                        },
                      ),
                    )),
                Container(
                  height: 20,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 10,
                    child: PageView.builder(
                      itemBuilder: (context, position) {
                        return createSlider(listdashbord[position]);
                      },
                      controller: PageController(viewportFraction: .8),
                      itemCount: listdashbord.length,
                      onPageChanged: (position) {
                        /*setState(() {
                              selectedSliderPosition = position;
                            });*/
                      },
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GROUP BY"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeeAll()));
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "SEE All",
                                ),
                              ),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: (listproduct.length == 0)
                      ? SizedBox(
                          height: 1,
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return createGroupBuyListItem(
                                listproduct[index], index, "GB");
                          },
                          itemCount: listproduct.length,
                        ),
                ),
                SizedBox(height: 2),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("MOST BIG"),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("SEE ALL"),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return createGroupBuyListItem(
                          listproduct[index], index, "MB");
                    },
                    itemCount: listproduct.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Bottom(0),
    );
  }

  createSlider(Map row) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Container(
        child: CachedNetworkImage(
          imageUrl: url + row["d_image"],
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Colors.blue.shade200,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //placeholder: (context, url) => CircularProgressIndicator(),
          //errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  createGroupBuyListItem(Map row, int index, String group) {
    print("--------------------------row=" + index.toString() + row.toString());
    double leftMargin = 0;
    double rightMargin = 0;
    if (index != listproduct.length - 1) {
      leftMargin = 10;
    } else {
      leftMargin = 10;
      rightMargin = 10;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(row, index, group)));
      },
      child: Container(
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: row["image"] + index.toString() + group,
                child: Container(
                  width: 200,
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: url + row["image"],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: Colors.blue.shade200,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //placeholder: (context, url) => CircularProgressIndicator(),
                    //errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              flex: 75,
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: EdgeInsets.only(left: leftMargin, right: rightMargin),
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      row["p_name"],
                    ),
                    Text(
                      row["p_descr"],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBorder {
  static var enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.grey));

  static var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: ThemeData.light().primaryColor, width: 1));

  static var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.red, width: 1));
}
