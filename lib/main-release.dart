import 'package:doctor_patient/bloc/service_locator.dart' as sl;
import 'package:doctor_patient/config.dart';
import 'package:doctor_patient/root_widget.dart';
import 'package:flutter/material.dart';

void main() {
  sl.setup();
  Config.appFlavor = Flavor.RELEASE;
  runApp(RootWidget());
}
