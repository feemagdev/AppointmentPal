part of 'automatic_business_hours_bloc.dart';

abstract class AutomaticBusinessHoursEvent {}

class AutomaticBusinessHoursForMondayEvent extends AutomaticBusinessHoursEvent {
}

class AutomaticBusinessHoursForTuesdayEvent
    extends AutomaticBusinessHoursEvent {}

class AutomaticBusinessHoursForWednesdayEvent
    extends AutomaticBusinessHoursEvent {}

class AutomaticBusinessHoursForThursdayEvent
    extends AutomaticBusinessHoursEvent {}

class AutomaticBusinessHoursForFridayEvent extends AutomaticBusinessHoursEvent {
}

class AutomaticBusinessHoursForSaturdayEvent
    extends AutomaticBusinessHoursEvent {}

class AutomaticBusinessHoursForSundayEvent extends AutomaticBusinessHoursEvent {
}
