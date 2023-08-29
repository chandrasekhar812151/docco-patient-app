import 'package:doctor_patient/docco_exception.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PasswordResetBloc {
  final _phoneSubject = BehaviorSubject<String>();
  final _otpSubject = BehaviorSubject<String>();

  final _newPasswordSubject = BehaviorSubject<String>();
  final _confirmNewPasswordSubject = BehaviorSubject<String>();

  final _dataSubject = BehaviorSubject<String>();

  String? _phone;
  String? _otp;
  String? _newPassword;
  String? _confirmNewPassword;

  PasswordResetBloc() {
    _phoneSubject.listen((data) {
      _phone = data;
    });

    _otpSubject.listen((data) {
      _otp = data;
    });

    _newPasswordSubject.listen((data) {
      _newPassword = data;
    });

    _confirmNewPasswordSubject.listen((data) {
      _confirmNewPassword = data;
    });
  }

  Sink<String> get phone => _phoneSubject.sink;
  Sink<String> get otp => _otpSubject.sink;
  Sink<String> get newPassword => _newPasswordSubject.sink;
  Sink<String> get confirmNewPassword => _confirmNewPasswordSubject.sink;

  Stream<String> get data => _dataSubject.stream;

  Future<void> requestOtp(Function callback) async {
    if (_phone == null || _phone!.isEmpty) {
      _dataSubject.addError('Phone number is empty');
      return;
    }

    _dataSubject.sink.add('');

    try {
      await Repository.requestOtp({
        'phone': _phone,
        'reason': 'reset_password',
      });

      _dataSubject.sink.add('Otp has been sent to your mobile');
      callback();
    } on DoccoException catch (e) {
      _dataSubject.sink.addError(e.getMessage().toString());
    } catch (e) {
      _dataSubject.sink.addError(e.toString());
    }
  }

  Future<void> verifyOtp(Function callback) async {
    if (_otp == null || _otp!.isEmpty) {
      _dataSubject.sink.addError('Please enter valid OTP');
      return;
    }

    _dataSubject.sink.add('');

    try {
      await Repository.verifyOtp({
        'phone': _phone,
        'otp': _otp,
      });

      _dataSubject.sink.add('Your otp has been verified');
      callback();
    } on DoccoException catch (e) {
      _dataSubject.sink.addError(e.getMessage().toString());
    } catch (e) {
      _dataSubject.sink.addError(e.toString());
    }
  }

  Future<void> resetPassword(Function callback) async {
    if (_newPassword == null || _newPassword!.isEmpty) {
      String error = 'New password field is empty';
      _dataSubject.sink.addError(error);
      return;
    }

    if (_confirmNewPassword == null || _confirmNewPassword!.isEmpty) {
      String error = 'Confirm new field password is empty';
      _dataSubject.sink.addError(error);
      return;
    }

    if (_newPassword != _confirmNewPassword) {
      String error = 'Entered passwords are not same!';
      _dataSubject.sink.addError(error);
      return;
    }

    _dataSubject.sink.add('');

    try {
      await Repository.resetPassword({
        'phone': _phone,
        'new_password': _newPassword,
      });

      _dataSubject.sink.add('Your password has been reset.');
      callback();
    } on DoccoException catch (e) {
      _dataSubject.sink.addError(e.getMessage().toString());
    } catch (e) {
      _dataSubject.sink.addError(e.toString());
    }
  }

  void dispose() {
    _phoneSubject.close();
    _otpSubject.close();
    _dataSubject.close();
  }
}
