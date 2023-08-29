import 'package:flutter/material.dart';

class UIData {
  // all routes
  static final appointmentsRoute = '/appointments';
  static final doctorProfileRoute = '/doctor-profile';
  static final profileRoute = '/profile';
  static final homeRoute = '/home';
  static final loginRoute = '/login';
  static final registerRoute = '/register';
  static final searchDoctorRoute = '/search-doctor';
  static final splashRoute = '/';
  static final welcomeRoute = '/welcome';
  static final videoCallInitRoute = '/video-call-init';
  static  final onBoardingRoute = '/onboarding';

  // image assets
  static String imageDir = 'assets/images';
  static final appointmentImage = '$imageDir/appointment.svg';
  static final confirmationImage = '$imageDir/confirmation.png';
  static final houseImage = '$imageDir/house.svg';
  static final logoImage = '$imageDir/logo.png';
  static final logoFullImage = '$imageDir/logo_full.png';
  static final personalizationImage = '$imageDir/personalization.png';
  static final pillsImage = '$imageDir/pills.svg';
  static final signInImage = '$imageDir/sign_in_illustration.png';
  static final userDefaultImage = '$imageDir/user_default_picture.png';
  static final userImage = '$imageDir/user.svg';
  static final emptyImage = '$imageDir/empty.png';

  // onboarding screen images
  static final doctorImage = '$imageDir/doctor.png';
  static final videoCallImage = '$imageDir/video_call.png';
  static final remedyImage = '$imageDir/remedy.png';

  // doctor category images
  static final homeopathyImage = '$imageDir/homeopathy.jpg';
  static final naturopathyImage = '$imageDir/naturopathy.jpg';
  static final ayurvedaImage = '$imageDir/ayurveda.jpg';

  static final primaryColorHex = '#FF5722';

  static final primaryColor = Colors.deepOrange;

  // gradients
  static List<Color> doccoGradients = [
    Colors.deepOrange,
    Colors.white,
  ];

  static List<double> doccoGradientStops = [
    0,
    0.7,
  ];
}
