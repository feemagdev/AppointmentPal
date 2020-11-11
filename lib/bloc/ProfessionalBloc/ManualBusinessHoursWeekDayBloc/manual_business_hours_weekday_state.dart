part of 'manual_business_hours_weekday_bloc.dart';

@immutable
abstract class ManualBusinessHoursWeekdayState {}

class ManualBusinessHoursWeekdayInitial
    extends ManualBusinessHoursWeekdayState {}

class ManualBusinessHoursWeekdaySelectedState
    extends ManualBusinessHoursWeekdayState {
  final String day;

  ManualBusinessHoursWeekdaySelectedState({@required this.day});
}

class GetManualAvailableWeekDaysStatusState
    extends ManualBusinessHoursWeekdayState {
  final WeekDaysAvailability weekDaysAvailability;

  GetManualAvailableWeekDaysStatusState({@required this.weekDaysAvailability});
}

class ManualBusinessHoursWeekdayLoadingState
    extends ManualBusinessHoursWeekdayState {}

class UpdateManualBusinessHoursWeekdaysState
    extends ManualBusinessHoursWeekdayState {
  final WeekDaysAvailability updatedWeekDays;

  UpdateManualBusinessHoursWeekdaysState({@required this.updatedWeekDays});
}
