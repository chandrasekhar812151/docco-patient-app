// ignore_for_file: prefer_is_empty

import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class AwardsWidget extends StatelessWidget {
  final Doctor data;

  const AwardsWidget(this.data, {super.key});

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
                      'Awards',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                data.awards?.length == 0
                    ? const Text('NA')
                    : _AwardFields(data.awards as List<Awards>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AwardFields extends StatefulWidget {
  const _AwardFields(this.list);

  final List<Awards> list;

  @override
  _AwardFieldsState createState() {
    return _AwardFieldsState();
  }
}

class _AwardFieldsState extends State<_AwardFields> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list.map((f) {
        return _AwardField(f);
      }).toList(),
    );
  }
}

class _AwardField extends StatelessWidget {
  final Awards data;

  const _AwardField(this.data);

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
