import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping/CustomTextStyle.dart';
import 'package:shopping/Session.dart';
import 'package:shopping/cartModel.dart';
import 'package:shopping/myfun.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'bottom.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  String r_id = "";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text("SHOPPING CART"),
            margin: EdgeInsets.only(left: 12, top: 12),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text("Total(3) Items"),
            margin: EdgeInsets.only(left: 12, top: 4),
          ),
          Consumer<CartModel>(
            builder: (context, cart, child) {
              if (cart.getList().length == 0) {
                return Center(
                  child: Text("You have not added any item in cart,"),
                );
              }
              return Column(
                children: cart.getList().map((map) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: 8, right: 8, top: 8, bottom: 8),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  image: DecorationImage(
                                    image: NetworkImage(url + map["image"]),
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.only(right: 8, top: 4),
                                      child: Text(map["p_name"]),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      map["mrp"],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$299.00",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    //cart.add(map);
                                                    setState(() {
                                                      if (map["qty"] > 1) {
                                                        map["qty"] =
                                                            map["qty"] - 1;
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 24,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.grey.shade200,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 2,
                                                          right: 12,
                                                          left: 12),
                                                  child: Text(
                                                    map["qty"].toString(),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    //cart.add(map);
                                                    setState(() {
                                                      map["qty"]++;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 24,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              flex: 100,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              cart.remove(map);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.green),
                        ),
                      )
                    ],
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  "Total",
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  "\$299.00",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: RaisedButton(
              padding:
                  EdgeInsets.only(top: 12, left: 25, right: 25, bottom: 12),
              onPressed: () {

                createOrder();
              },
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                "CheckOut",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Bottom(2),
    );
  }

  void createOrder() async{
    String url = "http://192.168.1.17/shopping/order.php";

    CartModel cartModel = context.read<CartModel>();

    //print(cartModel.getList().toString());

    List cartItems = cartModel.getList();

    var bodyP = json.encode({
      "r_id": await FlutterSession().get("r_id"),
      "items": cartItems.map((e) {
        return {
          "p_id": e["p_id"],
          "quantity": e["qty"],
          "price": e["mrp"]
        };
      }).toList()
    });
    Map<String, String> headerParams = {"Content-type": "application/jason"};
    http.Response res = await http.post(url, body:bodyP , headers: headerParams);
    print( res.body);
    var cartJson = json.decode(res.body);
    print(cartJson["status"]);

    if(cartJson["status"]=="success"){
      cartModel.clearCart();
      showThankYouBottomSheet(context);
    }
   // print(bodyP);

    //cartModel.clearCart();
  }


  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("images/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    //Text("Thank you for your purchase1."),

                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                            "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: TextStyle(color: Colors.blueGrey),
                          )
                        ])),
                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }
}
