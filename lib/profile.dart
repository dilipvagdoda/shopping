import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shopping/CustomTextStyle.dart';
import 'package:shopping/Session.dart';
import 'package:shopping/bottom.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        child: Stack(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(top: 40, left: 16, right: 16),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Column(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.settings),
                          iconSize: 24,
                          color: Colors.black,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.black,
                          iconSize: 24,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    r_name,
                    style: CustomTextStyle.textFormFieldBlack.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    email,
                    style: CustomTextStyle.textFormFieldMedium
                        .copyWith(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("images/ic_user_profile.png"),
                        fit: BoxFit.contain)),
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottom(3),
    );
  }

  String email = "";
  String r_name = "";

  @override
  void initState() {
    super.initState();
    FlutterSession().get("login_data").then((logJson) {
      setState(() {
        email = logJson["email"];
        r_name = logJson["r_name"];
      });
    });
  }
}
