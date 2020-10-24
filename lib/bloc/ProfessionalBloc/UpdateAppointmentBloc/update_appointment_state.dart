part of 'update_appointment_bloc.dart';

@immutable
abstract class UpdateAppointmentState {}

class UpdateAppointmentInitial extends UpdateAppointmentState {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;

  UpdateAppointmentInitial({@required this.professional,@required this.appointment,@required this.customer});

}


class UpdateAppointmentDateTimeState extends UpdateAppointmentState {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;

  UpdateAppointmentDateTimeState ({@required this.professional,@required this.appointment,@required this.customer});


}

class MoveToEditAppointmentScreenState extends UpdateAppointmentState {
  final Professional professional;
  MoveToEditAppointmentScreenState({@required this.professional});

}
