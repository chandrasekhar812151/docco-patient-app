import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget(this.data, {super.key});

  final Doctor data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Overview', style: Theme.of(context).textTheme.bodyLarge,
                    // .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
              Text(data.overview ?? 'NA'),
            ],
          ),
        ),
      ),
    );
  }
}
