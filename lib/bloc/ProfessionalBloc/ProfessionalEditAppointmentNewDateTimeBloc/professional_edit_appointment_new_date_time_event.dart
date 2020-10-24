part of 'professional_edit_appointment_new_date_time_bloc.dart';

@immutable
abstract class ProfessionalEditAppointmentNewDateTimeEvent {}




class EditAppointmentShowSelectedDayTimeEvent extends ProfessionalEditAppointmentNewDateTimeEvent{
  final Appointment appointment;
  final DateTime dateTime;
  EditAppointmentShowSelectedDayTimeEvent({@required this.appointment,@required this.dateTime});
}


class ProfessionalTimeSlotSelectedEvent extends ProfessionalEditAppointmentNewDateTimeEvent {
  final Appointment appointment;
  final List<DateTime> schedules;
  final int scheduleIndex;
  final Schedule schedule;

  ProfessionalTimeSlotSelectedEvent(
      {@required this.appointment,
        @required this.schedules,
        @required this.scheduleIndex,
        @required this.schedule});
}


class ProfessionalEditAppointmentBookedButtonEvent extends ProfessionalEditAppointmentNewDateTimeEvent {
  final Appointment appointment;
  final String clientName;
  final String clientPhone;
  final DateTime dateTime;

  ProfessionalEditAppointmentBookedButtonEvent(
      {@required this.appointment,
        @required this.clientName,
        @required this.clientPhone,
        @required this.dateTime});


}
