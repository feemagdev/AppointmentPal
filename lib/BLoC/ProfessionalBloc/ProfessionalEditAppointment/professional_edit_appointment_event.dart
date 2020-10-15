part of 'professional_edit_appointment_bloc.dart';

@immutable
abstract class ProfessionalEditAppointmentEvent {}


class ProfessionalShowSelectedDayAppointmentsEvent extends ProfessionalEditAppointmentEvent{
  final Professional professional;
  final DateTime dateTime;
  ProfessionalShowSelectedDayAppointmentsEvent({@required this.professional,@required this.dateTime});
}

class ProfessionalEditAppointmentSelectedEvent extends ProfessionalEditAppointmentEvent{
  final Professional professional;
  final Appointment appointment;
  ProfessionalEditAppointmentSelectedEvent({@required this.appointment,@required this.professional});
}