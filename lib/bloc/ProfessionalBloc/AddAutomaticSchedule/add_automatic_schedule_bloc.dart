import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_automatic_schedule_event.dart';
part 'add_automatic_schedule_state.dart';

class AddAutomaticScheduleBloc
    extends Bloc<AddAutomaticScheduleEvent, AddAutomaticScheduleState> {
  final String day;
  final Professional professional;
  AddAutomaticScheduleBloc({@required this.day, @required this.professional});

  @override
  Stream<AddAutomaticScheduleState> mapEventToState(
    AddAutomaticScheduleEvent event,
  ) async* {
    if (event is GetAutomaticScheduleOfSelectedDayEvent) {
      yield AddAutomaticScheduleLoadingState();
      Schedule schedule =
          await getProfessionalSchedule(day, professional.getProfessionalID());
      if (schedule == null) {
        yield NoScheduleAvailableState();
      } else {
        yield GetAutomaticScheduleOfSelectedDayState(schedule: schedule);
      }
    } else if (event is UpdateAutomaticScheduleEvent) {
      yield AddAutomaticScheduleLoadingState();
      bool check = await ScheduleRepository.defaultConstructor().updateSchedule(
          event.schedule, professional.getProfessionalID(), day);
      if (check) {
        Schedule schedule = await getProfessionalSchedule(
            day, professional.getProfessionalID());
        yield ScheduleUpdatedSuccessfullyState();
        yield GetAutomaticScheduleOfSelectedDayState(schedule: schedule);
      }
    }
  }

  @override
  AddAutomaticScheduleState get initialState => AddAutomaticScheduleInitial();

  Future<Schedule> getProfessionalSchedule(
      String day, String professionalID) async {
    Schedule schedule = await ScheduleRepository.defaultConstructor()
        .getProfessionalSchedule(professionalID, day);
    return schedule;
  }
}
