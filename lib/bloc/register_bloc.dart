import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:doctor_patient/models/register_model.dart';

class RegisterBloc {
  final _model = RegisterModel();

  final _registerCtrl = BehaviorSubject<RegisterModel>();
  Stream<RegisterModel> get register {
    _registerCtrl.add(_model);
    return _registerCtrl.stream;
  }

  RegisterModel get registerModel => _model;

  void dispose() {
    _registerCtrl.close();
  }
}
