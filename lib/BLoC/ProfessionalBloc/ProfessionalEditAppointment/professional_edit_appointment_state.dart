part of 'professional_edit_appointment_bloc.dart';

@immutable
abstract class ProfessionalEditAppointmentState {}

class ProfessionalEditAppointmentInitial extends ProfessionalEditAppointmentState {
  final Professional professional;
  ProfessionalEditAppointmentInitial({@required this.professional});

}
class ProfessionalShowSelectedDayAppointmentsState extends ProfessionalEditAppointmentState {
  final Professional professional;
  final List<Appointment> appointments;
  ProfessionalShowSelectedDayAppointmentsState({@required this.professional,@required this.appointments});
}

class ProfessionalAppointmentIsSelectedState extends ProfessionalEditAppointmentState {
  final Professional professional;
  final Appointment appointment;

  ProfessionalAppointmentIsSelectedState({@required this.appointment,@required this.professional});
}

