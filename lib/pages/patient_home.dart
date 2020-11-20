import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:http/http.dart';

class PatientHome extends StatefulWidget {
  final String patientId;

  PatientHome({Key key, this.patientId}) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  String _patName = "";
  String _patId = "";
  String _patBirth = "";

  List<String> _sysList = [];
  List<String> _diaList = [];

  @override
  Widget build(BuildContext context) {
    final PatientHome arguments =
        ModalRoute.of(context).settings.arguments as PatientHome;

    String patientId = arguments.patientId;

    Map<String, dynamic> _parsedPat;
    Map<String, dynamic> _parsedObs;

    const server = 'http://hapi.fhir.org/baseR4';
    const headers = {'Content-type': 'application/json'};

    var _newPatient = Patient(
      resourceType: 'Patient',
      name: [
        HumanName(family: 'Gore', given: ['Al'])
      ],
      birthDate: Date('1948-03-31'),
      gender: PatientGender.male,
    );

    void _getBP(Map<String, dynamic> bp, int length) {
      for (var i = 0; i < length; i++) {
        String sys = (bp["entry"][i]["resource"]["component"][0]
                ["valueQuantity"]["value"])
            .toString();
        _sysList.add(sys);
        String dia = (bp["entry"][i]["resource"]["component"][1]
                ["valueQuantity"]["value"])
            .toString();
        _diaList.add(dia);
        setState(() {});
      }
    }

    Future _getPatient() async {
      var desiredResource = 'Patient';
      var url = '$server/$desiredResource/$patientId';
      print("URL: " + url);
      var response = await get(url, headers: headers);

      var searchSetPatient = Patient.fromJson(json.decode(response.body));
      _parsedPat = searchSetPatient.toJson();

      _patId = _parsedPat["id"];
      print("Pat id: " + _patId.toString());

      _patBirth = _parsedPat["birthDate"];

      var given = (_parsedPat["name"][0]["given"]).join(" ");

      setState(() {
        _patName = given + " " + _parsedPat["name"][0]["family"];
      });
      print("Name: " + _patName);
    }

    Future _getObservation() async {
      var desiredResource = 'Observation';
      var url = '$server/$desiredResource?patient=Patient/$patientId';
      print("URL: " + url);
      var response = await get(url, headers: headers);

      //final Map<String, dynamic> parsed = json.decode(response.body);
      var searchSetBundle = Bundle.fromJson(json.decode(response.body));
      print("Length: " + (searchSetBundle.entry.length).toString());
      _parsedObs = searchSetBundle.toJson();

      _getBP(_parsedObs, searchSetBundle.entry.length);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          "Patient",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        _getPatient();
                      },
                      child: Text("Get patient",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ),
                  ),
                ),
                Divider(height: 0),
                Ink(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      "Name: " + _patName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Divider(height: 0),
                Ink(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      "ID: " + _patId,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Divider(height: 0),
                Ink(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      "Birth date: " + _patBirth,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Divider(height: 0),
                if (_patName == "Al Gore")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(
                              image: AssetImage("assets/al_gore.png"))),
                    ),
                  ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        _getObservation();
                      },
                      child: Text("Get observation",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.5,
                      child: ListView.builder(
                          itemCount: _sysList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Divider(height: 0),
                                Ink(
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      "Blodtryk: " +
                                          _sysList[index] +
                                          "/" +
                                          _diaList[index],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Divider(height: 0),
                              ],
                            );
                          }),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
