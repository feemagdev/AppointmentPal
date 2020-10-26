import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/client_repository.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'select_date_time_event.dart';

part 'select_date_time_state.dart';

class SelectDateTimeBloc
    extends Bloc<SelectDateTimeEvent, SelectDateTimeState> {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;

  SelectDateTimeBloc(
      {@required this.professional, this.appointment, this.customer});

  @override
  SelectDateTimeState get initialState => SelectDateTimeInitial(
      professional: professional, appointment: appointment, customer: customer);

  @override
  Stream<SelectDateTimeState> mapEventToState(
    SelectDateTimeEvent event,
  ) async* {
    if (event is ShowAvailableTimeEvent) {
      yield SelectDateTimeLoadingState();
      Schedule schedule =
          await getProfessionalSchedule(event.professional, event.dateTime);

      if (schedule == null) {
        yield NoScheduleAvailable(
            professional: event.professional,
            dateTime: event.dateTime,
            customer: event.customer,
            appointment: event.appointment);
      } else {
        DateTime dateTime = event.dateTime;
        if (dateTime == null) {
          dateTime = DateTime.now();
        }

        List<Appointment> appointment =
            await AppointmentRepository.defaultConstructor()
                .getNotAvailableTime(Timestamp.fromDate(dateTime),
                    event.professional.getProfessionalID());

        List<DateTime> timeSlots = makeScheduleTimeSlots(
            schedule, dateTime.year, dateTime.month, dateTime.day, appointment);
        if (timeSlots.isEmpty || timeSlots.length == 0) {
          yield NoScheduleAvailable(
              professional: event.professional,
              dateTime: event.dateTime,
              customer: event.customer,
              appointment: event.appointment);
        } else {
          yield ShowAvailableTimeState(
              professional: event.professional,
              schedule: schedule,
              timeSlots: timeSlots,
              customer: event.customer,
              appointment: event.appointment);
        }
      }
    } else if (event is TimeSlotSelectedEvent) {
      yield TimeSlotSelectedState(
          professional: event.professional,
          schedule: event.schedule,
          timeSlots: event.schedules,
          selectedIndex: event.scheduleIndex,
          appointment: event.appointment,customer: event.customer);
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
    } else if (event is TimeSlotIsSelectedEvent) {
      if (event.appointment == null) {
        yield MoveToSelectCustomerScreenState(
          professional: event.professional,
          appointmentStartTime: event.appointmentStartTime,
          appointmentEndTime: event.appointmentEndTime,
        );
      } else {
        appointment.setAppointmentStartTime(
            Timestamp.fromDate(event.appointmentStartTime));
        appointment.setAppointmentEndTime(
            Timestamp.fromDate(event.appointmentEndTime));
        yield MoveToUpdateAppointmentScreenState(
            professional: event.professional,
            appointment: event.appointment,
            customer: event.customer);
      }
    } else if (event is MoveToDashboardScreenEvent) {
      yield MoveToDashboardScreenState(professional: event.professional);
    } else if (event is MoveToUpdateAppointmentScreenEvent) {
      yield MoveToUpdateAppointmentScreenState(
          professional: event.professional,
          appointment: event.appointment,
          customer: event.customer);
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
    bool checkInitialDate = true;

    if (appointment == null) {
      checkInitialDate = true;
    } else {
      for (int i = 0; i < appointment.length; i++) {
        int startTimeInMinutes = startTime.hour*60+startTime.minute;
        int appointmentStartTime = appointment[i].getAppointmentStartTime().toDate().hour*60+appointment[i].getAppointmentStartTime().toDate().minute;
        int appointmentEndTime = appointment[i].getAppointmentEndTime().toDate().hour*60+appointment[i].getAppointmentEndTime().toDate().minute;
        if(startTimeInMinutes >= appointmentStartTime && startTimeInMinutes <= appointmentEndTime){
          checkInitialDate = false;
          break;
        }else if(startTime.hour == appointment[i].getAppointmentStartTime().toDate().hour){
          if((startTimeInMinutes + schedule.getDuration()) <= appointmentEndTime){
            checkInitialDate = false;
            break;
          }
        }
      /*  if (Timestamp.fromDate(startTime) ==
            appointment[i].getAppointmentStartTime()) {
          checkInitialDate = false;
          break;
        }*/
      }
    }
    int startTimeInMinutes = startTime.hour * 60 + startTime.minute;
    int currentTimeInMinutes = DateTime.now().hour * 60 + DateTime.now().minute;

    if(startTime.day == DateTime.now().day){
      if (startTimeInMinutes > currentTimeInMinutes) {
        if (checkInitialDate) {
          schedules.add(startTime);
        }
      }
    } else{
      if(checkInitialDate){
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
        int startTimeInMinutes = tempDate.hour*60 + tempDate.minute;

        if (tempDate.hour >= endTime.hour &&
            tempDate.minute >= endTime.minute) {
          break;
        }

        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {

            int appointmentStartTime = appointment[i].getAppointmentStartTime().toDate().hour*60+appointment[i].getAppointmentStartTime().toDate().minute;
            int appointmentEndTime = appointment[i].getAppointmentEndTime().toDate().hour*60+appointment[i].getAppointmentEndTime().toDate().minute;
            if(startTimeInMinutes >= appointmentStartTime && startTimeInMinutes < appointmentEndTime){
              checkDate = true;
              break;
            }else if(tempDate.hour == appointment[i].getAppointmentStartTime().toDate().hour){
              if((startTimeInMinutes + schedule.getDuration()) <= appointmentEndTime){
                checkDate = true;
                break;
              }
            }
            /*if (Timestamp.fromDate(tempDate) ==
                appointment[i].getAppointmentStartTime()) {
              checkDate = true;
              continue;
            }*/
          }
        }

        if (checkDate == true) {
          multiplier++;
          continue;
        }
        if (tempDate.day == DateTime.now().day) {
          int tempTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
          int currentTimeInMinutes =
              DateTime.now().hour * 60 + DateTime.now().minute;

          if (tempTimeInMinutes < currentTimeInMinutes) {
            multiplier++;
            continue;
          } else {
            multiplier++;
            schedules.add(tempDate);
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
        int startTimeInMinutes = tempDate.hour*60 + tempDate.minute;
        int breakStartTimeInMinutes = breakStartTime.hour * 60 + breakStartTime.minute;

        if(startTimeInMinutes >= breakStartTimeInMinutes){
          break;
        }

        /*if (tempDate.hour >= breakStartTime.hour &&
            tempDate.minute >= breakStartTime.minute) {
          break;
        }*/


        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {
            int appointmentStartTime = appointment[i].getAppointmentStartTime().toDate().hour*60+appointment[i].getAppointmentStartTime().toDate().minute;
            int appointmentEndTime = appointment[i].getAppointmentEndTime().toDate().hour*60+appointment[i].getAppointmentEndTime().toDate().minute;
            if(startTimeInMinutes >= appointmentStartTime && startTimeInMinutes < appointmentEndTime){
              checkDate = true;
              break;
            }else if(tempDate.hour == appointment[i].getAppointmentStartTime().toDate().hour) {
              if ((startTimeInMinutes + schedule.getDuration()) <=
                  appointmentEndTime) {
                checkDate = true;
                break;
              }
            }
            /* if (Timestamp.fromDate(tempDate) ==
                appointment[i].getAppointmentStartTime()) {
              checkDate = true;
              continue;
            }*/
          }
        }
        if (checkDate == true) {
          multiplier++;
          continue;
        }
        if (tempDate.day == DateTime.now().day) {
          int tempTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
          int currentTimeInMinutes =
              DateTime.now().hour * 60 + DateTime.now().minute;

          if (tempTimeInMinutes < currentTimeInMinutes) {
            multiplier++;
            continue;
          } else {
            multiplier++;
            schedules.add(tempDate);
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
        int breakEndTimeInMinutes  = breakEndTime.hour*60 + breakEndTime.minute;

        for (int i = 0; i < appointment.length; i++) {
          int appointmentStartTime = appointment[i].getAppointmentStartTime().toDate().hour*60+appointment[i].getAppointmentStartTime().toDate().minute;
          int appointmentEndTime = appointment[i].getAppointmentEndTime().toDate().hour*60+appointment[i].getAppointmentEndTime().toDate().minute;

          if(breakEndTimeInMinutes >= appointmentStartTime && breakEndTimeInMinutes < appointmentEndTime){
            checkBreakEndTime = false;
            break;
          }else if(breakEndTime.hour == appointment[i].getAppointmentStartTime().toDate().hour){
            if((startTimeInMinutes + schedule.getDuration()) <= appointmentEndTime){
              checkBreakEndTime = false;
              break;
            }
          }
         /* if (Timestamp.fromDate(breakEndTime) ==
              appointment[i].getAppointmentStartTime()) {
            checkBreakEndTime = false;
            break;
          }*/
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
        int breakEndTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
        int endTimeInMinutes = endTime.hour * 60 + endTime.minute;

        if(breakEndTimeInMinutes >= endTimeInMinutes ){
          break;
        }

        /*if (tempDate.hour >= endTime.hour &&
            tempDate.minute >= endTime.minute) {
          break;
        }*/
        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {
            int appointmentStartTime = appointment[i].getAppointmentStartTime().toDate().hour*60+appointment[i].getAppointmentStartTime().toDate().minute;
            int appointmentEndTime = appointment[i].getAppointmentEndTime().toDate().hour*60+appointment[i].getAppointmentEndTime().toDate().minute;

            if(breakEndTimeInMinutes >= appointmentStartTime && breakEndTimeInMinutes < appointmentEndTime){
              checkDate = true;
              break;
            }else if(tempDate.hour == appointment[i].getAppointmentStartTime().toDate().hour){
              if((startTimeInMinutes + schedule.getDuration()) <= appointmentEndTime){
                checkDate = true;
                break;
              }
            }

            /*if (Timestamp.fromDate(tempDate) ==
                appointment[i].getAppointmentStartTime()) {
              checkDate = true;
              continue;
            }*/
          }
        }
        if (checkDate == true) {
          multiplier++;
          continue;
        }
        if (tempDate.day == DateTime.now().day) {
          int tempTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
          int currentTimeInMinutes =
              DateTime.now().hour * 60 + DateTime.now().minute;

          if (tempTimeInMinutes < currentTimeInMinutes) {
            multiplier++;
            continue;
          } else {
            multiplier++;
            schedules.add(tempDate);
          }
        } else {
          multiplier++;
          schedules.add(tempDate);
        }
      }
    }
    return schedules;
  }
}
