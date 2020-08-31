import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_date_time_event.dart';

part 'select_date_time_state.dart';

class SelectDateTimeBloc
    extends Bloc<SelectDateTimeEvent, SelectDateTimeState> {
  final Professional professional;

  SelectDateTimeBloc({@required this.professional});

  @override
  SelectDateTimeState get initialState =>
      SelectDateTimeInitial(professional: professional);

  @override
  Stream<SelectDateTimeState> mapEventToState(
    SelectDateTimeEvent event,
  ) async* {
    if (event is ShowAvailableTimeEvent) {
      Schedule schedule =
          await getProfessionalSchedule(event.professional, event.dateTime);

      if(schedule == null){
        yield NoScheduleAvailable(professional:event.professional);
      }else{
        DateTime dateTime = event.dateTime;
        if (dateTime == null) {
          dateTime = DateTime.now();
        }
        List<DateTime> timeSlots = makeScheduleTimeSlots(
            schedule, dateTime.year, dateTime.month, dateTime.day);
        yield ShowAvailableTimeState(
            professional: event.professional,
            schedule: schedule,
            timeSlots: timeSlots);
      }

    }else if(event is TimeSlotSelectedEvent){
      yield TimeSlotSelectedState(professional: event.professional,schedule: event.schedule,timeSlots: event.schedules,selectedIndex: event.scheduleIndex);
    }
  }

  Future<Schedule> getProfessionalSchedule(
      Professional professional, DateTime dateTime) async {
    print("in get schedule");
    String convertedDay;
    if (dateTime == null) {
      dateTime = DateTime.now();
    }
    print(dateTime.toString());
    convertedDay = getDay(dateTime);

    print("in get professional schedule");
    Schedule schedule = await ScheduleRepository.defaultConstructor()
        .getProfessionalSchedule(
            professional.getProfessionalID(), convertedDay);
    return schedule;
  }

  String getDay(DateTime dateTime) {
    String convertedDay;
    int day = dateTime.weekday;
    print("in get day function");
    print(day);
    if (day == DateTime.monday) {
      convertedDay = 'Monday';
    } else if (day == DateTime.tuesday) {
      convertedDay = 'Tuesday';
    } else if (day == DateTime.wednesday) {
      convertedDay = 'Wednesday';
    } else if (day == DateTime.thursday) {
      convertedDay = 'Thursday';
    } else if (day == DateTime.friday) {
      convertedDay = 'Friday';
    } else if (day == DateTime.saturday) {
      convertedDay = 'Saturday';
    } else {
      convertedDay = 'Sunday';
    }
    return convertedDay;
  }

  List<DateTime> makeScheduleTimeSlots(
      Schedule schedule, int year, int month, int day) {
    List<DateTime> schedules = new List();
    DateTime startTime = DateTime(year, month, day, schedule.getStartTime(),
        schedule.getStartTimeMinutes());
    DateTime endTime = DateTime(
        year, month, day, schedule.getEndTime(), schedule.getEndTimeMinutes());
    DateTime breakStartTime = DateTime(year, month, day,
        schedule.getBreakStartTime(), schedule.getBreakStartTimeMinutes());
    DateTime breakEndTime = DateTime(year, month, day,
        schedule.getBreakEndTime(), schedule.getBreakEndTimeMinutes());
    int multiplier = 1;
    schedules.add(startTime);
    if (schedule.getBreakEndTime() == -1 &&
        schedule.getBreakEndTimeMinutes() == -1 &&
        schedule.getBreakStartTime() == -1 &&
        schedule.getBreakStartTimeMinutes() == -1) {
      while (true) {
        DateTime tempDate =
        startTime.add(Duration(minutes: schedule.getDuration() * multiplier));
        if (tempDate.hour >= endTime.hour &&
            tempDate.minute >= endTime.minute) {
          break;
        }
        schedules.add(tempDate);
        multiplier++;
      }
    }else{
      while (true) {
        DateTime tempDate =
        startTime.add(Duration(minutes: schedule.getDuration() * multiplier));
        if (tempDate.hour >= breakStartTime.hour &&
            tempDate.minute >= breakStartTime.minute) {
          break;
        }
        schedules.add(tempDate);
        multiplier++;
      }
      multiplier = 1;
      schedules.add(breakEndTime);

      while (true) {
        DateTime tempDate = breakEndTime
            .add(Duration(minutes: schedule.getDuration() * multiplier));
        if (tempDate.hour >= endTime.hour && tempDate.minute >= endTime.minute) {
          break;
        }
        schedules.add(tempDate);
        multiplier++;
      }
    }


    print(schedules);
    return schedules;
  }
}
