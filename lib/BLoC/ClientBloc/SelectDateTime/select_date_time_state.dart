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
  final String name;
  final String phone;
  ShowAvailableTimeState({@required this.professional,@required this.schedule,@required this.timeSlots,@required this.name,@required this.phone});

}


class NoScheduleAvailable extends SelectDateTimeState {
  final Professional professional;
  final DateTime dateTime;
  final String name;
  final String phone;
  NoScheduleAvailable({@required this.professional,@required this.dateTime,@required this.name,@required this.phone});
}


class TimeSlotSelectedState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final int selectedIndex;
  final String name;
  final String phone;
  TimeSlotSelectedState({@required this.professional,this.schedule,this.timeSlots,this.selectedIndex,@required this.name,@required this.phone});
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


