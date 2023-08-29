import 'package:doctor_patient/bloc/appointments_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/pages/appointments/details/details_page.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Model {
  final Appointment? data;

  String? fromTimeString;
  String? toTimeString;

  _Model(this.data) {
    DateTime fromTime = DateTime.parse(data!.fromTime.toString()).toLocal();
    DateTime toTime = DateTime.parse(data!.toTime.toString()).toLocal();
    fromTimeString = DateFormat('MMM dd\nhh:mm a').format(fromTime);
    toTimeString = DateFormat().format(toTime);
  }
}

class UpcomingAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<AppointmentsBloc>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return StreamBuilder<Appointment>(
      stream: bloc.upcomingAppointment,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error is DoccoException) {
            final DoccoException e = snapshot.error as DoccoException;
            if (e.getCode() == 404) {
              return Container();
            }
          } else {
            debugPrint(snapshot.error.toString());
            return Column(
              children: <Widget>[
                SizedBox(height: 4),
                Text('Error occurred while getting upcoming appointments , ${snapshot.error.toString()}'),
                SizedBox(height: 4),
                CustomErrorWidget(snapshot.error.toString(), onRetry: (){},),
              ],
            );
          }
        }

        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Upcoming Appointment',
                    style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black54)),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(snapshot.data as Appointment)
                    ));
                  },
                  child: _ListItem(snapshot.data as Appointment),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final Appointment data;

  _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    final _Model m = _Model(data);

    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: theme.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: <Widget>[
            Container(
              color: theme.primaryColor,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.videocam, color: Colors.white),
                  // SizedBox(height: 4),
                  Text(
                    m.fromTimeString.toString(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ProfilePicture.circular(data.doctorPicture, radius: 24),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data.doctorName.toString(), style: textTheme.titleLarge),
                            SizedBox(height: 4),
                            Text(data.doctorTitle.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
