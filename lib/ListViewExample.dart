import 'package:flutter/material.dart';

class ListViewExample extends StatefulWidget {
  @override
  _ListViewExampleState createState() => _ListViewExampleState();
}

class _ListViewExampleState extends State<ListViewExample> {

  List<Widget> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 1000; i++) {
      list.add(ListTile(
        leading: Icon(Icons.circle),
        title: Text("Title"),
        subtitle: Text("Sub"),
        trailing: Icon(Icons.arrow_back),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Example"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return getTile(index);
        },
      ),
    );
  }

  getTile(int index) {
    print(index);
    return list[index];
  }
}
