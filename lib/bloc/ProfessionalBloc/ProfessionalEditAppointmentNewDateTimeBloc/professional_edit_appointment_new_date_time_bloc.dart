import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'professional_edit_appointment_new_date_time_event.dart';
part 'professional_edit_appointment_new_date_time_state.dart';

class ProfessionalEditAppointmentNewDateTimeBloc extends Bloc<ProfessionalEditAppointmentNewDateTimeEvent, ProfessionalEditAppointmentNewDateTimeState> {
  final Appointment appointment;
  ProfessionalEditAppointmentNewDateTimeBloc({@required this.appointment});

  @override
  Stream<ProfessionalEditAppointmentNewDateTimeState> mapEventToState(
    ProfessionalEditAppointmentNewDateTimeEvent event,
  ) async* {

    if(event is EditAppointmentShowSelectedDayTimeEvent){

      Schedule schedule =
      await getProfessionalSchedule(event.appointment.getProfessionalID(), event.dateTime);

      if(schedule == null){
        yield EditAppointmentNewDateTimeNoAvailableTimeState(appointment: event.appointment,dateTime:event.dateTime);
      }
      else{
        DateTime dateTime = event.dateTime;
        if(dateTime == null){
          dateTime = DateTime.now();
        }
        List<Appointment> appointment =
        await AppointmentRepository.defaultConstructor()
            .getNotAvailableTime(
            Timestamp.fromDate(dateTime), event.appointment.getProfessionalID());

        List<DateTime> timeSlots = makeScheduleTimeSlots(
            schedule, dateTime.year, dateTime.month, dateTime.day, appointment);
        yield EditAppointmentShowSelectedDayAvailableTimeState(
            appointment: event.appointment,
            timeSlots: timeSlots,
        schedule: schedule);


      }











    }

  }

  @override
  ProfessionalEditAppointmentNewDateTimeState get initialState => EditAppointmentNewDateTimeInitial(appointment: appointment);


  Future<Schedule> getProfessionalSchedule(
      DocumentReference professional, DateTime dateTime) async {
    String convertedDay;
    if (dateTime == null) {
      dateTime = DateTime.now();
    }

    convertedDay = getDay(dateTime);
    Schedule schedule = await ScheduleRepository.defaultConstructor()
        .getProfessionalSchedule(professional,convertedDay);
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
 List<DateTime> makeScheduleTimeSlots(Schedule schedule, int year, int month,
      int day, List<Appointment> appointment) {
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
    bool checkInitialDate = false;

    if (appointment == null) {
      checkInitialDate = true;
    } else {
      for (int i = 0; i < appointment.length; i++) {
        print('in initial date checking loop');
        if (Timestamp.fromDate(startTime) ==
            appointment[i].getAppointmentStartTime()) {
          print('initial date if true');
          checkInitialDate = false;
          break;
        }
      }
    }
    int startTimeInMinutes = startTime.hour * 60 + startTime.minute;
    int currentTimeInMinutes = DateTime.now().hour * 60 + DateTime.now().minute;

    if (startTimeInMinutes > currentTimeInMinutes) {
      if (checkInitialDate) {
        schedules.add(startTime);
      }
    }

    if (schedule.getBreakEndTime() == -1 &&
        schedule.getBreakEndTimeMinutes() == -1 &&
        schedule.getBreakStartTime() == -1 &&
        schedule.getBreakStartTimeMinutes() == -1) {
      while (true) {
        bool checkDate = false;
        DateTime tempDate = startTime
            .add(Duration(minutes: schedule.getDuration() * multiplier));

        if (tempDate.hour >= endTime.hour &&
            tempDate.minute >= endTime.minute) {
          break;
        }

        if (checkDate == true) {
          multiplier++;
          continue;
        }
        if (tempDate.day == DateTime.now().day) {
          if (tempDate.hour <= DateTime.now().hour) {
            multiplier++;
            continue;
          } else {
            if (tempDate.minute < DateTime.now().minute) {
              multiplier++;
              continue;
            } else {
              multiplier++;
              schedules.add(tempDate);
            }
          }
        } else {
          multiplier++;
          schedules.add(tempDate);
        }
      }
    } else {
      while (true) {
        bool checkDate = false;
        DateTime tempDate = startTime
            .add(Duration(minutes: schedule.getDuration() * multiplier));
        if (tempDate.hour >= breakStartTime.hour &&
            tempDate.minute >= breakStartTime.minute) {
          break;
        }
        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {
            print('in date checking loop');
            if (Timestamp.fromDate(tempDate) ==
                appointment[i].getAppointmentStartTime()) {
              print('date if true');
              checkDate = true;
              continue;
            }
          }
        }
        if (checkDate == true) {
          multiplier++;
          continue;
        }
        if (tempDate.day == DateTime.now().day) {
          print("current day run");
          int tempTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
          int currentTimeInMinutes =
              DateTime.now().hour * 60 + DateTime.now().minute;

          if (tempTimeInMinutes < currentTimeInMinutes) {
            multiplier++;
            continue;
          } else {
            multiplier++;
            schedules.add(tempDate);
            print("schedule added");
          }
        } else {
          multiplier++;
          schedules.add(tempDate);
        }
      }
      multiplier = 1;
      bool checkBreakEndTime = false;

      if (appointment == null) {
        checkBreakEndTime = true;
      } else {
        for (int i = 0; i < appointment.length; i++) {
          print('in after break date checking loop');
          if (Timestamp.fromDate(breakEndTime) ==
              appointment[i].getAppointmentStartTime()) {
            print('initial date if true');
            checkBreakEndTime = false;
            break;
          }
        }
      }

      if (checkBreakEndTime) {
        int endTimeInMinutes = breakEndTime.hour * 60 + breakEndTime.minute;
        int currentTimeInMinutes =
            DateTime.now().hour * 60 + DateTime.now().minute;
        if (endTimeInMinutes > currentTimeInMinutes) {
          schedules.add(breakEndTime);
        }
      }

      while (true) {
        bool checkDate = false;
        DateTime tempDate = breakEndTime
            .add(Duration(minutes: schedule.getDuration() * multiplier));
        if (tempDate.hour >= endTime.hour &&
            tempDate.minute >= endTime.minute) {
          break;
        }
        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {
            print('in date checking loop');
            if (Timestamp.fromDate(tempDate) ==
                appointment[i].getAppointmentStartTime()) {
              print('date if true');
              checkDate = true;
              continue;
            }
          }
        }
        if (checkDate == true) {
          multiplier++;
          continue;
        }
        if (tempDate.day == DateTime.now().day) {
          print("current day run");
          int tempTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
          int currentTimeInMinutes =
              DateTime.now().hour * 60 + DateTime.now().minute;

          if (tempTimeInMinutes < currentTimeInMinutes) {
            multiplier++;
            continue;
          } else {
            multiplier++;
            schedules.add(tempDate);
            print("schedule added");
          }
        } else {
          multiplier++;
          schedules.add(tempDate);
        }
      }
    }

    print(schedules);
    return schedules;
  }




}
