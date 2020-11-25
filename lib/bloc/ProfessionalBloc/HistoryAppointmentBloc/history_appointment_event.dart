part of 'history_appointment_bloc.dart';

abstract class HistoryAppointmentEvent {}

class GetHistoryOfCompletedAppointmentEvent extends HistoryAppointmentEvent {
  final DateTime dateTime;
  GetHistoryOfCompletedAppointmentEvent({@required this.dateTime});
}

class GetHistoryOfCanceledAppointmentEvent extends HistoryAppointmentEvent {
  final DateTime dateTime;
  GetHistoryOfCanceledAppointmentEvent({@required this.dateTime});
}
