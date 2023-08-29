import 'package:flutter/material.dart';

class PrescriptionsPage extends StatefulWidget {
  _PrescriptionsPageState createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Prescriptions page'),
          ),
          body: Container(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                children: <Widget>[],
              ),
            ),
          ),
        );
  }
}