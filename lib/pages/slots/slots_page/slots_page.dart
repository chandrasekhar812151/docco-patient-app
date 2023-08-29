import 'package:doctor_patient/pages/slots/slots_page/widgets/appointment_type_options.dart';
import 'package:doctor_patient/pages/slots/slots_page/widgets/dates_widget.dart';
import 'package:doctor_patient/pages/slots/slots_page/widgets/profile_info_widget.dart';
import 'package:doctor_patient/pages/slots/slots_page/widgets/slot_chips_widget.dart';
import 'package:flutter/material.dart';

class SlotsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ProfileInfoWidget(),
            ),
            Divider(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: AppointmentTypeOptions(),
            ),
            Divider(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DatesWidget(),
            ),
            Divider(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SlotChipsWidget(),
            ),
          ]
        ),
      ),
    );
  }
}
