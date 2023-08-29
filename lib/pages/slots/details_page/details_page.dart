import 'dart:io';

import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:doctor_patient/pages/slots/details_page/widgets/medical_report.dart';
import 'package:doctor_patient/pages/slots/details_page/widgets/symptoms/symptoms.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final issueCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();
    return StreamBuilder<SlotsModel>(
      stream: bloc.slots,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final model = snapshot.data;

        return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  onChanged: ((s) {
                    bloc.setIssue(s);
                  }),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      labelText: 'Reason for appointment*',
                      hintText: 'Enter reason',
                      helperText: '* Required'),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                Symptoms(),
                SizedBox(height: 16),
                TextField(
                  // controller: usernameCtrl,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    labelText: 'Current medical conditions',
                    hintText: 'Enter current medical conditions',
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: 16),
                TextField(
                  // controller: usernameCtrl,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    labelText: 'Allergies',
                    hintText: 'Enter allergies  ',
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                Text('MEDICAL REPORTS'),
                SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: MedicalReport(model!.medicalReport1 as File,
                            (uploadedFile) {
                      bloc.setMedicalReport1(uploadedFile);
                    })),
                    SizedBox(width: 16),
                    Expanded(
                        child: MedicalReport(model.medicalReport2 as File,
                            (uploadedFile) {
                      bloc.setMedicalReport2(uploadedFile);
                    })),
                  ],
                )
              ],
            ),
          );
      }
    );
  }
}