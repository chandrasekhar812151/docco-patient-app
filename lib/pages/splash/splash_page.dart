import 'package:doctor_patient/notification_handler.dart';
import 'package:doctor_patient/pages/video_call/video_call_init_page.dart';
import 'package:doctor_patient/pages/video_call/video_call_page.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final kGetAndroidVideoCallDetails = 'getAndroidVideoCallDetails';

  final kGetIosVideoCallDetails = 'getIosVideoCallDetails';

  Future<Null> checkToken(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      print('token is $token');

      final platform = const MethodChannel('in.docco.patient/video_call');

      final androidVideoCallData =
          await platform.invokeMethod(kGetAndroidVideoCallDetails);

      final iosVideoCallData =
          await platform.invokeMethod(kGetIosVideoCallDetails);

      if (androidVideoCallData != null) {
        Future(() {
          // NotificationHandler(context);
        });
        androidVideoCallData['came_from_background'] = true;
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (context) => VideoCallInitPage(
        //         roomName: androidVideoCallData['room_name'],
        //         callerName: androidVideoCallData['caller_name'],
        //         callerImage: androidVideoCallData['caller_image'],
        //         doctorId: androidVideoCallData['doctor_id'],
        //         cameFromBackground: true)));
        return;
      } else if (iosVideoCallData != null) {
        print("IOS from splash");
//        Future(() {
//          NotificationHandler(context);
//        });
        iosVideoCallData['came_from_background'] = true;
        // PermissionHandler().requestPermissions(
        //     [Permission.camera, Permission.microphone]).then((_) {
        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
        //       builder: (context) => VideoCallPage(
        //         iosVideoCallData['room_name'],
        //         iosVideoCallData['doctor_id'],
        //         cameFromBackground: true,
        //       )));
        // });
        var cameraStatus = await Permission.camera.request();
        var microphoneStatus = await Permission.microphone.request();
        if(cameraStatus.isGranted && microphoneStatus.isGranted)
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => VideoCallPage(
                  iosVideoCallData['room_name'],
                  iosVideoCallData['doctor_id'],
                  cameFromBackground: true,
                )));
          }
        return;
      }

      Navigator.of(context).pushReplacementNamed(UIData.homeRoute);
    } else {
      print('token is null, showing welcome route');
      Navigator.of(context).pushReplacementNamed(UIData.onBoardingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkToken(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: UIData.doccoGradientStops,
            colors: UIData.doccoGradients,
          ),
        ),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Image.asset(UIData.logoImage),
          ),
        ),
      ),
    );
  }
}
