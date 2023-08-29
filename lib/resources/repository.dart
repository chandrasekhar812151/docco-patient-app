import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/models/available_slot.dart';
import 'package:doctor_patient/models/doctor.dart';
import 'package:doctor_patient/models/doctor_search_result.dart';
import 'package:doctor_patient/models/profile.dart';
import 'package:doctor_patient/resources/api.dart';
import 'package:flutter/material.dart';

class Repository {
  static final _api = Api();  
  static Future<dynamic> login(data) => _api.login(data);

  static Future<dynamic> loginWithGoogle(data) =>
      _api.loginWithGoogle(data);

  static Future<dynamic> register(data) => _api.register(data);
  static Future<List<DoctorSearchResult>> searchDoctor(
          {@required queryString, @required category}) =>
      _api.searchDoctor(
        queryString: queryString,
        category: category,
      );
  
  static Future<Doctor> getDoctorProfile(int id) => _api.getDoctorProfile(id);
  static Future<List<AvailableSlot>> getAvailableSlots(int id) =>
      _api.getAvailableSlots(id);
  static Future<bool> bookAppointment(data) => _api.bookAppointment(data);
  static Future<List<Appointment>> getAppointments() => _api.getAppointments();
  static Future<Appointment> getUpcomingAppointment() =>
      _api.getUpcomingAppointment();
  static Future isSlotAlreadyBooked({doctorId, timeSlotId}) =>
      _api.isSlotAlreadyBooked(doctorId: doctorId, timeSlotId: timeSlotId);
  static Future requestOtp(data) => _api.requestOtp(data);
  static Future verifyOtp(data) => _api.verifyOtp(data);

  static Future<Profile> getProfile() => _api.getProfile();
  static Future<bool> updateProfile(data) => _api.updateProfile(data);

  static Future<String> updateProfilePic(file) => _api.updateProfilePic(file);
  static Future<bool> deleteProfilePic() => _api.deleteProfilePic();

  static Future<bool> resetPassword(data) => _api.resetPassword(data);

  static Future<List<String>> getSymptoms(searchString) =>
      _api.getSymptoms(searchString);
  static Future<bool> logout() => _api.logout();
  static Future<List<Doctor>> getAllDoctors() => _api.getAllDoctors();

  static Future endVideoCall(doctorId) => _api.endVideoCall(doctorId);

  static Future medicineDelivery(doctorId) => _api.medicineDelivery(doctorId);
}
