import 'package:doctor_patient/config.dart';
import 'package:doctor_patient/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/bloc/service_locator.dart' as sl;

void main() {
  sl.setup();
  Config.appFlavor = Flavor.DEVELOPMENT;
  runApp(RootWidget());
}
