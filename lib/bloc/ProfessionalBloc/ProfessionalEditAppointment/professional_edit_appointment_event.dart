part of 'professional_edit_appointment_bloc.dart';

@immutable
abstract class ProfessionalEditAppointmentEvent {}


class ProfessionalShowSelectedDayAppointmentsEvent extends ProfessionalEditAppointmentEvent{
  final DateTime dateTime;
  ProfessionalShowSelectedDayAppointmentsEvent({@required this.dateTime});
}

class ProfessionalEditAppointmentSelectedEvent extends ProfessionalEditAppointmentEvent{
  final Appointment appointment;
  final Customer customer;

  ProfessionalEditAppointmentSelectedEvent(
      {@required this.appointment, @required this.customer});
}


class MoveToDashboardScreenFromEditAppointmentEvent
    extends ProfessionalEditAppointmentEvent {}