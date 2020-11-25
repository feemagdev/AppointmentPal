import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/custom_time_slots.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/model/week_days_availability.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/custom_time_slots_repository.dart';
import 'package:appointmentproject/repository/schedule_repository.dart';
import 'package:appointmentproject/repository/week_days_availability_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'select_date_time_event.dart';
part 'select_date_time_state.dart';

class SelectDateTimeBloc
    extends Bloc<SelectDateTimeEvent, SelectDateTimeState> {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  final Manager manager;

  SelectDateTimeBloc(
      {@required this.professional,
      this.appointment,
      this.customer,
      this.manager});

  @override
  SelectDateTimeState get initialState => SelectDateTimeInitial();

  @override
  Stream<SelectDateTimeState> mapEventToState(
    SelectDateTimeEvent event,
  ) async* {
    if (event is ShowAvailableTimeEvent) {
      yield SelectDateTimeLoadingState();
      DateTime dateTime = event.dateTime;
      if (dateTime == null) {
        dateTime = DateTime.now();
      }
      WeekDaysAvailability weekDaysAvailability =
          await WeekDaysAvailabilityRepository.defaultConstructor()
              .getListOfAvailableWeekDays(professional.getProfessionalID());

      print(
          "print week days ${weekDaysAvailability.getWednesdayAvailability()}");
      bool dayCheck = getWeekdayAvailability(dateTime, weekDaysAvailability);
      if (dayCheck) {
        List<CustomTimeSlots> customTimeSlots = List();
        customTimeSlots = await CustomTimeSlotRepository.defaultConstructor()
            .getListOfCustomTimeSlotsOfSpecificDay(
                getDay(dateTime), professional.getProfessionalID());

        if (customTimeSlots.isEmpty) {
          yield NoScheduleAvailable(dateTime: dateTime);
        } else {
          List<Appointment> appointment = List();
          appointment = await AppointmentRepository.defaultConstructor()
              .getNotAvailableTime(Timestamp.fromDate(dateTime),
                  professional.getProfessionalID());

          if (appointment.isEmpty) {
            List<CustomTimeSlots> timeSlots =
                makeCustomScheduleTimeSlotsWithoutAppointments(
                    dateTime, customTimeSlots);
            if (timeSlots.isEmpty) {
              yield NoScheduleAvailable(dateTime: dateTime);
            } else {
              yield ShowCustomTimeSlotsState(
                  customTimeSlots: timeSlots, selectedDateTime: dateTime);
            }
          } else {
            List<CustomTimeSlots> timeSlots = makeCustomScheduleTimeSlots(
                appointment, customTimeSlots, dateTime);
            if (timeSlots.isEmpty || timeSlots.length == 0) {
              yield NoScheduleAvailable(dateTime: dateTime);
            } else {
              yield ShowCustomTimeSlotsState(
                  customTimeSlots: timeSlots, selectedDateTime: dateTime);
            }
          }
        }
      } else {
        Schedule schedule =
            await getProfessionalSchedule(professional, event.dateTime);

        if (schedule == null) {
          yield NoScheduleAvailable(dateTime: event.dateTime);
        } else {
          DateTime dateTime = event.dateTime;
          if (dateTime == null) {
            dateTime = DateTime.now();
          }

          List<Appointment> appointment =
              await AppointmentRepository.defaultConstructor()
                  .getNotAvailableTime(Timestamp.fromDate(dateTime),
                      professional.getProfessionalID());

          List<DateTime> timeSlots = makeScheduleTimeSlots(schedule,
              dateTime.year, dateTime.month, dateTime.day, appointment);
          if (timeSlots.isEmpty || timeSlots.length == 0) {
            yield NoScheduleAvailable(dateTime: event.dateTime);
          } else {
            yield ShowAvailableTimeState(
              schedule: schedule,
              timeSlots: timeSlots,
            );
          }
        }
      }
    } else if (event is TimeSlotSelectedEvent) {
      yield TimeSlotSelectedState(
        schedule: event.schedule,
        timeSlots: event.schedules,
        selectedIndex: event.scheduleIndex,
      );
    } else if (event is TimeSlotIsSelectedEvent) {
      if (appointment == null) {
        yield MoveToSelectCustomerScreenState(
          appointmentStartTime: event.appointmentStartTime,
          appointmentEndTime: event.appointmentEndTime,
        );
      } else {
        appointment.setAppointmentStartTime(
            Timestamp.fromDate(event.appointmentStartTime));
        appointment.setAppointmentEndTime(
            Timestamp.fromDate(event.appointmentEndTime));
        yield MoveToUpdateAppointmentScreenState(appointment: appointment);
      }
    } else if (event is CustomTimeSlotSelectedEvent) {
      yield CustomTimeSlotSelectedState(
          customTimeSlots: event.customTimeSlots,
          selectedIndex: event.selectedIndex,
          selectedDateTime: event.selectedDateTime);
    } else if (event is CustomTimeSlotIsSelectedEvent) {
      DateTime appointmentStartTime = DateTime(
          event.dateTime.year,
          event.dateTime.month,
          event.dateTime.day,
          event.customTimeSlots.getFromTime().hour,
          event.customTimeSlots.getFromTime().minute);
      DateTime appointmentToTime = DateTime(
          event.dateTime.year,
          event.dateTime.month,
          event.dateTime.day,
          event.customTimeSlots.getToTime().hour,
          event.customTimeSlots.getToTime().minute);
      if (appointment == null) {
        yield MoveToSelectCustomerScreenState(
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentToTime,
        );
      } else {
        appointment
            .setAppointmentStartTime(Timestamp.fromDate(appointmentStartTime));
        appointment
            .setAppointmentEndTime(Timestamp.fromDate(appointmentToTime));
        yield MoveToUpdateAppointmentScreenState(appointment: appointment);
      }
    } else if (event is MoveToDashboardScreenEvent) {
      yield MoveToDashboardScreenState();
    } else if (event is MoveToUpdateAppointmentScreenEvent) {
      yield MoveToUpdateAppointmentScreenState(appointment: event.appointment);
    }
  }

  bool getWeekdayAvailability(
      DateTime dateTime, WeekDaysAvailability weekDaysAvailability) {
    if (getDay(dateTime) == 'Monday') {
      return weekDaysAvailability.getMondayAvailability();
    } else if (getDay(dateTime) == 'Tuesday') {
      return weekDaysAvailability.getTuesdayAvailability();
    } else if (getDay(dateTime) == 'Wednesday') {
      return weekDaysAvailability.getWednesdayAvailability();
    } else if (getDay(dateTime) == 'Thursday') {
      return weekDaysAvailability.getThursdayAvailability();
    } else if (getDay(dateTime) == 'Friday') {
      return weekDaysAvailability.getFridayAvailability();
    } else if (getDay(dateTime) == 'Saturday') {
      return weekDaysAvailability.getSaturdayAvailability();
    } else {
      return weekDaysAvailability.getSundayAvailability();
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

    int endTimeInMinutes = endTime.hour * 60 + endTime.minute;

    if (appointment == null) {
      checkInitialDate = true;
    } else {
      for (int i = 0; i < appointment.length; i++) {
        int startTimeInMinutes = startTime.hour * 60 + startTime.minute;
        int endTimeInMinutes =
            startTime.hour * 60 + startTime.minute + schedule.getDuration();
        int appointmentStartTime =
            appointment[i].getAppointmentStartTime().toDate().hour * 60 +
                appointment[i].getAppointmentStartTime().toDate().minute;
        int appointmentEndTime =
            appointment[i].getAppointmentEndTime().toDate().hour * 60 +
                appointment[i].getAppointmentEndTime().toDate().minute;
        if (startTimeInMinutes >= appointmentStartTime &&
            startTimeInMinutes <= appointmentEndTime) {
          checkInitialDate = false;
          break;
        } else if (appointmentStartTime < endTimeInMinutes &&
            appointmentEndTime > endTimeInMinutes) {
          checkInitialDate = false;
        } else if (startTime.hour ==
            appointment[i].getAppointmentStartTime().toDate().hour) {
          if ((startTimeInMinutes + schedule.getDuration()) <=
              appointmentEndTime) {
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

    if (startTime.day == DateTime.now().day) {
      if (startTimeInMinutes > currentTimeInMinutes) {
        if (checkInitialDate) {
          schedules.add(startTime);
        }
      }
    } else {
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
        int startTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
        int scheduleEndTimeInMinutes =
            startTimeInMinutes + schedule.getDuration();
        if (startTimeInMinutes + schedule.getDuration() > endTimeInMinutes) {
          break;
        }

        if (appointment == null) {
          checkDate = false;
        } else {
          for (int i = 0; i < appointment.length; i++) {
            int appointmentStartTime =
                appointment[i].getAppointmentStartTime().toDate().hour * 60 +
                    appointment[i].getAppointmentStartTime().toDate().minute;
            int appointmentEndTime =
                appointment[i].getAppointmentEndTime().toDate().hour * 60 +
                    appointment[i].getAppointmentEndTime().toDate().minute;
            if (startTimeInMinutes >= appointmentStartTime &&
                startTimeInMinutes < appointmentEndTime) {
              checkDate = true;
              break;
            } else if (appointmentStartTime < scheduleEndTimeInMinutes &&
                appointmentEndTime > scheduleEndTimeInMinutes) {
              print("new condition is true");
              checkDate = true;
              break;
            } else if (tempDate.hour ==
                appointment[i].getAppointmentStartTime().toDate().hour) {
              if ((startTimeInMinutes + schedule.getDuration()) <=
                  appointmentEndTime) {
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
      print("else is run");
      while (true) {
        bool checkDate = false;
        DateTime tempDate = startTime
            .add(Duration(minutes: schedule.getDuration() * multiplier));
        int startTimeInMinutes = tempDate.hour * 60 + tempDate.minute;
        int breakStartTimeInMinutes =
            breakStartTime.hour * 60 + breakStartTime.minute;
        int scheduleEndTimeInMinutes =
            startTimeInMinutes + schedule.getDuration();

        if (startTimeInMinutes >= breakStartTimeInMinutes) {
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
            int appointmentStartTime =
                appointment[i].getAppointmentStartTime().toDate().hour * 60 +
                    appointment[i].getAppointmentStartTime().toDate().minute;
            int appointmentEndTime =
                appointment[i].getAppointmentEndTime().toDate().hour * 60 +
                    appointment[i].getAppointmentEndTime().toDate().minute;

            if (appointmentStartTime == 660 && appointmentEndTime == 690) {
              print("appointment time check");
              print(startTimeInMinutes);
              print(scheduleEndTimeInMinutes);
            }
            if (startTimeInMinutes >= appointmentStartTime &&
                startTimeInMinutes < appointmentEndTime) {
              checkDate = true;
              break;
            } else if (appointmentStartTime < scheduleEndTimeInMinutes &&
                appointmentEndTime > scheduleEndTimeInMinutes) {
              print("new condition is true");
              checkDate = true;
              break;
            } else if (tempDate.hour ==
                appointment[i].getAppointmentStartTime().toDate().hour) {
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
        int breakEndTimeInMinutes =
            breakEndTime.hour * 60 + breakEndTime.minute;
        int scheduleEndTimeInMinutes =
            breakEndTimeInMinutes + schedule.getDuration();

        for (int i = 0; i < appointment.length; i++) {
          int appointmentStartTime =
              appointment[i].getAppointmentStartTime().toDate().hour * 60 +
                  appointment[i].getAppointmentStartTime().toDate().minute;
          int appointmentEndTime =
              appointment[i].getAppointmentEndTime().toDate().hour * 60 +
                  appointment[i].getAppointmentEndTime().toDate().minute;

          if (breakEndTimeInMinutes >= appointmentStartTime &&
              breakEndTimeInMinutes < appointmentEndTime) {
            checkBreakEndTime = false;
            break;
          } else if (appointmentStartTime < scheduleEndTimeInMinutes &&
              appointmentEndTime > scheduleEndTimeInMinutes) {
            print("new condition is true");
            checkBreakEndTime = false;
            break;
          } else if (breakEndTime.hour ==
              appointment[i].getAppointmentStartTime().toDate().hour) {
            if ((startTimeInMinutes + schedule.getDuration()) <=
                appointmentEndTime) {
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
        int scheduleEndTimeInMinutes =
            breakEndTimeInMinutes + schedule.getDuration();

        if (breakEndTimeInMinutes + schedule.getDuration() >=
            endTimeInMinutes) {
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
            int appointmentStartTime =
                appointment[i].getAppointmentStartTime().toDate().hour * 60 +
                    appointment[i].getAppointmentStartTime().toDate().minute;
            int appointmentEndTime =
                appointment[i].getAppointmentEndTime().toDate().hour * 60 +
                    appointment[i].getAppointmentEndTime().toDate().minute;

            if (breakEndTimeInMinutes >= appointmentStartTime &&
                breakEndTimeInMinutes < appointmentEndTime) {
              checkDate = true;
              break;
            } else if (appointmentStartTime < scheduleEndTimeInMinutes &&
                appointmentEndTime > scheduleEndTimeInMinutes) {
              print("new condition is true");
              checkBreakEndTime = false;
              break;
            } else if (tempDate.hour ==
                appointment[i].getAppointmentStartTime().toDate().hour) {
              if ((startTimeInMinutes + schedule.getDuration()) <=
                  appointmentEndTime) {
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

  List<CustomTimeSlots> makeCustomScheduleTimeSlots(
      List<Appointment> appointments,
      List<CustomTimeSlots> customTimeSlots,
      DateTime dateTime) {
    int customTimeIndex = 0;
    List<CustomTimeSlots> newCustomList = List();
    int todayMinutes = DateTime.now().hour * 60 + DateTime.now().minute;
    while (true) {
      print("customTimeIndex");
      print(customTimeIndex);
      int fromCheckMinutes =
          customTimeSlots[customTimeIndex].getFromTime().hour * 60 +
              customTimeSlots[customTimeIndex].getFromTime().minute;
      int toCheckMinutes =
          customTimeSlots[customTimeIndex].getToTime().hour * 60 +
              customTimeSlots[customTimeIndex].getToTime().minute;

      int appointmentIndex = 0;
      bool check1 = false;

      while (true) {
        int fromTimeMinutes = appointments[appointmentIndex]
                    .getAppointmentStartTime()
                    .toDate()
                    .hour *
                60 +
            appointments[appointmentIndex]
                .getAppointmentStartTime()
                .toDate()
                .minute;

        int toTimeMinutes = appointments[appointmentIndex]
                    .getAppointmentEndTime()
                    .toDate()
                    .hour *
                60 +
            appointments[appointmentIndex]
                .getAppointmentEndTime()
                .toDate()
                .minute;

        if (fromCheckMinutes > fromTimeMinutes &&
            toCheckMinutes < toTimeMinutes) {
          check1 = true;
          break;
        } else if (fromTimeMinutes > fromCheckMinutes &&
            toTimeMinutes < toCheckMinutes) {
          check1 = true;
          break;
        } else if (fromCheckMinutes > fromTimeMinutes &&
            fromCheckMinutes < toTimeMinutes) {
          check1 = true;
          break;
        } else if (fromCheckMinutes < fromTimeMinutes &&
            toCheckMinutes > fromTimeMinutes) {
          check1 = true;
          break;
        } else if (fromCheckMinutes == fromTimeMinutes &&
            toCheckMinutes == toTimeMinutes) {
          check1 = true;
          break;
        } else if (fromTimeMinutes <= fromCheckMinutes &&
            toTimeMinutes > toCheckMinutes) {
          check1 = true;
          break;
        } else if (fromTimeMinutes >= fromCheckMinutes &&
            toTimeMinutes < toCheckMinutes) {
          check1 = true;
          break;
        } else if (fromTimeMinutes > fromCheckMinutes &&
            toTimeMinutes <= toCheckMinutes) {
          check1 = true;
          break;
        }
        appointmentIndex++;
        if (appointmentIndex == appointments.length) {
          break;
        }
      }
      if (dateTime == null || dateTime.day == DateTime.now().day) {
        if (fromCheckMinutes <= todayMinutes) {
          check1 = true;
        }
      }
      if (check1 == false) {
        print("added a time");
        newCustomList.add(customTimeSlots[customTimeIndex]);
      }
      customTimeIndex++;
      if (customTimeIndex >= customTimeSlots.length) {
        break;
      }
    }
    return newCustomList;
  }

  List<CustomTimeSlots> makeCustomScheduleTimeSlotsWithoutAppointments(
      DateTime dateTime, List<CustomTimeSlots> customTimeSlots) {
    List<CustomTimeSlots> customTimeSlots2 = List();
    int index = 0;
    if (dateTime == null || dateTime.day == DateTime.now().day) {
      while (true) {
        if (index == customTimeSlots.length) {
          break;
        }
        int fromMinutes = customTimeSlots[index].getFromTime().hour * 60 +
            customTimeSlots[index].getFromTime().minute;
        int todayMinutes = DateTime.now().hour * 60 + DateTime.now().minute;
        print(fromMinutes);
        print(todayMinutes);
        if (fromMinutes <= todayMinutes) {
          index++;
          continue;
        }
        customTimeSlots2.add(customTimeSlots[index]);
        index++;
      }
      return customTimeSlots2;
    } else {
      return customTimeSlots;
    }
  }
}
