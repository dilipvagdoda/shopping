import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:shopping/home.dart';
import 'package:shopping/profile.dart';

import 'CartPage.dart';

class Bottom extends StatefulWidget {
  int selectedIndex;

  Bottom(this.selectedIndex);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      items: [
        BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Get.to(Home());
                },
                child: Icon(Icons.home)),
            title: Text("Home")),
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
    );
  }
}
