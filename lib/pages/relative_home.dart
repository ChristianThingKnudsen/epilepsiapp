import 'package:flutter/material.dart';

class RelativeHome extends StatefulWidget {
  @override
  _RelativeHomeState createState() => _RelativeHomeState();
}

class _RelativeHomeState extends State<RelativeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.cyanAccent[300],
      centerTitle: true,
      title: Text(
        "Pårørende",
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    ));
  }
}
