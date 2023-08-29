// ignore_for_file: library_private_types_in_public_api, prefer_is_empty

import 'package:doctor_patient/bloc/appointments_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/pages/appointments/list_item.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {

  var bloc = sl<AppointmentsBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.getAppointments(fromCache: false);
    return Scaffold(
      body: StreamBuilder<List<Appointment>>(
        stream: bloc.appointments,
        builder: (context, snapshot) {                  
          if (snapshot.hasError) {
            return CustomErrorWidget(snapshot.error.toString(), onRetry: () {
              setState(() {});
            },);
          }

          if (snapshot.hasData) {
            if (snapshot.data?.length == 0) {
              return const Center(
                child: Text('You have no appointments'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) => ListItem(snapshot.data![index]),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
