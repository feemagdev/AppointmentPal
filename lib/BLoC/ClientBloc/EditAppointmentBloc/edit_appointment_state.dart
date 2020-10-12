part of 'edit_appointment_bloc.dart';

@immutable
abstract class EditAppointmentState {}

class EditAppointmentInitial extends EditAppointmentState {
  final Client client;
  EditAppointmentInitial({@required this.client});
}

class ShowSelectedDayAppointmentsState extends EditAppointmentState {
  final Client client;
  final List<Appointment> appointments;
  ShowSelectedDayAppointmentsState({@required this.client,@required this.appointments});
}

class AppointmentIsSelectedState extends EditAppointmentState{
  final Appointment appointment;
  AppointmentIsSelectedState({@required this.appointment});
}


class DummyState extends EditAppointmentState{}
