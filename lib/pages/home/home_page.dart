import 'package:doctor_patient/bloc/appointments_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/pages/home/widgets/categories_widget.dart';
import 'package:doctor_patient/pages/home/widgets/top_doctors_widget.dart';
import 'package:doctor_patient/pages/home/widgets/upcoming_appointment.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = sl<AppointmentsBloc>();
    bloc.getUpcomingAppointment();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UpcomingAppointment(),
          SizedBox(height: 8),
          CategoriesWidget(),
          SizedBox(height: 8),
          TopDoctorsWidget(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
