// ignore_for_file: prefer_is_empty, deprecated_member_use

import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class LanguagesWidget extends StatelessWidget {
  final Doctor data;

  const LanguagesWidget(this.data, {super.key});

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
                      'Languages',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                data.languages?.length == 0
                    ? const Text('NA')
                    : _LanguageChips(data.languages as List<Languages>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageChips extends StatefulWidget {
  const _LanguageChips(this.list);

  final List<Languages> list;

  @override
  _LanguageChipsState createState() {
    return _LanguageChipsState();
  }
}

class _LanguageChipsState extends State<_LanguageChips> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: widget.list.map((f) {
        return Chip(label: Text('${f.name}'));
      }).toList(),
    );
  }
}
