part of 'add_automatic_schedule_bloc.dart';

abstract class AddAutomaticScheduleState {}

class AddAutomaticScheduleInitial extends AddAutomaticScheduleState {}

class AddAutomaticScheduleLoadingState extends AddAutomaticScheduleState {}

class GetAutomaticScheduleOfSelectedDayState extends AddAutomaticScheduleState {
  final Schedule schedule;
  GetAutomaticScheduleOfSelectedDayState({@required this.schedule});
}

class NoScheduleAvailableState extends AddAutomaticScheduleState {}

class ScheduleUpdatedSuccessfullyState extends AddAutomaticScheduleState {}
