part of 'add_automatic_schedule_bloc.dart';

abstract class AddAutomaticScheduleEvent {}

class GetAutomaticScheduleOfSelectedDayEvent extends AddAutomaticScheduleEvent {
}

class UpdateAutomaticScheduleEvent extends AddAutomaticScheduleEvent {
  final Schedule schedule;
  UpdateAutomaticScheduleEvent({@required this.schedule});
}
