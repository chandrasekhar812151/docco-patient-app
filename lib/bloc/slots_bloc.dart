// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:doctor_patient/resources/prefs.dart';
import 'package:doctor_patient/services/payment.dart';
import 'package:flutter/material.dart';
import 'package:doctor_patient/models/available_slot.dart';
import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

List<String> pageTitles = ['Select Slot', 'Details', 'Confirmation'];

class SlotsBloc {
  final List<RadioModel> _appointmentTypes = [
    RadioModel(true, 'video_call', 'Video Call', Icons.video_call),
    RadioModel(false, 'visit', 'Visit', Icons.import_contacts),
    RadioModel(false, 'audio_call', 'Audio Call', Icons.call),
  ];

  final _slotsSubject = BehaviorSubject<SlotsModel>();
  final _formattedSlotsSubject = BehaviorSubject<Map<String, dynamic>>();
  final _appointmentTypesSubject = BehaviorSubject<List<RadioModel>>();
  final _doctorSubject = BehaviorSubject<Doctor>();
  final _selectedDaySlotsSubject = BehaviorSubject<List<dynamic>>();

  SlotsModel model = SlotsModel();

  Stream<Doctor> get doctorStream => _doctorSubject.stream;
  Stream<Map<String, dynamic>> get formattedSlotsStream =>
      _formattedSlotsSubject.stream;
  Stream<List<dynamic>> get selectedDaySlotsStream =>
      _selectedDaySlotsSubject.stream;
  Stream<List<RadioModel>> get appointmentTypesStream =>
      _appointmentTypesSubject.stream;
  Stream<SlotsModel> get slots => _slotsSubject.stream;

  Map<String, dynamic>? formattedSlots;
  String? _selectedDayString;

  Doctor? _doctor;

  Future setSlots(List<AvailableSlot> slots) async {
    formattedSlots = getFormattedSlots(slots);
    _formattedSlotsSubject.add(formattedSlots!);
    _appointmentTypesSubject.add(_appointmentTypes);
  }

  Future setDoctor(doctor) async {
    _doctor = doctor;
    model.doctor = doctor;
    model.doctorId = doctor.id;
    _doctorSubject.add(doctor);
    _slotsSubject.sink.add(model);
  }

  void setIssue(issue) {
    model.issue = issue;
    _slotsSubject.sink.add(model);
  }

  void selectSlot(slotIndex) {
    List l = formattedSlots?[_selectedDayString]['timings'];
    for (var item in l) {
      item['isSelected'] = false;
    }

    formattedSlots?[_selectedDayString]['timings'][slotIndex]['isSelected'] =
        true;

    DateTime fromTime =
        formattedSlots?[_selectedDayString]['timings'][slotIndex]['fromTime'];
    DateTime toTime =
        formattedSlots?[_selectedDayString]['timings'][slotIndex]['toTime'];

    model.fromTimeString = DateFormat('yyyy-MM-dd HH:mm:ss').format(fromTime);
    model.toTimeString = DateFormat('yyyy-MM-dd HH:mm:ss').format(toTime);


    _selectedDaySlotsSubject.add(formattedSlots?[_selectedDayString]['timings']);
    _slotsSubject.sink.add(model);
  }

  void selectDay(key) {
    _selectedDayString = key;
    _selectedDaySlotsSubject.add(formattedSlots?[key]['timings']);
    _formattedSlotsSubject.add(formattedSlots!);
  }

  void changeAppointmentType(index) {
    for (var element in _appointmentTypes) {
      element.isSelected = false;
    }
    _appointmentTypes[index].isSelected = true;
    model.appointmentType = _appointmentTypes[index].value;

    _slotsSubject.sink.add(model);
  }

  void onPageChanged(index) {
    model.pageTitle = pageTitles[index];
    if (index == pageTitles.length - 1) {
      model.nextText = "";
    } else {
      model.nextText = 'NEXT';
    }
    _slotsSubject.sink.add(model);
  }

