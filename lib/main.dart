import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping/CartPage.dart';
import 'package:shopping/ProductDetails.dart';
import 'package:shopping/SeeAllProduct.dart';
import 'package:shopping/TestBuilder.dart';
import 'package:shopping/cartModel.dart';
import 'package:shopping/home.dart';
import 'package:shopping/login.dart';
import 'package:shopping/orderhistory.dart';
import 'package:shopping/profile.dart';
import 'package:shopping/signup.dart';
import 'package:shopping/splash.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image(
            image: AssetImage("images/ic_logo.png"),
            height: 140,
            width: 140,
          ),
        ),
      ),
    );
  }








