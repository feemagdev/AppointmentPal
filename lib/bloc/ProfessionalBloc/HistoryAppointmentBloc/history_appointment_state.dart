part of 'history_appointment_bloc.dart';

abstract class HistoryAppointmentState {}

class HistoryAppointmentInitial extends HistoryAppointmentState {}

class GetHistoryOfCompletedAppointmentState extends HistoryAppointmentState {
  final List<Appointment> appointmentList;
  final List<Customer> customerList;
  GetHistoryOfCompletedAppointmentState(
      {@required this.appointmentList, @required this.customerList});
}

class GetHistoryOfCanceledAppointmentState extends HistoryAppointmentState {
  final List<Appointment> appointmentList;
  final List<Customer> customerList;
  GetHistoryOfCanceledAppointmentState(
      {@required this.appointmentList, @required this.customerList});
}

class NoHistoryCompletedAppointmentFoundState extends HistoryAppointmentState {}

class HistoryAppointmentLoadingState extends HistoryAppointmentState {}
