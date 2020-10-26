part of 'today_appointment_bloc.dart';

@immutable
abstract class TodayAppointmentEvent {}



class GetAllTodayAppointments extends TodayAppointmentEvent {}

class MarkAppointmentComplete extends TodayAppointmentEvent {
  final Appointment appointment;
  MarkAppointmentComplete({@required this.appointment});
}

class MarkAppointmentCancel extends TodayAppointmentEvent {
  final Appointment appointment;
  MarkAppointmentCancel({@required this.appointment});
}
