part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeState {}

class SelectDateTimeInitial extends SelectDateTimeState {
  final Professional professional;
  SelectDateTimeInitial({@required this.professional});
}

class ShowAvailableTimeState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;

  ShowAvailableTimeState({@required this.professional,@required this.schedule,@required this.timeSlots});

}


class NoScheduleAvailable extends SelectDateTimeState {
  final Professional professional;
  NoScheduleAvailable({@required this.professional});
}


class TimeSlotSelectedState extends SelectDateTimeState{
  final Professional professional;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final int selectedIndex;

  TimeSlotSelectedState({@required this.professional,this.schedule,this.timeSlots,this.selectedIndex});
}


class AppointmentIsBookedState extends SelectDateTimeState {}