  Map<String, dynamic> getFormattedSlots(List<AvailableSlot> slots) {
    Map<String, dynamic> formattedSlots = {};

    for (int i = 0; i < slots.length; i++) {
      var fromTime = DateTime.parse(slots[i].fromTime.toString());
      var toTime = DateTime.parse(slots[i].toTime.toString());
      if (fromTime.day != toTime.day) {
        continue;
      }

      String dateString = DateFormat('yyyy-MM-dd').format(fromTime.toLocal());
      if (formattedSlots[dateString] == null) {
        formattedSlots[dateString] = {'isSelected': false, 'timings': []};
      }

      formattedSlots[dateString]['timings'].add({
        'fromTime': fromTime,
        'toTime': toTime,
        'isSelected': false,
      });
    }

    return formattedSlots;
  }

  Future bookAppointment({required bool isPaymentDue}) async {
    Map<String, dynamic> data = {
      'doctor_id': _doctor?.id.toString(),
      'type': model.appointmentType,
      'issue': model.issue ?? '',
      'from_time': model.fromTimeString,
      'to_time': model.toTimeString,
      'status': 'requested',
      'symptoms': model.symptoms,
      'is_payment_due': isPaymentDue == true ? "1" : "0",
    };

    // if (!model.medicalReport1.isNull) {
    //   // data['medical_report1'] = UploadFileInfo(model.medicalReport1, model.medicalReport1.path.split('/').last);
    // }
    //
    // if (!model.medicalReport2.isNull) {
    //   // data['medical_report2'] = UploadFileInfo(model.medicalReport2, model.medicalReport2.path.split('/').last);
    // }

    await Repository.bookAppointment(data);
    clearModel();
  }

  void setMedicalReport1(file) {
    model.medicalReport1 = file;
    _slotsSubject.sink.add(model);
  }

  void setMedicalReport2(file) {
    model.medicalReport2 = file;
    _slotsSubject.sink.add(model);
  }

  void updateSymptoms(String symptoms) {
    model.symptoms = symptoms;
  }

  Future<dynamic> makePayment() async {
    Map<dynamic, dynamic> paymentResult = await Payment.startPayment(
        name: await Prefs.getUsername(),
        email: await Prefs.getEmail() ?? '',
        image: 'https://i.ibb.co/QPk4gSY/logo-512x512.png',
        amount: _doctor!.fee.toString(),
        contact: await Prefs.getPhone());


    return paymentResult;
  }

  void clearModel() {
    model = SlotsModel();
    _appointmentTypes.clear();
    _appointmentTypes.add(
        RadioModel(true, 'video_call', 'Video Call', Icons.video_call));
    _appointmentTypes
        .add(RadioModel(false, 'visit', 'Visit', Icons.import_contacts));
    _appointmentTypes
        .add(RadioModel(false, 'audio_call', 'Audio Call', Icons.call));

    var a;

    _formattedSlotsSubject.sink.add(a);

    model.doctor = a;
    model.selectedDay = a;
    model.selectedSlot = a;
    model.doctorId = a;
    model.nextText = 'NEXT';
    model.pageTitle = 'Select Slot';
    model.fromTimeString = a;
    model.toTimeString = a;
    model.medicalReport1 = a;
    model.medicalReport2 = a;
    model.slotId = a;
    model.appointmentType = 'video_call';
    model.issue = a;
    model.symptoms = "";
  }

  void dispose() {
    _slotsSubject.close();
  }
}

// class for selecting appointment type
class RadioModel {
  bool isSelected;
  final String text;
  final String value;
  final IconData icon;

  RadioModel(this.isSelected, this.value, this.text, this.icon);
}

// class for sending the form data
class SlotsModel {
  Doctor? doctor;
  AvailableSlot? selectedDay;
  AvailableSlot? selectedSlot;
  int? doctorId;
  String nextText = 'NEXT';
  String pageTitle = 'Select Slot';

  // from time and to time in YYYY-MM-DD HH:MM:SS format
  String? fromTimeString;
  String? toTimeString;

  File? medicalReport1;
  File? medicalReport2;

  // following fields are for appointment post request
  int? slotId;
  String appointmentType = 'video_call';
  String? issue;

  String symptoms = "";
}
