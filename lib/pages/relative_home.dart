import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:http/http.dart';

class RelativeHome extends StatefulWidget {
  final String patientId;

  RelativeHome({this.patientId});

  @override
  _RelativeHomeState createState() => _RelativeHomeState(patId: patientId);
}

class _RelativeHomeState extends State<RelativeHome> {
  final String patId;

  _RelativeHomeState({this.patId});

  String _patName = "";
  String _patId = "";
  String _patBirth = "";

  List<String> _sysList = [];
  List<String> _diaList = [];

  final ScrollController _scrollController = ScrollController();

  Map<String, dynamic> _parsedPat;
  Map<String, dynamic> _parsedObs;

  final server = 'http://hapi.fhir.org/baseR4';
  final headers = {'Content-type': 'application/json'};

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
      String sys = (bp["entry"][i]["resource"]["component"][0]["valueQuantity"]
              ["value"])
          .toString();
      _sysList.add(sys);
      String dia = (bp["entry"][i]["resource"]["component"][1]["valueQuantity"]
              ["value"])
          .toString();
      _diaList.add(dia);
      setState(() {});
    }
  }

  Future _getPatient() async {
    var desiredResource = 'Patient';
    var url = '$server/$desiredResource/$patId';
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
    var url = '$server/$desiredResource?patient=Patient/$patId';
    print("URL: " + url);
    var response = await get(url, headers: headers);

    //final Map<String, dynamic> parsed = json.decode(response.body);
    var searchSetBundle = Bundle.fromJson(json.decode(response.body));
    print("Length: " + (searchSetBundle.entry.length).toString());
    _parsedObs = searchSetBundle.toJson();

    _getBP(_parsedObs, searchSetBundle.entry.length);
  }

  @override
  void initState() {
    _getPatient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          "Pårørende",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Divider(height: 0),
          Row(
            children: [
              Flexible(
                child: Ink(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      "Name: " + _patName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              if (_patName == "Al Gore")
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          image: DecorationImage(
                              image: AssetImage("assets/al_gore.png"))),
                    ),
                  ),
                ),
            ],
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
        ],
      ),
    );
  }
}
