import 'package:doctor_patient/pages/appointments/appointments_page.dart';
import 'package:doctor_patient/pages/login/login_page.dart';
import 'package:doctor_patient/pages/main_page.dart';
import 'package:doctor_patient/pages/onboarding/onboarding_page.dart';
import 'package:doctor_patient/pages/profile/profile_page.dart';
import 'package:doctor_patient/pages/register/register_page.dart';
import 'package:doctor_patient/pages/splash/splash_page.dart';
import 'package:doctor_patient/pages/welcome/welcome_page.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    UIData.appointmentsRoute: (BuildContext context) => AppointmentsPage(),
    UIData.homeRoute: (BuildContext context) => MainPage(),
    UIData.profileRoute: (BuildContext context) => ProfilePage(),
    UIData.loginRoute: (BuildContext context) => LoginPage(),
    UIData.registerRoute: (BuildContext context) => RegisterPage(),
    UIData.splashRoute: (BuildContext context) => SplashPage(),
    UIData.welcomeRoute: (BuildContext context) => WelcomePage(),
    UIData.onBoardingRoute: (BuildContext context) => OnBoardingPage(),
  };
}
