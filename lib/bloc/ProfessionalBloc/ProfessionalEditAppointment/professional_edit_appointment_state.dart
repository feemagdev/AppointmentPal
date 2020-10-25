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
  final List<Customer> customers;
  ProfessionalShowSelectedDayAppointmentsState({@required this.professional,@required this.appointments,@required this.customers});
}

class ProfessionalAppointmentIsSelectedState extends ProfessionalEditAppointmentState {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  ProfessionalAppointmentIsSelectedState({@required this.appointment,@required this.professional,@required this.customer});
}

class MoveToDashboardScreenFromEditAppointmentState extends ProfessionalEditAppointmentState {
  final Professional professional;
  MoveToDashboardScreenFromEditAppointmentState({@required this.professional});
}

class ProfessionalEditAppointmentLoadingState extends ProfessionalEditAppointmentState {}

