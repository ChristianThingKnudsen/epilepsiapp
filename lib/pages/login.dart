import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent[300],
        centerTitle: true,
        title: Text(
          "Epilepsi app",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(height: 60),
              SizedBox(
                width: 300,
                height: 70,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/relative");
                  },
                  child: Text("Pårørende",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              SizedBox(height: 60),
              SizedBox(
                width: 300,
                height: 70,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/patient");
                    print("Hey patient");
                  },
                  child: Text("Patient",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
