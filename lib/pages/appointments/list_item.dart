// ignore_for_file: must_be_immutable

import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/pages/appointments/details/details_page.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Model {
  final Appointment data;

  String? fromTimeString;
  String? toTimeString;

  _Model(this.data) {
    DateTime fromTime = DateTime.parse(data.fromTime.toString()).toLocal();
    DateTime toTime = DateTime.parse(data.toTime.toString()).toLocal();
    fromTimeString = DateFormat('MMM dd\nhh:mm a').format(fromTime);
    toTimeString = DateFormat().format(toTime);
  }
}

class ListItem extends StatelessWidget {
  const ListItem(this.data, {super.key});

  final Appointment data;

  @override
  Widget build(BuildContext context) {
    final _Model m = _Model(data);

    return Stack(
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailsPage(data)));
            },
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.deepOrange.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          const Spacer(),
                          const Icon(Icons.videocam),
                          const SizedBox(height: 4),
                          Text(
                            m.fromTimeString.toString(),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: <Widget>[
                              ProfilePicture.circular(data.doctorPicture,
                                  radius: 30),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data.doctorName.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  const SizedBox(height: 4),
                                  Text('Physician',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 14, right: 14),
            child: _AppointmentStatus(data.status.toString()),
          ),
        ),
      ],
    );
  }
}

class _AppointmentStatus extends StatelessWidget {
  final String? status;
  _AppointmentStatus(this.status);

  String? statusDisplayText;

  Color _getColor()  {
    switch (status) {
      case 'completed':
        statusDisplayText = 'Completed';
        return Colors.green;
      case 'requested':
        statusDisplayText = 'Requested';
        return Colors.grey;
      case 'upcoming':
        statusDisplayText = 'Upcoming';
        return Colors.orange;          
      case 'cancelled_by_doctor':
      case 'cancelled_by_patient':
        statusDisplayText = 'Cancelled';
        return Colors.pink;
      default:
        statusDisplayText = status;
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color)),
      child: Text(
        capitalize(statusDisplayText!),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
