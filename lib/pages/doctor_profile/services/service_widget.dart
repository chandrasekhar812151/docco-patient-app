// ignore_for_file: prefer_is_empty

import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class ServicesWidget extends StatelessWidget {
  final Doctor data;

  const ServicesWidget(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Services',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                data.services?.length == 0
                    ? const Text('NA')
                    : _ServiceFields(data.services as List<Services>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceFields extends StatefulWidget {
  const _ServiceFields(this.list);

  final List<Services> list;

  @override
  _ServiceFieldsState createState() {
    return _ServiceFieldsState();
  }
}

class _ServiceFieldsState extends State<_ServiceFields> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list.map((f) {
        return _ServiceField(f);
      }).toList(),
    );
  }
}

class _ServiceField extends StatelessWidget {
  final Services data;

  const _ServiceField(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkWell(
          onTap: () {

          },
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.5,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: data.name),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
