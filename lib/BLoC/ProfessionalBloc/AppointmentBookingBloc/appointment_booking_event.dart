part of 'appointment_booking_bloc.dart';

@immutable
abstract class AppointmentBookingEvent {}


class AddAppointmentButtonPressedEvent extends AppointmentBookingEvent {
  final Professional professional;
  final Customer customer;
  final DateTime appointmentTime;

  AddAppointmentButtonPressedEvent({@required this.professional,@required this.customer,@required this.appointmentTime});

}
