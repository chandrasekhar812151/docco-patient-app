// ignore_for_file: prefer_is_empty

import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

import '../../appointments/details/details_page.dart';

class EducationWidget extends StatelessWidget {
  final Doctor data;

  const EducationWidget(this.data, {super.key});

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
                      'Education',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                data.education?.length == 0
                    ? const Text('NA')
                    : _EducationFields(data.education as List<Education>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EducationFields extends StatefulWidget {
  const _EducationFields(this.list);

  final List<Education> list;

  @override
  _EducationFieldsState createState() {
    return _EducationFieldsState();
  }
}

class _EducationFieldsState extends State<_EducationFields> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list.map((f) {
        return _EducationField(f);
      }).toList(),
    );
  }
}

class _EducationField extends StatelessWidget {
  final Education data;

  const _EducationField(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              height: 1.5,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: '${capitalize(data.degreeLevel.toString())}\'s degree in '),
              TextSpan(
                  text: data.specialization,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const TextSpan(text: '\nfrom '),
              TextSpan(
                  text: data.institution,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
