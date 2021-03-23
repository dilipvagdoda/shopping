import 'package:flutter/material.dart';

class GoogleMap extends StatefulWidget{
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar: AppBar(
  title: Text("map"),
),
    );
  }
}