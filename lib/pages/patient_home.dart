import 'package:flutter/material.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.cyanAccent[300],
      centerTitle: true,
      title: Text(
        "Patient",
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    ));
  }
}
