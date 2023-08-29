// ignore_for_file: prefer_is_empty

import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class MembershipsWidget extends StatelessWidget {
  final Doctor data;

  const MembershipsWidget(this.data, {super.key});

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
                      'Memberships',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 8),
                data.memberships?.length == 0
                    ? const Text('NA')
                    : _MembershipFields(data.memberships as List<Memberships>),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MembershipFields extends StatefulWidget {
  const _MembershipFields(this.list);

  final List<Memberships> list;

  @override
  _MembershipFieldsState createState() {
    return _MembershipFieldsState();
  }
}

class _MembershipFieldsState extends State<_MembershipFields> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.list.map((f) {
        return _MembershipField(f);
      }).toList(),
    );
  }
}

class _MembershipField extends StatelessWidget {
  final Memberships data;

  const _MembershipField(this.data);

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
