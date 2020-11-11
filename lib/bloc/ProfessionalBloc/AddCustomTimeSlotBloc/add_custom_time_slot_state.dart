part of 'add_custom_time_slot_bloc.dart';

@immutable
abstract class AddCustomTimeSlotState {}

class AddCustomTimeSlotInitial extends AddCustomTimeSlotState {}

class AddCustomSlotLoadingState extends AddCustomTimeSlotState {}

class CustomSlotTimeSlotAddedSuccessfullyState extends AddCustomTimeSlotState {
  final List<CustomTimeSlots> customTimeSlots;

  CustomSlotTimeSlotAddedSuccessfullyState({@required this.customTimeSlots});
}

class GetCustomTimeSlotsState extends AddCustomTimeSlotState {
  final List<CustomTimeSlots> customTimeSlots;

  GetCustomTimeSlotsState({@required this.customTimeSlots});
}

class CustomTimeSlotNotAdded extends AddCustomTimeSlotState {}

class WrongTimeSelectedState extends AddCustomTimeSlotState {}
