part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeEvent {}

class ShowAvailableTimeEvent extends SelectDateTimeEvent {
  final DateTime dateTime;

  ShowAvailableTimeEvent({
    @required this.dateTime,
  });
}

class TimeSlotSelectedEvent extends SelectDateTimeEvent {
  final List<DateTime> schedules;
  final int scheduleIndex;
  final Schedule schedule;

  TimeSlotSelectedEvent(
      {@required this.schedules,
      @required this.scheduleIndex,
      @required this.schedule});
}

class ProfessionalBookedTheAppointmentButtonEvent extends SelectDateTimeEvent {
  final Professional professional;
  final String clientName;
  final String clientPhone;
  final DateTime dateTime;

  ProfessionalBookedTheAppointmentButtonEvent(
      {@required this.professional,
      @required this.clientName,
      @required this.clientPhone,
      @required this.dateTime});
}

class TimeSlotIsSelectedEvent extends SelectDateTimeEvent {
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  TimeSlotIsSelectedEvent(
      {@required this.appointmentStartTime, @required this.appointmentEndTime});
}

class MoveToDashboardScreenEvent extends SelectDateTimeEvent {
  final Professional professional;

  MoveToDashboardScreenEvent({@required this.professional});
}

class MoveToUpdateAppointmentScreenEvent extends SelectDateTimeEvent {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;

  MoveToUpdateAppointmentScreenEvent({@required this.professional,
    @required this.appointment,
    @required this.customer});
}
