part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeState {}

class SelectDateTimeInitial extends SelectDateTimeState {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  SelectDateTimeInitial({@required this.professional,this.appointment,this.customer});
}

class ShowAvailableTimeState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final Appointment appointment;
  final Customer customer;
  ShowAvailableTimeState({@required this.professional,@required this.schedule,@required this.timeSlots,this.appointment,this.customer});

}


class NoScheduleAvailable extends SelectDateTimeState {
  final Professional professional;
  final DateTime dateTime;
  final Appointment appointment;
  final Customer customer;
  NoScheduleAvailable({@required this.professional,@required this.dateTime,this.customer,this.appointment});
}


class TimeSlotSelectedState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final int selectedIndex;
  final Appointment appointment;
  final Customer customer;
  TimeSlotSelectedState({@required this.professional,this.schedule,this.timeSlots,this.selectedIndex,this.appointment,this.customer});
}


class AppointmentIsBookedState extends SelectDateTimeState {}

class ProfessionalAppointmentIsBookedState extends SelectDateTimeState {
  final Professional professional;
  ProfessionalAppointmentIsBookedState({@required this.professional});
}

class ProfessionalUpdateAppointmentState extends SelectDateTimeState {
  final Professional professional;
  ProfessionalUpdateAppointmentState({@required this.professional});
}

class MoveToSelectCustomerScreenState extends SelectDateTimeState {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  MoveToSelectCustomerScreenState({@required this.professional,@required this.appointmentStartTime,@required this.appointmentEndTime});
}

class MoveToUpdateAppointmentScreenState extends SelectDateTimeState {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  MoveToUpdateAppointmentScreenState({@required this.professional,@required this.appointment,@required this.customer});

}


class MoveToDashboardScreenState extends SelectDateTimeState {
  final Professional professional;

  MoveToDashboardScreenState({@required this.professional});
}


class SelectDateTimeLoadingState extends SelectDateTimeState {}


