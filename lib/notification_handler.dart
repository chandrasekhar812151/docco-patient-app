import 'dart:convert';
import 'dart:io';

import 'package:doctor_patient/pages/video_call/video_call_init_page.dart';
import 'package:doctor_patient/pages/video_call/video_call_page.dart';
import 'package:doctor_patient/uidata.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/util/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

// class NotificationHandler {
//   BuildContext? context;
//   FirebaseMessaging? firebaseMessaging;
//   static String? currentPage;
//
//   NotificationHandler(context) {
//     this.context = context;
//     firebaseMessaging = FirebaseMessaging.getInstance()!;
//     firebaseMessaging?.setMessageHandler((jsonString) {
//       debugPrint('NEW Message $jsonString');
//       _onNewMessage(jsonDecode(jsonString));
//     });
//   }
//
//   void _onNewMessage(Map<String, dynamic> data) {
//     if (data['type'] == 'video_call') {
//       if (data['open_video'] != null) {
//         _openVideoScreen(data);
//       } else {
//         _handleIncomingVideoCall(data);
//       }
//     } else if (data['type'] == 'end_call') {
//       if (VideoCallInitPage.appShouldCloseOnEndCall) {
//         exit(0);
//       }
//
//       if (VideoCallInitPage.isShowing) {
//         debugPrint('VideoCallInitPage.isShowing is true');
//         VideoCallInitPage.isShowing = false;
//         VideoCallInitPage.soundManager.stopLocal();
//         Navigator.of(context!).pop();
//       } else if (VideoCallPage.isShowing) {
//         debugPrint('VideoCallPage.isShowing is true');
//         VideoCallPage.userConnected = false;
//         VideoCallPage.isShowing = false;
//         Wakelock.disable();
//         if (Platform.isAndroid) {
//           Navigator.pop(context!);
//         } else if (Platform.isIOS) {
//           print('trying to go to home in iOS');
//           Navigator.of(context!).pop(UIData.homeRoute);
//         }
//       } else {
//         debugPrint('Ignoring end call request');
//       }
//     }
//   }
//
//   void _handleIncomingVideoCall(Map<String, dynamic> data) {
//     debugPrint('in _handleIncomingVideoCall()');
//     Navigator.of(context!).push(MaterialPageRoute(
//       builder: (context) => VideoCallInitPage(
//             roomName: data['room_name'],
//             callerName: data['caller_name'],
//             callerImage: data['caller_image'],
//             doctorId: data['doctor_id'],
//           ),
//     ));
//   }
//
//   Future<void> _openVideoScreen(Map<String, dynamic> data) async {
//     debugPrint('in _openVideoScreen()');
//     var cameraStatus = await Permission.camera.request();
//     var microphoneStatus = await Permission.microphone.request();
//     if(cameraStatus.isGranted && microphoneStatus.isGranted)
//     {
//       Navigator.of(context!).push(MaterialPageRoute(
//           builder: (context) =>
//               VideoCallPage(data['room_name'], data['doctor_id'])));
//     }
//   }
// }
