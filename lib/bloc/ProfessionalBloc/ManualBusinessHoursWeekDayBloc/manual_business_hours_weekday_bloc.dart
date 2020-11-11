import 'dart:async';

import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/week_days_availability.dart';
import 'package:appointmentproject/repository/week_days_availability_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manual_business_hours_weekday_event.dart';

part 'manual_business_hours_weekday_state.dart';

class ManualBusinessHoursWeekdayBloc extends Bloc<
    ManualBusinessHoursWeekdayEvent, ManualBusinessHoursWeekdayState> {
  final Professional professional;

  ManualBusinessHoursWeekdayBloc({@required this.professional});

  @override
  Stream<ManualBusinessHoursWeekdayState> mapEventToState(
    ManualBusinessHoursWeekdayEvent event,
  ) async* {
    if (event is ManualBusinessHoursForMondayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Monday');
    } else if (event is ManualBusinessHoursForTuesdayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Tuesday');
    } else if (event is ManualBusinessHoursForWednesdayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Wednesday');
    } else if (event is ManualBusinessHoursForThursdayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Thursday');
    } else if (event is ManualBusinessHoursForFridayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Friday');
    } else if (event is ManualBusinessHoursForSaturdayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Saturday');
    } else if (event is ManualBusinessHoursForSundayEvent) {
      yield ManualBusinessHoursWeekdaySelectedState(day: 'Sunday');
    } else if (event is GetManualAvailableWeekDaysStatusEvent) {
      yield ManualBusinessHoursWeekdayLoadingState();
      WeekDaysAvailability weekDaysAvailability =
          await WeekDaysAvailabilityRepository.defaultConstructor()
              .getListOfAvailableWeekDays(professional.getProfessionalID());
      yield GetManualAvailableWeekDaysStatusState(
          weekDaysAvailability: weekDaysAvailability);
    } else if (event is UpdateManualBusinessHoursWeekdaysEvent) {
      yield ManualBusinessHoursWeekdayLoadingState();
      await WeekDaysAvailabilityRepository.defaultConstructor()
          .updateWeekDaysAvailability(
              professional.getProfessionalID(), event.weekDaysAvailability);
      yield UpdateManualBusinessHoursWeekdaysState(
          updatedWeekDays: event.weekDaysAvailability);
    }
  }

  @override
  ManualBusinessHoursWeekdayState get initialState =>
      ManualBusinessHoursWeekdayInitial();
}
