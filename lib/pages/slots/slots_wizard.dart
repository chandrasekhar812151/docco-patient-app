import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/models/available_slot.dart';
import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/pages/slots/slots_wizard_page_view.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:flutter/material.dart';

class SlotsWizard extends StatefulWidget {
  SlotsWizard(this.doctor);

  final Doctor doctor;

  @override
  _SlotsWizardState createState() {
    return new _SlotsWizardState();
  }
}

class _SlotsWizardState extends State<SlotsWizard> {
  List<AvailableSlot>? slots;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<SlotsBloc>();
    print('SlotsWizard rebuilded');

    return FutureBuilder<List<AvailableSlot>>(
      future: Repository.getAvailableSlots(this.widget.doctor.id!.toInt()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error is DoccoException) {
            DoccoException? e = snapshot.error as DoccoException?;
            return Scaffold(
              appBar: AppBar(
                title: Text('Slots'),
              ),
              body: Center(
                child: Text(
                  e!.getMessage().toString(),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Slots'),
            ),
            body: Center(
              child: ListView(
                children: <Widget>[
                  Text(
                    'Cannot get slots for this doctor due to unknown error!',
                  ),
                  Text(snapshot.error.toString()),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data?.length == 0) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Slots'),
              ),
              body: Center(
                child: Text(
                  'This doctor have no slots',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            );
          }

          bloc.setSlots(snapshot.data as List<AvailableSlot>);
          bloc.setDoctor(widget.doctor);

          return SlotsWizardPageView();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Slots'),
            ),
            body: Container(
              child: LinearProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
