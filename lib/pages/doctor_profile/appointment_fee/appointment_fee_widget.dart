// ignore_for_file: library_private_types_in_public_api

import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/resources/prefs.dart';
import 'package:flutter/material.dart';

class AppointmentFeeWidget extends StatefulWidget {
  final Doctor data;

  const AppointmentFeeWidget(this.data, {super.key});

  @override
  _AppointmentFeeWidgetState createState() => _AppointmentFeeWidgetState();
}

class _AppointmentFeeWidgetState extends State<AppointmentFeeWidget> {
  final textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Appointment Fee',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              FutureBuilder(
                future: Prefs.getCurrency(),
                // initialData: '₹ ${widget.data.fee ?? "NA"}',
                builder: (context, snap) {
                  if (snap.data == 'INR') {
                    return Text(
                      '₹ ${widget.data.fee ?? "0"}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    );
                  } else if (snap.data == 'USD') {
                    return Text(
                      '\$ ${widget.data.fee_in_dollars ?? "0"}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    );
                  }

                  // show rupee as default
                  return Text(
                    '₹ ${widget.data.fee ?? "0"}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
