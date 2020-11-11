part of 'professional_edit_appointment_bloc.dart';

@immutable
abstract class ProfessionalEditAppointmentState {}

class ProfessionalEditAppointmentInitial
    extends ProfessionalEditAppointmentState {}

class ProfessionalShowSelectedDayAppointmentsState
    extends ProfessionalEditAppointmentState {
  final List<Appointment> appointments;
  final List<Customer> customers;

  ProfessionalShowSelectedDayAppointmentsState(
      {@required this.appointments, @required this.customers});
}

class ProfessionalAppointmentIsSelectedState extends ProfessionalEditAppointmentState {
  final Appointment appointment;
  final Customer customer;

  ProfessionalAppointmentIsSelectedState(
      {@required this.appointment, @required this.customer});
}

class MoveToDashboardScreenFromEditAppointmentState
    extends ProfessionalEditAppointmentState {}

class ProfessionalEditAppointmentLoadingState extends ProfessionalEditAppointmentState {}

