import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:shopping/home.dart';
import 'package:shopping/login.dart';




class Splash extends StatelessWidget {
  checkAutoLogin(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString("r_id");

    if (userId == null || userId == "") {

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Login()), (Route<dynamic> route) => false);
      //Get.to(Login());
    } else {
      print("userId " + userId);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Home()), (Route<dynamic> route) => false);
      //Get.to(Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    checkAutoLogin(context);
    return Scaffold(body: Center(child: Text("Loading")));
  }
}