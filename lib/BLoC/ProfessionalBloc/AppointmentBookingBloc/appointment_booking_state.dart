part of 'appointment_booking_bloc.dart';

@immutable
abstract class AppointmentBookingState {}

class AppointmentBookingInitial extends AppointmentBookingState {
  final Professional professional;
  final Customer customer;
  final DateTime startDateTime;
  final Schedule schedule;

  AppointmentBookingInitial({@required this.professional,@required this.customer,@required this.startDateTime,@required this.schedule});

}

class AppointmentBookedSuccessfully extends AppointmentBookingState {
  final Professional professional;
  AppointmentBookedSuccessfully({@required this.professional});
}
