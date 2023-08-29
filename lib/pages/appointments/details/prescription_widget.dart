import 'dart:io';

import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/pages/image_full_view.dart';
import 'package:flutter/material.dart';

class PrescriptionWidget extends StatefulWidget {
  final Appointment data;

  const PrescriptionWidget(this.data, {super.key});

  @override
  PrescriptionWidgetState createState() {
    return PrescriptionWidgetState();
  }
}

class PrescriptionWidgetState extends State<PrescriptionWidget> {
  File? _image;
  String? prescriptionImage;

  @override
  void initState() {
    super.initState();
    prescriptionImage = widget.data.prescriptionImage;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('PRESCRIPTION',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.black38)),
            ],
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (widget.data.prescriptionImage == null) {
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ImageFullView(widget.data.prescriptionImage.toString()),
                ),
              );
            },
            child: _image != null
                ? Image.file(_image!, height: 300)
                : widget.data.prescriptionImage != null
                    ? Image.network(widget.data.prescriptionImage.toString(), height: 300)
                    : Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('NA', style: textTheme.titleMedium),
                      ),
          ),
        ],
      ),
    );
  }
}
