part of 'update_appointment_bloc.dart';

@immutable
abstract class UpdateAppointmentEvent {}

class UpdateAppointmentDateTimeEvent extends UpdateAppointmentEvent {}

class MoveToEditAppointmentScreenEvent extends UpdateAppointmentEvent {}

class UpdateAppointmentSelectCustomerEvent extends UpdateAppointmentEvent {}

class UpdateAppointmentButtonPressedEvent extends UpdateAppointmentEvent {
  final Appointment appointment;
  final bool smsCheck;
  UpdateAppointmentButtonPressedEvent(
      {@required this.appointment, @required this.smsCheck});
}

class CancelAppointmentEvent extends UpdateAppointmentEvent {
  final Appointment appointment;
  final bool smsCheck;

  CancelAppointmentEvent({@required this.appointment, @required this.smsCheck});
}
