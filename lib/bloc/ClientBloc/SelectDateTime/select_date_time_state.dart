part of 'select_date_time_bloc.dart';

@immutable
abstract class SelectDateTimeState {}

class SelectDateTimeInitial extends SelectDateTimeState {}

class ShowAvailableTimeState extends SelectDateTimeState {
  final Schedule schedule;
  final List<DateTime> timeSlots;

  ShowAvailableTimeState({@required this.schedule, @required this.timeSlots});
}

class NoScheduleAvailable extends SelectDateTimeState {
  final DateTime dateTime;

  NoScheduleAvailable({@required this.dateTime});
}

class TimeSlotSelectedState extends SelectDateTimeState {
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final int selectedIndex;

  TimeSlotSelectedState({this.schedule, this.timeSlots, this.selectedIndex});
}

class AppointmentIsBookedState extends SelectDateTimeState {}

class ProfessionalAppointmentIsBookedState extends SelectDateTimeState {
  final Professional professional;
  ProfessionalAppointmentIsBookedState({@required this.professional});
}

class ProfessionalUpdateAppointmentState extends SelectDateTimeState {
  final Professional professional;
  ProfessionalUpdateAppointmentState({@required this.professional});
}

class MoveToSelectCustomerScreenState extends SelectDateTimeState {
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;

  MoveToSelectCustomerScreenState(
      {@required this.appointmentStartTime, @required this.appointmentEndTime});
}

class MoveToUpdateAppointmentScreenState extends SelectDateTimeState {
  final Appointment appointment;

  MoveToUpdateAppointmentScreenState({@required this.appointment});
}

class ShowCustomTimeSlotsState extends SelectDateTimeState {
  final List<CustomTimeSlots> customTimeSlots;
  final DateTime selectedDateTime;

  ShowCustomTimeSlotsState(
      {@required this.customTimeSlots, @required this.selectedDateTime});
}

class CustomTimeSlotSelectedState extends SelectDateTimeState {
  final List<CustomTimeSlots> customTimeSlots;
  final int selectedIndex;
  final DateTime selectedDateTime;

  CustomTimeSlotSelectedState(
      {@required this.customTimeSlots,
      @required this.selectedIndex,
      @required this.selectedDateTime});
}

class MoveToDashboardScreenState extends SelectDateTimeState {}

class SelectDateTimeLoadingState extends SelectDateTimeState {}
