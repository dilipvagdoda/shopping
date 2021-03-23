import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/Session.dart';
import 'package:shopping/home.dart';
import 'package:shopping/signup.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //var list = [];

  String email = "";
  String pass = "";

  getlog() async {
    String url = "http://192.168.1.17/shopping/login.php";
    print("url" + url);
    //String url = "http://192.168.43.205/shopping/login.php";

   /* if (email == "") {
      email = "jp@gmail.com";
      pass = "123";
    }*/
    var bodyParam = json.encode({
      "email": email,
      "pass": pass,
    });
    print(bodyParam);
    Map<String, String> headerParams = {"Content-type": "application/jason"};
    http.Response res =
        await http.post(url, body: bodyParam, headers: headerParams);
    print("res.body" + res.body);
    /* setState(() {
      var data = jsonDecode(res.body);
    });*/
    var logJson = json.decode(res.body);
    print(logJson["status"]);

    if (logJson["status"] == "success") {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("r_id",logJson["data"]["r_id"]);
      Fluttertoast.showToast(
          msg: logJson["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);

      //MySession.r_id=logJson["data"]["r_id"];
      // MySession.r_name=logJson["data"]["r_name"];
      //MySession.email=logJson["data"]["email"];

      await FlutterSession().set("login_data", json.encode(logJson["data"]));


      //print(MySession.r_id);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Home()), (Route<dynamic> route) => false);

    } else {
      Fluttertoast.showToast(
          msg: logJson["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(children: <Widget>[
            Image(
                image: AssetImage("images/ic_logo.png"),
                color: Colors.blue,
                height: 100,
                alignment: Alignment.center,
                width: 100),
            TextFormField(
              onChanged: (String Value) {
                email = Value;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                labelText: "Mobile No. or Email",
              ),
            ),
            TextFormField(
              onChanged: (String Value) {
                pass = Value;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                labelText: "Password",
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: RaisedButton(
                onPressed: () {
                  getlog();
                },
                child: Text("Login"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: RaisedButton(
                onPressed: () {
                  Get.to(SignUp());

                  //getlog();
                },
                child: Text("SIGNUP"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }



}
