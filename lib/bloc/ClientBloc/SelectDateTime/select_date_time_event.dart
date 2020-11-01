part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeEvent {}

class ShowAvailableTimeEvent extends SelectDateTimeEvent {
  final Professional professional;
  final DateTime dateTime;
  final Appointment appointment;
  final Customer customer;

  ShowAvailableTimeEvent(
      {@required this.professional,
      @required this.dateTime,
      this.appointment,
      this.customer});
}

class TimeSlotSelectedEvent extends SelectDateTimeEvent {
  final Professional professional;
  final List<DateTime> schedules;
  final int scheduleIndex;
  final Schedule schedule;
  final Appointment appointment;
  final Customer customer;

  TimeSlotSelectedEvent(
      {@required this.professional,
      @required this.schedules,
      @required this.scheduleIndex,
      @required this.schedule,
      this.appointment,this.customer});
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
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  TimeSlotIsSelectedEvent(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.appointment,
      this.customer});
}

class MoveToDashboardScreenEvent extends SelectDateTimeEvent {
  final Professional professional;

  MoveToDashboardScreenEvent({@required this.professional});
}


class MoveToUpdateAppointmentScreenEvent extends SelectDateTimeEvent {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;

  MoveToUpdateAppointmentScreenEvent({@required this.professional,@required this.appointment,@required this.customer});


}
