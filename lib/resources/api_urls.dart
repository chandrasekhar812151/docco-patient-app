import 'package:doctor_patient/config.dart';

class ApiUrls {

  static String _host = Config.apiUrl;

  static final login = '$_host/patient/login';
  static final loginWithGoogle = '$_host/patient/login-with-google';
  static final register = '$_host/patient/register';
  static final logout = '$_host/logout';
  static final profile = '$_host/patient/profile';
  static final profilePicture = '$_host/patient/profile/picture';
  static final searchDoctor = '$_host/patient/search-doctor';
  static final doctorProfile = '$_host/patient/doctors/{{id}}';
  static final availableSlots = '$_host/patient/doctors/{{id}}/available-slots';
  static final appointments = '$_host/patient/appointments';
  static final isSlotAlreadyBooked = '$_host/patient/appointments/is-already-booked';
  static final requestOtp = '$_host/otp/request';
  static final verifyOtp = '$_host/otp/verify';
  static final resetPassword = '$_host/reset-password';
  static final symptoms = '$_host/patient/symptoms';
  static final doctors = '$_host/patient/doctors';
  static final endVideoCall = '$_host/patient/end-video-call';
  static final medicineDelivery = '$_host/patient/medicine-delivery';
}