part of 'update_appointment_bloc.dart';

@immutable
abstract class UpdateAppointmentEvent {}


class UpdateAppointmentDateTimeEvent extends UpdateAppointmentEvent {
  final Professional professional;
  final Customer customer;
  final Appointment appointment;

  UpdateAppointmentDateTimeEvent({@required this.professional,@required this.appointment,@required this.customer});

}

class MoveToEditAppointmentScreenEvent extends UpdateAppointmentEvent {
  final Professional professional;
  MoveToEditAppointmentScreenEvent({@required this.professional});
}
