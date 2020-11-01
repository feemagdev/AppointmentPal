part of 'manual_business_hours_weekday_bloc.dart';

@immutable
abstract class ManualBusinessHoursWeekdayState {}

class ManualBusinessHoursWeekdayInitial extends ManualBusinessHoursWeekdayState {}


class ManualBusinessHoursWeekdaySelectedState extends ManualBusinessHoursWeekdayState{
  final String day;
  ManualBusinessHoursWeekdaySelectedState({@required this.day});
}
