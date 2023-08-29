import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/models/available_slot.dart';
import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/models/doctor_search_result.dart';
import 'package:doctor_patient/models/profile.dart';
import 'package:doctor_patient/resources/api_urls.dart';
import 'package:doctor_patient/resources/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static final TAG = 'Api';
  Client client = Client();
  HttpHelper? httpHelper;

  Api() {
    httpHelper = HttpHelper();
  }

  Future<Null> medicineDelivery(data) async {
    await httpHelper?.post(ApiUrls.medicineDelivery, data);
  }

  Future<Null> endVideoCall(doctorId) async {
    await httpHelper?.get('${ApiUrls.endVideoCall}?doctor_id=$doctorId');
  }

  Future<List<Doctor>> getAllDoctors() async {
    final response = await httpHelper?.get(ApiUrls.doctors);
    Iterable l = response?.data;
    List<Doctor> doctors =
        l.map((model) => Doctor.fromJson(model)).toList();
    return doctors;
  }

  Future requestOtp(data) async {
    await httpHelper?.post(ApiUrls.requestOtp, data);
  }

  Future verifyOtp(data) async {
    await httpHelper?.post(ApiUrls.verifyOtp, data);
  }

  Future isSlotAlreadyBooked({required int doctorId, required int timeSlotId}) async {
    await httpHelper?.post(ApiUrls.isSlotAlreadyBooked, {
      'doctor_id': doctorId.toString(),
      'time_slot_id': timeSlotId.toString()
    });
  }

  Future<List<Appointment>> getAppointments() async {
    String url = ApiUrls.appointments;

    final response = await httpHelper?.get(url);

    print(response?.data);
    print('status ${response?.statusCode}');
    Iterable l = response?.data;
    List<Appointment> appointments =
        l.map((model) => Appointment.fromJson(model)).toList();
    return appointments;
  }

  Future<Appointment> getUpcomingAppointment() async {
    String url = '${ApiUrls.appointments}?status=upcoming';

    final response = await httpHelper?.get(url);

    print(response?.data);
    print('status ${response?.statusCode}');
    Appointment appointment = Appointment.fromJson(response?.data);
    return appointment;
  }

  Future<bool> bookAppointment(data) async {
    await httpHelper?.postFormData(ApiUrls.appointments, data);
    return true;
  }

  Future<List<AvailableSlot>> getAvailableSlots(int doctorId) async {
    String url =
        ApiUrls.availableSlots.replaceAll("{{id}}", doctorId.toString());

    final response = await httpHelper?.get(url);
    Iterable l = response?.data;
    List<AvailableSlot> doctors =
        l.map((model) => AvailableSlot.fromJson(model)).toList();
    return doctors;
  }

  Future<List<DoctorSearchResult>> searchDoctor({
    @required queryString,
    @required category,
  }) async {
    final response = await httpHelper
        ?.get('${ApiUrls.searchDoctor}?query=$queryString&category=$category');

    print(response?.data);
    print('status ${response?.statusCode}');

    Iterable l = response?.data;
    List<DoctorSearchResult> doctors =
        l.map((model) => DoctorSearchResult.fromJson(model)).toList();
    return doctors;
  }

  Future<Doctor> getDoctorProfile(int id) async {
    String url = ApiUrls.doctorProfile.replaceAll('{{id}}', id.toString());
    final response = await httpHelper?.get(url);

    print(response?.data);
    print('status ${response?.statusCode}');

    Doctor doctor = Doctor.fromJson(response?.data);
    return doctor;
  }

  Future<dynamic> login(data) async {
    final response = await httpHelper?.post(ApiUrls.login, data);

    print(response?.data);
    print('status ${response?.statusCode}');

    return response?.data;
  }

  Future<dynamic> loginWithGoogle(data) async {
    final response = await httpHelper?.post(ApiUrls.loginWithGoogle, data);

    print(response?.data);
    print('status ${response?.statusCode}');

    return response?.data;
  }

  Future<dynamic> register(Map data) async {
    final response = await httpHelper?.post(ApiUrls.register, data);
    debugPrint('$TAG ${response?.data}');
    return response?.data;
  }

  Future<bool> logout() async {
    await httpHelper?.get(ApiUrls.logout);
    return true;
  }

  Future<Profile> getProfile() async {
    final response = await httpHelper?.get(ApiUrls.profile);
    return Profile.fromJson(response?.data);
  }

  Future<bool> updateProfile(Map data) async {
    await httpHelper?.post(ApiUrls.profile, data);
    return true;
  }

  Future<String> updateProfilePic(File imageFile) async {
    var response = await httpHelper?.postFormData(ApiUrls.profilePicture, {
      // 'picture': new UploadFileInfo(imageFile, basename(imageFile.path)),
    });

    return response?.data;
  }

  Future<bool> deleteProfilePic() async {
    await httpHelper?.delete(ApiUrls.profilePicture);
    return true;
  }

  Future<bool> resetPassword(data) async {
    await httpHelper?.post(ApiUrls.resetPassword, data);
    return true;
  }

  Future<List<String>> getSymptoms(searchString) async {
    final url = '${ApiUrls.symptoms}?query=$searchString';
    final response = await httpHelper?.get(url);
    return List<String>.from(response?.data);
  }
}
