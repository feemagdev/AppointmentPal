part of 'update_appointment_bloc.dart';

@immutable
abstract class UpdateAppointmentEvent {}


class UpdateAppointmentDateTimeEvent extends UpdateAppointmentEvent {}

class MoveToEditAppointmentScreenEvent extends UpdateAppointmentEvent {}

class UpdateAppointmentSelectCustomerEvent extends UpdateAppointmentEvent {}

class UpdateAppointmentButtonPressedEvent extends UpdateAppointmentEvent {
  final Appointment appointment;
  UpdateAppointmentButtonPressedEvent({@required this.appointment});
}
