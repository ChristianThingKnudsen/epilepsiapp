import 'package:epilepsi_app/patient_id_widget.dart';
import 'package:flutter/material.dart';

import 'patient_home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _patientId = "6";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          "Epilepsi App",
          style: TextStyle(fontSize: 30, color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 70,
                child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        child: PatientIdWidget(
                          title: "Patient ID",
                          onSubmit: (value) {
                            _patientId = value;
                            Navigator.pushNamed(context, "/patient",
                                arguments: PatientHome(patientId: _patientId));
                          },
                        ));
                  },
                  child: Text("Patient",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              SizedBox(height: 60),
              SizedBox(
                width: 300,
                height: 70,
                child: RaisedButton(
                  color: Colors.green,
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
            ],
          ),
        ),
      ),
    );
  }
}
