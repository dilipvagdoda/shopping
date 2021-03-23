import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/login.dart';

class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
 // List list = [];

  String r_name = "";
  String m_no = "";
  String email = "";
  String pass = "";



  getres() async {
     String url = "http://192.168.1.17/shopping/registration.php";
    //String url = "http://192.168.43.205/shopping/registration.php";

    var bodyParam = json.encode({
      "r_name": r_name,
      "m_no": m_no,
      "email": email,
      "pass": pass,

    });
    print(bodyParam);
    Map<String, String> headerParams = {"Content-type": "application/jason"};
    http.Response res = await http.post(url, body:bodyParam , headers: headerParams);
    //print("res.body" + res.body);
     print( res.body);
   /* setState(() {
      var data = jsonDecode(res.body);
    });*/
    var resJson = json.decode(res.body);
    print(resJson["status"]);

    if(resJson["status"]=="success"){
      Fluttertoast.showToast(
          msg: resJson["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Get.to(Login());
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body:  ListView(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(top: 200,left: 10,right: 10),
             child: Column(
               children: [
                 TextFormField(
                   onChanged: (String Value) {
                     r_name = Value;
                   },
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                     labelText: "Name",
                   ),
                 ),
                 TextFormField(
                   onChanged: (String Value) {
                     m_no = Value;
                   },
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                     labelText: "Mobile Number",
                   ),
                 ),
                 TextFormField(
                   onChanged: (String Value) {
                     email = Value;
                   },
                   decoration: InputDecoration(
                     contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                     labelText: "Email",
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
                 SizedBox(height: 20),
                 Container(
                   child: RaisedButton(
                     onPressed: () {

                      /* Navigator.of(context).push(new MaterialPageRoute(
                           builder: (context) => Login()));*/
                       getres();
                     },
                     child: Text("SIGNUP"),
                     color: Colors.blue,
                     textColor: Colors.white,
                   ),
                 ),
               ],
             ),
           ),
     ]),
     );

  }

  @override
  void initState() {
    super.initState();
    //addImage();
    //getdata();
  }
}