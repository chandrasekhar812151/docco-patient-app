import 'package:doctor_patient/models/doctor.dart';
import 'package:flutter/material.dart';

class LocationInfoWidget extends StatelessWidget {
  const LocationInfoWidget(this.data, {super.key});

  final Doctor data;

  @override
  Widget build(context) {
    var addressText = 'NA';

    if (data.address != null) {
      addressText =
          '${data.address?.plotNo}, ${data.address?.street}, ${data.address?.city} - ${data.address?.postalCode}';
    }

    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Location',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(addressText),
            ],
          ),
        ),
      ),
    );
  }
}
