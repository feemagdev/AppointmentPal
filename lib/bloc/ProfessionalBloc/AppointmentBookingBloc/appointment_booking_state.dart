part of 'appointment_booking_bloc.dart';

@immutable
abstract class AppointmentBookingState {}

class AppointmentBookingInitial extends AppointmentBookingState {
  final Customer customer;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  AppointmentBookingInitial(
      {@required this.customer,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime});
}

class AppointmentBookedSuccessfully extends AppointmentBookingState {
  final Professional professional;
  AppointmentBookedSuccessfully({@required this.professional});
}
