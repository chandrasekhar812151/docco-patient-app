import 'package:doctor_patient/bloc/doctor_search_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:doctor_patient/bloc/appointments_bloc.dart';
import 'package:doctor_patient/bloc/password_reset_bloc.dart';
import 'package:doctor_patient/bloc/profile_bloc.dart';
import 'package:doctor_patient/bloc/register_bloc.dart';
import 'package:doctor_patient/bloc/slots_bloc.dart';

GetIt sl = GetIt.instance;

void setup() {
  sl.registerSingleton<RegisterBloc>(RegisterBloc());
  sl.registerSingleton<ProfileBloc>(ProfileBloc());
  sl.registerSingleton<AppointmentsBloc>(AppointmentsBloc());
  sl.registerSingleton<PasswordResetBloc>(PasswordResetBloc());
  sl.registerSingleton<SlotsBloc>(SlotsBloc());
  sl.registerSingleton<DoctorSearchBloc>(DoctorSearchBloc());
}