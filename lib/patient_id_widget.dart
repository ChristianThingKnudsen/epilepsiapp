import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientIdWidget extends StatefulWidget {
  final String title;
  final Function(String) onSubmit;

  PatientIdWidget({this.title, this.onSubmit});

  @override
  _PatientIdWidgetState createState() => _PatientIdWidgetState();
}

class _PatientIdWidgetState extends State<PatientIdWidget> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    Function(String) onSubmit = widget.onSubmit;
    TextEditingController _controller = TextEditingController();
    _controller.text = "1680015";

    return AlertDialog(
      title: Text("$title"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Indtast patient id"),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: Text("Indsend"),
          onPressed: () {
            Navigator.pop(context);
            onSubmit(_controller.text);
          },
        )
      ],
    );
  }
}
