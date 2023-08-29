// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:doctor_patient/config.dart';
import 'package:doctor_patient/notification_handler.dart';
import 'package:doctor_patient/pages/video_call/videosession.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;
  final String doctorId;
  final bool cameFromBackground;

  static bool userConnected = false;
  static bool isShowing = false;

  /// Creates a call page with given channel name.
  VideoCallPage(this.channelName, this.doctorId,
      {this.cameFromBackground = false}) {
    // NotificationHandler.currentPage = 'video_call_page';
  }

  @override
  _VideoCallPageState createState() {
    return new _VideoCallPageState();
  }
}

class _VideoCallPageState extends State<VideoCallPage> {
  static final _sessions = VideoSession as List<VideoSession>;
  final _infoStrings = <String>[];
  bool muted = false;

  @override
  void dispose() {
    // clean up native views & destroy sdk
    _sessions.forEach((session) {
      // AgoraRtcEngine.removeNativeView(session.viewId);
    });
    _sessions.clear();
    // AgoraRtcEngine.leaveChannel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
    VideoCallPage.isShowing = true;
  }

  Future<void> initialize() async {
    if (Config.agoraAppId.isEmpty) {
      setState(() {
        _infoStrings
            .add("APP_ID missing, please provide your APP_ID in settings.dart");
        _infoStrings.add("Agora Engine is not starting");
      });
      return;
    }

    // PermissionHandler().requestPermissions(
    //     [PermissionGroup.camera, PermissionGroup.microphone]);

    var cameraStatus = await Permission.camera.request();
    var microphoneStatus = await Permission.microphone.request();
    if(cameraStatus.isGranted && microphoneStatus.isGranted)
    {
      _initAgoraRtcEngine();
      _addAgoraEventHandlers();
      // use _addRenderView everytime a native video view is needed
      _addRenderView(0, (viewId) {
        // AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Hidden);
        // AgoraRtcEngine.startPreview();
        // state can access widget directly
        // AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
      });
    }
  }

  /// Create agora sdk instance and initialze
  Future<void> _initAgoraRtcEngine() async {
    // AgoraRtcEngine.create(Config.agoraAppId);
    // AgoraRtcEngine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    // AgoraRtcEngine.onError = (int code) {
    //   setState(() {
    //     String info = 'onError: ' + code.toString();
    //     _infoStrings.add(info);
    //   });
    // };

    // AgoraRtcEngine.onJoinChannelSuccess = (String channel, int uid, int elapsed) {
    //   setState(() {
    //     String info = 'onJoinChannel: ' + channel + ', uid: ' + uid.toString();
    //     _infoStrings.add(info);
    //   });
    // };

    // AgoraRtcEngine.onLeaveChannel = () {
    //   setState(() {
    //     _infoStrings.add('onLeaveChannel');
    //   });
    // };

    // AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
    //   setState(() {
    //     String info = 'userJoined: ' + uid.toString();
    //     _infoStrings.add(info);
    //     _addRenderView(uid, (viewId) {
    //       AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Hidden, uid);
    //     });
    //   });
    // };

    // AgoraRtcEngine.onUserOffline = (int uid, int reason) {
    //   setState(() {
    //     String info = 'userOffline: ' + uid.toString();
    //     _infoStrings.add(info);
    //     _removeRenderView(uid);
    //   });
    // };

    // AgoraRtcEngine.onFirstRemoteVideoFrame = (int uid, int width, int height, int elapsed) {
    //   setState(() {
    //     String info = 'firstRemoteVideo: ' +
    //         uid.toString() +
    //         ' ' +
    //         width.toString() +
    //         'x' +
    //         height.toString();
    //     _infoStrings.add(info);
    //   });
    // };
  }

  /// Create a native view and add a new video session object
  /// The native viewId can be used to set up local/remote view
  void _addRenderView(int uid, Function(int viewId) finished) {
    // Widget view = AgoraRtcEngine.createNativeView(uid, (viewId) {
    //   setState(() {
    //     _getVideoSession(uid).viewId = viewId;
    //     finished(viewId);
    //   });
    // });
    // VideoSession session = VideoSession(uid, view);
    // _sessions.add(session);
  }

  /// Remove a native view and remove an existing video session object
  // void _removeRenderView(int uid) {
  //   VideoSession session = _getVideoSession(uid);
  //   _sessions.remove(session);
  //   AgoraRtcEngine.removeNativeView(session.viewId);
  // }

  /// Helper function to filter video session with uid
  // VideoSession _getVideoSession(int uid) {
  //   return _sessions.firstWhere((session) {
  //     return session.uid == uid;
  //   });
  // }

  /// Helper function to get list of native views
  List<Widget?> _getRenderViews() {
    return _sessions.map((session) => session.view).toList();
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video layout wrapper
  Widget _viewRows() {
    List<Widget?> views = _getRenderViews();
    print('VIEWS LENGTH ${views.length}');
    switch (views.length) {
      case 1:
//        if (VideoCallPage.userConnected && Platform.isIOS) {
//          Future.delayed(
//            Duration(),
//            () => Navigator.of(context).pushReplacementNamed(UIData.homeRoute),
//          );
//        }
        VideoCallPage.userConnected = false;
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        VideoCallPage.userConnected = true;
        return Stack(
          children: <Widget>[
            RandomColorBlock(
              child: views[1]!,
            ),
            Positioned(
                width: 100,
                height: 140,
                child: RandomColorBlock(
                  child: views[0]!,
                ),
                bottom: 120,
                right: 0)
          ],
        );
      default:
    }
    return Container();
  }

  Widget RandomColorBlock({required Widget child}) {
    final Random random = Random();
    final color = Color.fromARGB(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );

    return Container(
      color: color,
      child: child,
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => _onToggleMute(),
            child: new Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: new Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () => _onSwitchCamera(),
            child: new Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  Future<Null> _onCallEnd(BuildContext context) async {
    print('Ending call');

    if (VideoCallPage.userConnected) {
      try {
        await Repository.endVideoCall(widget.doctorId);
        debugPrint('Sent endVideoCall request');
      } catch (e) {
        debugPrint('Cannot end video call due to error');
        debugPrint(e.toString());
      }
    }

    VideoCallPage.isShowing = false;
    // Screen.keepOn(false);
    // Wakelock.disable();

//    if (Platform.isIOS) {
//      Navigator.of(context).pushReplacementNamed(UIData.homeRoute);
//      return;
//    }

    print('cameFromBackround = ${widget.cameFromBackground}');

    if (widget.cameFromBackground) {
      print("calling exit(0)");
      exit(0);
    } else {
      print("Popping video screen");

      if (Platform.isIOS) {
        Navigator.of(context).pop();
      } else if (Platform.isAndroid) {
        Navigator.pop(context);
      }
    }
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    // AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    // AgoraRtcEngine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    // Screen.keepOn(true);
    // Wakelock.enable();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _viewRows(),
          _toolbar(),
        ],
      ),
    );
  }
}
