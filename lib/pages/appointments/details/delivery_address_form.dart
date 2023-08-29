// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:doctor_patient/bloc/appointments_bloc.dart';
import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:flutter/material.dart';

class DeliveryAddressForm extends StatefulWidget {
  final Appointment appointment;

  const DeliveryAddressForm(this.appointment, {super.key});

  @override
  _DeliveryAddressFormState createState() => _DeliveryAddressFormState();
}

class _DeliveryAddressFormState extends State<DeliveryAddressForm> {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pincodeCtrl = TextEditingController();
  TextEditingController houseNoCtrl = TextEditingController();
  TextEditingController streetCtrl = TextEditingController();
  TextEditingController landmarkCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  Future<void> _onSubmit() async {
    if (!_validate()) {
      return;
    }

    var bloc = sl<AppointmentsBloc>();

    showDialog(
        context: context,
        builder: (context) => const Dialog(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('Updating...'),
                  ],
                ),
              ),
            ));

    try {
      await Repository.medicineDelivery({
        'appointment_id': '${widget.appointment.id}',
        'address': _formatAddress(),
      });

      await bloc.getAppointments(fromCache: false);

      Navigator.of(context).pop();      

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Success',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.green)),
                content: const Text('Updated medicine delivery address.'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {                      
                      Navigator.of(context).pop();                      
                      Navigator.of(context).pop({
                        'deliveryAddress': _formatAddress(),
                        'deliveryStatus': 'requested',
                      });
                    },
                  ),
                ],
              ));
    } catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog(
          'Cannot send delivery address due to server error\n${e.toString()}');
    }
  }

  String _formatAddress() {
    return 'Phone number: ${phoneCtrl.text}\n'
        'Pincode: ${pincodeCtrl.text}\n'
        'House No: ${houseNoCtrl.text}\n'
        'Street: ${streetCtrl.text}\n'
        'Landmark: ${landmarkCtrl.text}\n'
        'City: ${cityCtrl.text}';
  }

  bool _validate() {
    if (phoneCtrl.text.isEmpty) {
      _showErrorDialog('Please enter phone number');
      return false;
    } else if (pincodeCtrl.text.isEmpty) {
      _showErrorDialog('Please enter pincode');
      return false;
    } else if (houseNoCtrl.text.isEmpty) {
      _showErrorDialog('Please enter House No.');
      return false;
    } else if (streetCtrl.text.isEmpty) {
      _showErrorDialog('Please enter Colony / Street / Locality Details');
      return false;
    } else if (landmarkCtrl.text.isEmpty) {
      _showErrorDialog('Please enter Landmark');
      return false;
    } else if (cityCtrl.text.isEmpty) {
      _showErrorDialog('Please enter City name');
      return false;
    }

    return true;
  }

  void _showErrorDialog(displayText) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(displayText),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        filled: true, labelText: 'Phone number'),
                  ),
                  TextField(
                    controller: pincodeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        filled: true, labelText: '6 digits [0-9] pincode'),
                  ),
                  TextField(
                    controller: houseNoCtrl,
                    decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Flat / House No. / Floor / Building'),
                  ),
                  TextField(
                    controller: streetCtrl,
                    decoration: const InputDecoration(
                        filled: true, labelText: 'Colony / Street / Locality'),
                  ),
                  TextField(
                    controller: landmarkCtrl,
                    decoration:
                        const InputDecoration(filled: true, labelText: 'Landmark'),
                  ),
                  TextField(
                    controller: cityCtrl,
                    decoration:
                        const InputDecoration(filled: true, labelText: 'City'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                // padding: EdgeInsets.all(16),
                child: const Text('SUBMIT'),
                onPressed: () => _onSubmit(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
