// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/pages/doctor_profile/appointment_fee/appointment_fee_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/awards/awards_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/basic_info_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/education/education_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/experience/experience_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/languages_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/location/location_info_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/memberships/memberships_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/overview/overview_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/services/service_widget.dart';
import 'package:doctor_patient/pages/doctor_profile/specializations_widget.dart';
import 'package:doctor_patient/pages/network_error_page.dart';
import 'package:doctor_patient/pages/slots/slots_wizard.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  final int? doctorId;
  final Doctor? doctor;

  const DoctorProfile({super.key, this.doctorId, this.doctor});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<DoctorProfile> {

  Future<Doctor?> _getDoctor() async {
    if (widget.doctorId != null && widget.doctor == null) {
      return await Repository.getDoctorProfile(widget.doctorId!.toInt());
    }

    if (widget.doctor != null) {
      return widget.doctor;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FutureBuilder<Doctor?>(
      future: _getDoctor(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error is SocketException) {
            return NetworkErrorPage(onRetry: () {
              setState(() {});
            });
          } else {
            return CustomErrorWidget(snapshot.error.toString(),onRetry: () {
              setState(() {});
            });
          }
        }

        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Doctor Profile'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text(
                    'NEXT',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SlotsWizard(widget.doctor ?? snapshot.data!),
                      ),
                    );
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  BasicInfoWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  AppointmentFeeWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  SpecializationsWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  OverviewWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  ServicesWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  LanguagesWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  EducationWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  ExperienceWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  MembershipsWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  AwardsWidget(snapshot.data!),
                  const SizedBox(height: 16),
                  LocationInfoWidget(snapshot.data!),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Column(
              children: <Widget>[
                LinearProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
