import 'package:epilepsi_app/pages/login.dart';
import 'package:epilepsi_app/pages/patient_home.dart';
import 'package:epilepsi_app/pages/relative_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      // initialRoute: Login,
      routes: {
        "/login": (context) => LoginPage(),
        "/relative": (context) => RelativeHome(),
        "/patient": (context) => PatientHome(),
      },
    );
  }
}
