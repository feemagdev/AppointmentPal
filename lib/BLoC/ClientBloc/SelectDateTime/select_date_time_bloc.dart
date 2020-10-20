import 'dart:async';

import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'select_date_time_event.dart';

part 'select_date_time_state.dart';

class SelectDateTimeBloc
    extends Bloc<SelectDateTimeEvent, SelectDateTimeState> {
  final Professional professional;
  final Appointment appointment;

  SelectDateTimeBloc({@required this.professional, this.appointment});

  @override
  SelectDateTimeState get initialState =>
      SelectDateTimeInitial(professional: professional,appointment: appointment);

  @override
  Stream<SelectDateTimeState> mapEventToState(
    SelectDateTimeEvent event,
  ) async* {
    if (event is ShowAvailableTimeEvent) {
      Schedule schedule =
          await getProfessionalSchedule(event.professional, event.dateTime);

      if (schedule == null) {
        yield NoScheduleAvailable(
            professional: event.professional, dateTime: event.dateTime);
      } else {
        DateTime dateTime = event.dateTime;
        if (dateTime == null) {
          dateTime = DateTime.now();
        }

        print("check of appointment date");
        List<Appointment> appointment =
            await AppointmentRepository.defaultConstructor()
                .getNotAvailableTime(Timestamp.fromDate(dateTime),
                    event.professional.getProfessionalID());

        List<DateTime> timeSlots = makeScheduleTimeSlots(
            schedule, dateTime.year, dateTime.month, dateTime.day, appointment);
        print("time slot lenght");
        print(timeSlots.length);
        if (timeSlots.isEmpty || timeSlots.length == 0) {
          yield NoScheduleAvailable(
              professional: event.professional, dateTime: event.dateTime);
        } else {
          yield ShowAvailableTimeState(
              professional: event.professional,
              schedule: schedule,
              timeSlots: timeSlots);
        }
      }
    } else if (event is TimeSlotSelectedEvent) {
      yield TimeSlotSelectedState(
          professional: event.professional,
          schedule: event.schedule,
          timeSlots: event.schedules,
          selectedIndex: event.scheduleIndex);
    } else if (event is AppointmentIsBookedEvent) {
      DocumentReference clientID = ClientRepository.defaultConstructor()
          .getClientReference(event.user.uid);

      Timestamp dateTime = Timestamp.fromDate(event.dateTime);
      String appointmentStatus = "booked";
      String name = event.name;
      String phone = event.phone;

      AppointmentRepository.defaultConstructor().makeAppointment(
          event.professional.getProfessionalID(),
          event.service.getServiceID(),
          event.subServices.getServiceID(),
          clientID,
          dateTime,
          appointmentStatus,
          name,
          phone,
          event.professional.getName(),
          event.professional.getPhone(),
          event.service.getName(),
          event.subServices.getName());

      yield AppointmentIsBookedState();
    } else if (event is ProfessionalUpdateAppointmentButtonEvent) {
      Appointment appointment = event.appointment;

      AppointmentRepository.defaultConstructor().updateAppointment(
          appointment,
          event.clientName,
          event.clientPhone,
          Timestamp.fromDate(event.dateTime));
      yield ProfessionalUpdateAppointmentState(
          professional: event.professional);
    } else if (event is MoveToSelectCustomerScreenEvent) {
      yield MoveToSelectCustomerScreenState(
          professional: event.professional,
          selectedDateTime: event.selectedDateTime,
          schedule: event.schedule);
    }else if (event is MoveToDashboardScreenEvent){
      yield MoveToDashboardScreenState(professional: event.professional);
    }
  }

  Future<Schedule> getProfessionalSchedule(
      Professional professional, DateTime dateTime) async {
    String convertedDay;
    if (dateTime == null) {
      dateTime = DateTime.now();
    }
    convertedDay = getDay(dateTime);
    Schedule schedule = await ScheduleRepository.defaultConstructor()
        .getProfessionalSchedule(
            professional.getProfessionalID(), convertedDay);
    return schedule;
  }

  String getDay(DateTime dateTime) {
    String convertedDay;
    int day = dateTime.weekday;
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
            appointment[i].getAppointmentDateTime()) {
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

        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {
            print('in date checking loop');
            if (Timestamp.fromDate(tempDate) ==
                appointment[i].getAppointmentDateTime()) {
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
                appointment[i].getAppointmentDateTime()) {
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
              appointment[i].getAppointmentDateTime()) {
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
                appointment[i].getAppointmentDateTime()) {
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
