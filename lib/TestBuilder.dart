import 'package:flutter/material.dart';

class TestBuilder extends StatefulWidget {
  @override
  _TestBuilderState createState() => _TestBuilderState();
}

class _TestBuilderState extends State<TestBuilder> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Test Builder"),
        ),
        body: Center(
          child: Text("Test Body"),
        ),
        floatingActionButton: new Builder(builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              return Scaffold.of(context)
                  .showSnackBar(new SnackBar(content: Text("Snack Bar")));
            },
          );
        })
    );
  }
}