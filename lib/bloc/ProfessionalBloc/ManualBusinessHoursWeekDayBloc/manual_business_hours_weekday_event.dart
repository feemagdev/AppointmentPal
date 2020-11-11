part of 'manual_business_hours_weekday_bloc.dart';

@immutable
abstract class ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForMondayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForTuesdayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForWednesdayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForThursdayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForFridayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForSaturdayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class ManualBusinessHoursForSundayEvent
    extends ManualBusinessHoursWeekdayEvent {}

class GetManualAvailableWeekDaysStatusEvent
    extends ManualBusinessHoursWeekdayEvent {}

class UpdateManualBusinessHoursWeekdaysEvent
    extends ManualBusinessHoursWeekdayEvent {
  final WeekDaysAvailability weekDaysAvailability;

  UpdateManualBusinessHoursWeekdaysEvent({@required this.weekDaysAvailability});
}
