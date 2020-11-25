import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'automatic_business_hours_event.dart';
part 'automatic_business_hours_state.dart';

class AutomaticBusinessHoursBloc
    extends Bloc<AutomaticBusinessHoursEvent, AutomaticBusinessHoursState> {
  final Professional professional;
  AutomaticBusinessHoursBloc({@required this.professional});
  @override
  Stream<AutomaticBusinessHoursState> mapEventToState(
    AutomaticBusinessHoursEvent event,
  ) async* {
    if (event is AutomaticBusinessHoursForMondayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Monday");
    } else if (event is AutomaticBusinessHoursForTuesdayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Tuesday");
    } else if (event is AutomaticBusinessHoursForWednesdayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Wednesday");
    } else if (event is AutomaticBusinessHoursForThursdayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Thursday");
    } else if (event is AutomaticBusinessHoursForFridayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Friday");
    } else if (event is AutomaticBusinessHoursForSaturdayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Saturday");
    } else if (event is AutomaticBusinessHoursForSundayEvent) {
      yield AutomaticBusinessHoursWeekdaySelectedState(day: "Sunday");
    }
  }

  @override
  AutomaticBusinessHoursState get initialState =>
      AutomaticBusinessHoursInitial();
}
