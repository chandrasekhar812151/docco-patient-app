// ignore_for_file: prefer_null_aware_operators, library_private_types_in_public_api, prefer_final_fields, prefer_is_empty

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_patient/pages/appointments/details/delivery_address_form.dart';
import 'package:doctor_patient/pages/appointments/details/prescription_widget.dart';
import 'package:doctor_patient/pages/image_full_view.dart';
import 'package:doctor_patient/widgets/wizard_route.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:intl/intl.dart';

class _Model {
  final Appointment data;
  String? dateString;
  String? timeString;
  String? appointmentType;
  String? symptoms;

  _Model(this.data) {
    var dateTime = DateTime.parse(data.fromTime.toString()).toLocal();
    dateString = DateFormat('dd MMM, yyyy').format(dateTime);
    timeString = DateFormat('hh:mm a').format(dateTime);
    appointmentType = capitalize(data.type.toString()).replaceAll('_', ' ');
    symptoms =
        data.symptoms != null ? data.symptoms?.split(',').join(', ') : null;
  }
}

String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

class DetailsPage extends StatefulWidget {
  final Appointment data;
  const DetailsPage(this.data, {super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  StreamController<dynamic> _medicineDeliveryStreamCtrl =
      StreamController<dynamic>();

  Future<void> _showDeliveryAddressForm(BuildContext context) async {
    var data = await Navigator.push(
        context,
        WizardRoute(
          builder: (context) => DeliveryAddressForm(widget.data), settings: null,
        ));

    _medicineDeliveryStreamCtrl.add(data);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var m = _Model(widget.data);

    return WillPopScope(
      onWillPop: () async {
        _medicineDeliveryStreamCtrl.close();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointment Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Hero(
                            tag: '{data.id}picture',
                            child: ProfilePicture.circular(
                                widget.data.doctorPicture,
                                radius: 36),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.data.doctorName.toString(),
                                  style: textTheme.titleLarge),
                              Text(widget.data.doctorTitle.toString(),
                                  style: textTheme.titleMedium),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ISSUE',
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black38)),
                          const SizedBox(height: 4),
                          Text(widget.data.issue.toString(), style: textTheme.titleMedium),
                          const SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('DATE',
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black38)),
                                  const SizedBox(height: 4),
                                  Text(m.dateString.toString(), style: textTheme.titleMedium),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('TIME',
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black38)),
                                  const SizedBox(height: 4),
                                  Text(m.timeString.toString(), style: textTheme.titleMedium),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('TYPE',
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black38)),
                                  const SizedBox(height: 4),
                                  Text('Video call', style: textTheme.titleMedium),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('VISIT',
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black38)),
                                  const SizedBox(height: 4),
                                  Text('01', style: textTheme.titleMedium),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('SYMPTOMS',
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black38)),
                          const SizedBox(height: 4),
                          Text(m.symptoms ?? 'NA', style: textTheme.titleMedium),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrescriptionWidget(widget.data),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('MEDICAL REPORTS',
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black38)),
                          const SizedBox(height: 8),
                          m.data.medicalReports!.length > 0
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      m.data.medicalReports!.length, (index) {
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageFullView(
                                                          m.data.medicalReports![
                                                              index])));
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  m.data.medicalReports![index],
                                            )),
                                      ),
                                    );
                                  }),
                                )
                              : Text('NA', style: textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              widget.data.status == 'completed'
                  ? StreamBuilder<dynamic>(
                      stream: _medicineDeliveryStreamCtrl.stream,
                      initialData: {
                        'deliveryAddress': widget.data.deliveryAddress,
                        'deliveryStatus': widget.data.deliveryStatus,
                      },
                      builder: (context, snap) {
                        String deliveryAddress = snap.data['deliveryAddress'];
                        String deliveryStatus = snap.data['deliveryStatus'];

                        return deliveryAddress.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: ElevatedButton(
                                  // padding: EdgeInsets.all(16),
                                  onPressed: () =>
                                      _showDeliveryAddressForm(context),
                                  child: const Text('REQUEST MEDICINE'),
                                ),
                              )
                            : Card(
                                elevation: 0,
                                margin: const EdgeInsets.all(0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text('MEDICINE DELIVERY',
                                                        style: textTheme.bodyLarge
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .black38)),
                                                    const Spacer(),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('Address',
                                                        style:
                                                            textTheme.titleSmall),
                                                    const SizedBox(height: 4),
                                                    Text(deliveryAddress),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _DeliveryStatus(deliveryStatus),
                                    )
                                  ],
                                ),
                              );
                      },
                    )
                  : Container(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryStatus extends StatelessWidget {
  final String status;
  const _DeliveryStatus(this.status);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _StatusBox(
          color: Colors.blue,
          statusDisplayText: 'Requested',
          value: 'requested',
          status: status,
        ),
        SizedBox(
          height: 10,
          width: 5,
          child: Container(color: Colors.grey),
        ),
        _StatusBox(
          color: Colors.lightGreen,
          statusDisplayText: 'Picked',
          value: 'picked',
          status: status,
        ),
        SizedBox(
          height: 10,
          width: 5,
          child: Container(color: Colors.grey),
        ),
        _StatusBox(
          color: Colors.orange,
          statusDisplayText: 'In Transit',
          value: 'in-transit',
          status: status,
        ),
        SizedBox(
          height: 10,
          width: 5,
          child: Container(color: Colors.grey),
        ),
        _StatusBox(
          color: Colors.deepOrange,
          statusDisplayText: 'Dispatched',
          value: 'dispatched',
          status: status,
        ),
        SizedBox(
          height: 10,
          width: 5,
          child: Container(color: Colors.grey),
        ),
        _StatusBox(
          color: Colors.green,
          statusDisplayText: 'Delivered',
          value: 'delivered',
          status: status,
        ),
      ],
    );
  }
}

class _StatusBox extends StatelessWidget {
  final Color? color;
  final String? statusDisplayText;
  final String? value;
  final String? status;

  const _StatusBox({
    @required this.color,
    @required this.statusDisplayText,
    @required this.value,
    @required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color? bgColor = status == value ? color : Colors.transparent;
    final Color? textColor = status == value ? Colors.white : color;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color!)),
      child: Text(
        capitalize(statusDisplayText!),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
