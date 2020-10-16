part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeEvent {}

class ShowAvailableTimeEvent extends SelectDateTimeEvent {
  final Professional professional;
  final DateTime dateTime;

  ShowAvailableTimeEvent(
      {@required this.professional,
      @required this.dateTime});
}

class TimeSlotSelectedEvent extends SelectDateTimeEvent {
  final Professional professional;
  final List<DateTime> schedules;
  final int scheduleIndex;
  final Schedule schedule;

  TimeSlotSelectedEvent(
      {@required this.professional,
      @required this.schedules,
      @required this.scheduleIndex,
      @required this.schedule});
}

class AppointmentIsBookedEvent extends SelectDateTimeEvent {
  final Professional professional;
  final SubServices subServices;
  final Service service;
  final Client client;
  final DateTime dateTime;
  final FirebaseUser user;
  final String name;
  final String phone;

  AppointmentIsBookedEvent(
      {@required this.professional,
      @required this.client,
      @required this.service,
      @required this.subServices,
      @required this.dateTime,
      @required this.user,
      @required this.name,
      @required this.phone});
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

class ProfessionalUpdateAppointmentButtonEvent extends SelectDateTimeEvent {
  final Professional professional;
  final Appointment appointment;
  final String clientName;
  final String clientPhone;
  final DateTime dateTime;

  ProfessionalUpdateAppointmentButtonEvent(
      {@required this.appointment,
      @required this.clientName,
      @required this.clientPhone,
      @required this.dateTime,
      @required this.professional});
}


class MoveToSelectCustomerScreenEvent extends SelectDateTimeEvent {
  final Professional professional;
  final DateTime selectedDateTime;

  MoveToSelectCustomerScreenEvent({@required this.professional,@required this.selectedDateTime});

}
