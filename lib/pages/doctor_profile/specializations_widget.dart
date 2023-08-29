import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class SpecializationsWidget extends StatelessWidget {
  const SpecializationsWidget(this.data, {super.key});

  final Doctor data;

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
                      'Specializations',
                      style: Theme.of(context).textTheme.bodyLarge,
                      // .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _SpecializtionChips(data.specializations as List<Specializations>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpecializtionChips extends StatelessWidget {
  const _SpecializtionChips(this.list);

  final List<Specializations> list;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: list.map((f) {
        return Chip(
          label: Text('${f.name}'),
        );
      }).toList(),
    );
  }
}
