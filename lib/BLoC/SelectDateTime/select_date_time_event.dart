part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeEvent {}


class ShowAvailableTimeEvent extends SelectDateTimeEvent{
  final Professional professional;
  final DateTime dateTime;

  ShowAvailableTimeEvent({@required this.professional,@required this.dateTime});

}


class TimeSlotSelectedEvent extends SelectDateTimeEvent{
  final Professional professional;
  final List<DateTime> schedules;
  final int scheduleIndex;
  final Schedule schedule;
  TimeSlotSelectedEvent({@required this.professional, @required this.schedules, @required this.scheduleIndex,@required this.schedule});
}




