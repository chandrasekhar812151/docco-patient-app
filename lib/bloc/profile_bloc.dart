// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:doctor_patient/models/profile.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _profileSubject = BehaviorSubject<Profile>();
  var _profile;

  Stream<Profile> get profile => _profileSubject.stream;

  Future<void> getProfile() async {
    if (_profile == null) {
      try {
        _profile = await Repository.getProfile();
        _profileSubject.add(_profile);
      } catch (e) {
        _profileSubject.addError(e);
      }
    }
  }

  Future<void> getProfileFromServer() async {
    try {
      _profile = await Repository.getProfile();
      _profileSubject.add(_profile);
    } catch (e) {
      _profileSubject.addError(e);
    }
  }

  void setState(Function f) {
    f();
    _profileSubject.add(_profile);
  }

  Future<bool> updateProfile() async {
    Map m = {};
    _profile.toJson().forEach((key, value) {
      if (value != null && key != 'phone' && key != 'email') {
        m[key] = value;
      }
    });
    return await Repository.updateProfile(m);
  }

  Future<bool> updateProperty(prop) async {
    return await Repository.updateProfile(prop);
  }
}
