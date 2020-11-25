part of 'automatic_business_hours_bloc.dart';

abstract class AutomaticBusinessHoursState {}

class AutomaticBusinessHoursInitial extends AutomaticBusinessHoursState {}

class AutomaticBusinessHoursWeekdaySelectedState
    extends AutomaticBusinessHoursState {
  final String day;

  AutomaticBusinessHoursWeekdaySelectedState({@required this.day});
}
