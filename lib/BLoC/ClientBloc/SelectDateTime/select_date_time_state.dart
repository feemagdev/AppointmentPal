part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeState {}

class SelectDateTimeInitial extends SelectDateTimeState {
  final Professional professional;
  final Appointment appointment;
  SelectDateTimeInitial({@required this.professional,this.appointment});
}

class ShowAvailableTimeState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  ShowAvailableTimeState({@required this.professional,@required this.schedule,@required this.timeSlots});

}


class NoScheduleAvailable extends SelectDateTimeState {
  final Professional professional;
  final DateTime dateTime;
  NoScheduleAvailable({@required this.professional,@required this.dateTime});
}


class TimeSlotSelectedState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final int selectedIndex;
  TimeSlotSelectedState({@required this.professional,this.schedule,this.timeSlots,this.selectedIndex});
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
  final DateTime selectedDateTime;
  final Schedule schedule;

  MoveToSelectCustomerScreenState({@required this.professional,@required this.selectedDateTime,@required this.schedule});
}


class MoveToDashboardScreenState extends SelectDateTimeState {
  final Professional professional;

  MoveToDashboardScreenState({@required this.professional});
}


