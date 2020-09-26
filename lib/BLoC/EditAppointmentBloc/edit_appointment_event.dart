part of 'edit_appointment_bloc.dart';

@immutable
abstract class EditAppointmentEvent {}


class ShowSelectedDayAppointmentsEvent extends EditAppointmentEvent{
  final Client client;
  final DateTime dateTime;
  ShowSelectedDayAppointmentsEvent({@required this.client,@required this.dateTime});
}
