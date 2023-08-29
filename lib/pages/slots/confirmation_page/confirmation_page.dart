import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../appointments/details/details_page.dart';

class _Model {
  final SlotsModel model;

  _Model(this.model);

  String getDateTimeString(dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    var timeString = DateFormat('MMM d, h:m a').format(dateTime);
    return timeString;
  }

  getDay(String weekDay) {
    return weekDay.substring(0, 3).toUpperCase();
  }

  getAppointmentType(String type) {
    return capitalize(type.replaceAll('_', ' '));
  }
}

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage(this.bookAppointment);

  final Function bookAppointment;

  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    final bloc = sl<SlotsBloc>();
    return StreamBuilder<SlotsModel>(
        stream: bloc.slots,
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
              child: Text('Unknown error occurred'),
            );
          }

          if (!snap.hasData) {
            return Column(
              children: <Widget>[
                LinearProgressIndicator(),
              ],
            );
          }

          final model = snap.data;
          _Model m = _Model(model!);

          TextStyle? subtitleStyle = Theme.of(context).textTheme.titleMedium;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ProfilePicture.circular(model.doctor?.avatar,
                                radius: 36),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${model.doctor?.firstName} ${model.doctor?.lastName ?? ""}'.trim(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text('${model.doctor?.title}'),
                              ],
                            )
                          ],
                        ),
                        Divider(height: 32),
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              m.getDateTimeString(model.fromTimeString),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            Icon(Icons.videocam, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              m.getAppointmentType(model.appointmentType),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'CONSULTATION FEE DETAILS',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Appointment Fee', style: subtitleStyle),
                                Text(model.doctor!.fee.toString(),
                                    style: subtitleStyle),
                              ],
                            ),
                            Divider(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('To Pay', style: subtitleStyle),
                                Text(model.doctor!.fee.toString(),
                                    style: subtitleStyle),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    // padding: EdgeInsets.all(16),
                    child: Text('PAY'),
                    onPressed: () async {
                      final paymentResult = await bloc.makePayment();

                      if (paymentResult['code'] == "0") {
                        final errorMessage = paymentResult['message']
                          ?? 'Cannot make payment due to unknown error, Please try again later.';
                        print('PAYMENT FAILED');
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(errorMessage),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    )
                                  ],
                                ));
                        return;
                      }

                      widget.bookAppointment(isPaymentDue: false);
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    // padding: EdgeInsets.all(16),
                    child: Text('SKIP PAYMENT'),
                    onPressed: () {
                      widget.bookAppointment(isPaymentDue: true);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
