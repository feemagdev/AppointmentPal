part of 'today_appointment_bloc.dart';

@immutable
abstract class TodayAppointmentState {}

class TodayAppointmentInitial extends TodayAppointmentState {}

class GetAllTodayAppointmentState extends TodayAppointmentState {
  final List<Appointment> appointments;
  final List<Customer> customers;
  GetAllTodayAppointmentState({@required this.appointments,@required this.customers});
}

class TodayAppointmentLoadingState extends TodayAppointmentState {}
