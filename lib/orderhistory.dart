import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/CustomTextStyle.dart';
import 'package:http/http.dart' as http;

class OederHistory extends StatefulWidget {
  @override
  _OederHistoryState createState() => _OederHistoryState();
}

class _OederHistoryState extends State<OederHistory> {
  List order_list = [];
  List order_dtl_list = [];

  gethis() async {
    String url = "http://192.168.1.17/shopping/orderhistory.php";
    //String url = "http://192.168.43.205/shopping/orderhistory.php";
    http.Response res = await http.post(url);
    print(res.body);
    var jsonObj = jsonDecode(res.body);

    setState(() {
      order_list = jsonObj["order_list"];
      order_dtl_list = jsonObj["order_dtl_list"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: order_list.map((e) {
      return Card(
        child: Column(
          children: [
            Text(e["order_id"]),
            Text(e["order_date"]),
            Divider(
              height: 1,
              color: Colors.red,
            ),
            Column(
              children: order_dtl_list
                  .where((element) => element["order_id"] == e["order_id"])
                  .toList()
                  .map((e1) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(e1["p_id"]),
                        Text(e1["quantity"]),
                        Text(e1["price"]),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    }).toList())

        /*ListView.builder(
            itemCount: order_list.length,
            itemBuilder: (BuildContext ctx, int index) {
              return Column(children: <Widget>[
                Card(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(order_list[index]["order_date"]),
                    margin: EdgeInsets.only(left: 12, top: 12),
                  ),

                ),

              ]);
            })*/
        );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      gethis();
    });
  }
}
