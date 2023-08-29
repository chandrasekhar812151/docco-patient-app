import 'package:flutter/services.dart';

class FirebaseMessaging {
  static FirebaseMessaging? _instance;
  static const _kChannel = 'in.docco.patient/firebase_messages';

  Function? _messageHandler;

  FirebaseMessaging._internal();

  final platform = const MethodChannel('in.docco.patient/firebase');
  static FirebaseMessaging? getInstance() {
    if (_instance == null) {
      _instance = FirebaseMessaging._internal();
    }

    const channel = BasicMessageChannel<String>(_kChannel, StringCodec());
    channel.setMessageHandler((message) {
      return _instance!._messageHandler!(message);
    });

    return _instance;
  }

  void setMessageHandler(messageHandler) {
    this._messageHandler = messageHandler;
  }

  Future<String> getToken() async {
    return await platform.invokeMethod('getToken');
  }

  Future<String> getVoipToken() async {
    return await platform.invokeMethod('getVoipToken');
  }
}
