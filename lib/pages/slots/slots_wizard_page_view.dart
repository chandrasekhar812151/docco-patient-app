// ignore_for_file: unnecessary_null_comparison

import 'package:doctor_patient/bloc/service_locator.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';
import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/pages/slots/confirmation_page/confirmation_page.dart';
import 'package:doctor_patient/pages/slots/details_page/details_page.dart';
import 'package:doctor_patient/pages/slots/slots_page/slots_page.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:doctor_patient/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SlotsWizardPageView extends StatefulWidget {
  @override
  _SlotsWizardPageViewState createState() {
    return new _SlotsWizardPageViewState();
  }
}

class _SlotsWizardPageViewState extends State<SlotsWizardPageView> {
  final PageController controller = PageController(initialPage: 0);
  SlotsBloc? bloc;

  BuildContext? scaffoldContext;
  int currentPage = 0;
  int lastPage = 2;
  final double kSlotsPage = 0;
  final double kDetailsPage = 1;

  void showBookingSuccessDialog(context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(16),
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    // top: 0,
                    child: Center(
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.done, size: 84, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Success',
                    style: textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Booking confirmed successfully.',
                    style: textTheme.titleMedium?.copyWith(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // padding: EdgeInsets.symmetric(vertical: 16),
                      // color: Colors.green,
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            UIData.homeRoute, (route) => false);
                        // Navigator.pop(context);
                        // Navigator.pushNamed(context, UIData.homeRoute);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> canPop(SlotsModel model) {
    if (controller.page == 0) {
      bloc?.clearModel();
      return Future.value(true);
    }

    controller.previousPage(
        curve: Curves.linear, duration: Duration(milliseconds: 250));
    return Future.value(false);
  }

  void gotoNextPage(SlotsModel model) async {
    if (model.fromTimeString == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select the slot')));
      return;
    }

    if (controller.page == kSlotsPage) {
      try {
        await Repository.isSlotAlreadyBooked(
            doctorId: model.doctor?.id, timeSlotId: model.slotId);
      } on DoccoException catch (e) {
        if (e.getCode() == 422) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.getMessage().toString())));
        } else if (e.getCode() == 500) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cannot book slot due to server error!')));
        }
        return;
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cannot book slots at this time!')));
        return;
      }
    } else if (controller.page == kDetailsPage) {
      if (model.issue == null || model.issue!.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Issue field is required')));
        return;
      }
    }

    controller.nextPage(
        curve: Curves.linear, duration: Duration(milliseconds: 250));
  }

  void bookAppointment({required bool isPaymentDue}) async {
    try {
      showDialog(context: context, builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Booking appointment...'),
            ],
          ),
        ),
      ));
      await bloc?.bookAppointment(isPaymentDue: isPaymentDue);
      Navigator.of(context).pop();
      showBookingSuccessDialog(context);
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Cannot book appointment due to unknown error!')));
        return;
      }

      int? statusCode = e.response?.statusCode;

      if (statusCode == 500) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.response!.data.toString())));
      } else if (statusCode == 401) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CustomErrorWidget(e, onRetry: () {setState(() {});},)));
      } else if (statusCode == 422) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.response?.data['error']['message'])));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cannot book appointment')));
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = sl<SlotsBloc>();
    return Container(
      child: StreamBuilder<SlotsModel>(
          stream: bloc?.slots,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final model = snapshot.data;
            return WillPopScope(
              onWillPop: () => canPop(model!),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(model!.pageTitle),
                  actions: <Widget>[
                    model.nextText != null
                        ? ElevatedButton(
                            child: Text(
                              model.nextText,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            onPressed: () {
                              gotoNextPage(model);
                            },
                          )
                        : Container()
                  ],
                ),
                body: Builder(
                  builder: (scaffoldContext) {
                    this.scaffoldContext = scaffoldContext;
                    return PageView(
                      onPageChanged: (pageIndex) {
                        bloc?.onPageChanged(pageIndex);
                      },
                      controller: controller,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        SlotsPage(),
                        DetailsPage(),
                        ConfirmationPage(bookAppointment),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
