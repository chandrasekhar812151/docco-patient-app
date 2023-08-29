import 'package:flutter/material.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intro_slider/intro_slider.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      ContentConfig(
        title: "Connect",
        description:
            "Health care is a right not a privilege. Let everyone cherish that privilege through our solution.",
        pathImage: UIData.doctorImage,
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      ContentConfig(
        title: "Video Calling",
        description:
            "Through Docco360, the selected doctors can instantly connect with patients any where any time.",
        pathImage: UIData.videoCallImage,
        backgroundColor: Color(0xFF8BC34A),
      ),
    );
    slides.add(
      ContentConfig(
        title: "Medicine Delivery",
        description:
            "Docco360 delivers the medicines dispensed or prescribed by your doctor to your doorstep.",
        pathImage: UIData.logoImage,
        backgroundColor: Color(0xfff5a623),
      ),
    );
  }

  Future<Null> onDonePress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      Navigator.pushReplacementNamed(context, UIData.welcomeRoute);
    } else if (token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, UIData.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      listContentConfig: slides,
      onDonePress: onDonePress,
    );
  }
}
