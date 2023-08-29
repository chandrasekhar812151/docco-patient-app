import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:doctor_patient/pages/video_call/video_call_page.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:doctor_patient/widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

// class SoundManager {
//   // AudioCache audioCache = new AudioCache();
//   // AudioPlayer? player;
//   //
//   // Future playLocal(localFileName) async {
//   //   player = (await audioCache.load('ringtone.mp3')) as AudioPlayer?;
//   // }
//
//   void stopLocal() {
//     player?.stop();
//   }
// }
//
// class VideoCallInitPage extends StatefulWidget {
//   final String? roomName;
//   final String? callerName;
//   final String? callerImage;
//   final String? doctorId;
//   final bool? cameFromBackground;
//
//   static final SoundManager soundManager = SoundManager();
//   static bool isShowing = false;
//   static bool appShouldCloseOnEndCall = false;
//
//   VideoCallInitPage({
//     @required this.roomName,
//     @required this.callerName,
//     this.callerImage,
//     @required this.doctorId,
//     this.cameFromBackground = false,
//   }) {
//     VideoCallInitPage.appShouldCloseOnEndCall = cameFromBackground!;
//   }
//
//   _VideoCallInitPageState createState() => _VideoCallInitPageState();
// }
//
// class _VideoCallInitPageState extends State<VideoCallInitPage> {
//   Future<Null> _playRingtone() async {
//     VideoCallInitPage.soundManager.playLocal('ringtone.mp3');
//   }
//
//   // bool _shouldPop = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _playRingtone();
//     VideoCallInitPage.isShowing = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         VideoCallInitPage.soundManager.stopLocal();
//         VideoCallInitPage.isShowing = false;
//         return Future.value(true);
//       },
//       child: Scaffold(
//         backgroundColor: Colors.orange,
//         body: SafeArea(
//           child: Container(
//             alignment: Alignment.center,
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Spacer(),
//                 ProfilePicture.circular(
//                   widget.callerImage,
//                   radius: 64,
//                 ),
//                 SizedBox(height: 12),
//                 Text(widget.callerName.toString(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineMedium
//                         ?.copyWith(color: Colors.white)),
//                 SizedBox(height: 12),
//                 Text('CALLING...',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         color: Colors.white, fontWeight: FontWeight.bold)),
//                 Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     RawMaterialButton(
//                       onPressed: () async {
//                         VideoCallInitPage.soundManager.stopLocal();
//
//                         try {
//                           await Repository.endVideoCall(widget.doctorId);
//                           debugPrint(
//                               'Video call end request sent successfully');
//                         } catch (e) {
//                           debugPrint('Cannot end video call due to error');
//                           debugPrint(e.toString());
//                         }
//
//                         VideoCallInitPage.isShowing = false;
//
//                         if (widget.cameFromBackground!) {
//                           exit(0);
//                         } else {
//                           Navigator.of(context).pop();
//                         }
//                       },
//                       child: new Icon(
//                         Icons.call_end,
//                         color: Colors.white,
//                         size: 35.0,
//                       ),
//                       shape: new CircleBorder(),
//                       elevation: 2.0,
//                       fillColor: Colors.redAccent,
//                       padding: const EdgeInsets.all(15.0),
//                     ),
//                     RawMaterialButton(
//                       onPressed: () async {
//                         VideoCallInitPage.soundManager.stopLocal();
//                         // PermissionHandler().requestPermissions([
//                         //   PermissionGroup.camera,
//                         //   PermissionGroup.microphone
//                         // ]).then((_) {
//                         //   VideoCallInitPage.isShowing = false;
//                         //   VideoCallInitPage.soundManager.stopLocal();
//                         //   Navigator.of(context)
//                         //       .pushReplacement(MaterialPageRoute(
//                         //           builder: (context) => VideoCallPage(
//                         //                 widget.roomName,
//                         //                 widget.doctorId,
//                         //                 cameFromBackground: widget.cameFromBackground,
//                         //               )));
//                         // });
//
//                         var cameraStatus = await Permission.camera.request();
//                         var microphoneStatus = await Permission.microphone.request();
//                         if(cameraStatus.isGranted && microphoneStatus.isGranted)
//                         {
//                           Navigator.of(context)
//                               .pushReplacement(MaterialPageRoute(
//                               builder: (context) => VideoCallPage(
//                                 widget.roomName!,
//                                 widget.doctorId!,
//                                 cameFromBackground: widget.cameFromBackground!,
//                               )));
//                         }
//                       },
//                       child: new Icon(
//                         Icons.video_call,
//                         color: Colors.white,
//                         size: 35.0,
//                       ),
//                       shape: new CircleBorder(),
//                       elevation: 2.0,
//                       fillColor: Colors.green,
//                       padding: const EdgeInsets.all(15.0),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
