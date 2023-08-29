import 'package:doctor_patient/models/appointment.dart';
import 'package:doctor_patient/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AppointmentsBloc {
  final _appointmentsSubject = BehaviorSubject<List<Appointment>>();
  final _upcomingAppointmentSubject = BehaviorSubject<Appointment>();
  List<Appointment>? _appointments;
  Appointment? _upcomingAppointment;

  Stream<List<Appointment>> get appointments => _appointmentsSubject.stream;
  Stream<Appointment> get upcomingAppointment =>
      _upcomingAppointmentSubject.stream;

  Future<Appointment?> getUpcomingAppointment() async {
    try {
      final appointment = await Repository.getUpcomingAppointment();
      _upcomingAppointmentSubject.add(appointment);
      return appointment;
    } catch (e) {
      _upcomingAppointmentSubject.addError(e);
    }

    return null;
  }

  Future<List<Appointment>?> getAppointments({bool fromCache = true}) async {
    if (_appointments != null && fromCache == true) {
      return _appointments;
    }


    try {
      _appointments = (await Repository.getAppointments()).cast<Appointment>();
      _upcomingAppointmentSubject.add(_upcomingAppointment!);
      _appointmentsSubject.add(_appointments!);
    } catch (e) {
      _upcomingAppointmentSubject.addError(e);
      _appointmentsSubject.addError(e);
    }

    return _appointments;
  }

  void dispose() {
    _upcomingAppointmentSubject.close();
  }
}
