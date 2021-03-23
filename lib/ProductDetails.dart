import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/CartPage.dart';
import 'package:provider/provider.dart';
import 'package:shopping/SeeAllProduct.dart';
import 'package:shopping/cartModel.dart';
import 'package:shopping/myfun.dart';

class ProductDetails extends StatefulWidget {
  Map row;
  int index;
  String heroTag;
  String group;

  ProductDetails(Map row, int index, String group) {
    this.row = row;
    this.index = index;
    this.group = group;
    heroTag = row["image"] + index.toString() + group;
  }

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<Color> listColor = new List();
  List<String> listSize = new List();

  int selectedColor = -1;
  var selectedSize = -1;

  String heroTag;
  Map row;

  @override
  void initState() {
    addColor();
    addSize();
    heroTag = widget.heroTag;
    row = widget.row;
  }

  void addColor() {
    listColor.add(Colors.red);
    listColor.add(Colors.green);
    listColor.add(Colors.yellow);
    listColor.add(Colors.black);
    listColor.add(Colors.teal);
    listColor.add(Colors.blue);
  }

  void addSize() {
    listSize.add("4");
    listSize.add("5");
    listSize.add("6");
    listSize.add("7");
    listSize.add("8");
    listSize.add("9");
    listSize.add("10");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Hero(
                tag: heroTag,
                child: Image(
                  image: NetworkImage(url + row["image"]),
                  height: 500,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    height: 100,
                    width: 32,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 15,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 28,
                          width: 32,
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => CartPage()));
                            },
                            iconSize: 14,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade400),
                        ),
                        Container(
                          height: 12,
                          width: 10,
                          child: Center(child: Consumer<CartModel>(
                            builder: (context, cart, child) {
                              return Text(
                                cart.getList().length.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              );
                            },
                          )),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: productDetailsSection(row),
            )
          ],
        ),
      ),
    );
  }

  productDetailsSection(Map row) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 320,
      //width: 500,
      //color: Colors.red,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(row["p_name"]),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {},
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            alignment: Alignment.topLeft,
            child: Text(
              "Colour",
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 40),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return createColorItem(index);
              },
              itemCount: listColor.length,
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.only(left: 8),
            alignment: Alignment.topLeft,
            child: Text(
              "Size",
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 40),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return createSizeItem(index);
              },
              itemCount: listSize.length,
            ),
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
          RaisedButton(
            onPressed: () {
              var cart = context.read<CartModel>();
              cart.add(row);
            },
            color: Colors.green,
            padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(
              "Add To cart",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }

  GestureDetector createSizeItem(int index) {
    return GestureDetector(
      child: Container(
        child: Text(
          listSize[index],
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        height: 28,
        margin: EdgeInsets.all(4),
        width: 28,
        padding: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: selectedSize == index ? Colors.blue : Colors.grey,
                width: 1),
            shape: BoxShape.circle),
      ),
      onTap: () {
        setState(() {
          selectedSize = index;
        });
      },
    );
  }

  GestureDetector createColorItem(int index) {
    return GestureDetector(
      child: Container(
        height: 28,
        margin: EdgeInsets.all(4),
        width: 28,
        decoration: BoxDecoration(
            color: listColor[index],
            border: Border.all(
                color: Colors.grey, width: selectedColor == index ? 2 : 0),
            shape: BoxShape.circle),
      ),
      onTap: () {
        setState(() {
          selectedColor = index;
        });
      },
    );
  }
}
