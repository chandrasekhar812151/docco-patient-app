// ignore_for_file: prefer_is_empty

import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class ExperienceWidget extends StatelessWidget {
  final Doctor data;

  const ExperienceWidget(this.data, {super.key});

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
                      'Experience',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                data.experience?.length == 0
                    ? const Text('NA')
                    : _ExperienceFields(data.experience as List<Experience>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperienceFields extends StatefulWidget {
  const _ExperienceFields(this.list);

  final List<Experience> list;

  @override
  _ExperienceFieldsState createState() {
    return _ExperienceFieldsState();
  }
}

class _ExperienceFieldsState extends State<_ExperienceFields> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list.map((f) {
        return _ExperienceField(f);
      }).toList(),
    );
  }
}

class _ExperienceField extends StatelessWidget {
  final Experience data;

  const _ExperienceField(this.data);

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
                TextSpan(text: data.description),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
