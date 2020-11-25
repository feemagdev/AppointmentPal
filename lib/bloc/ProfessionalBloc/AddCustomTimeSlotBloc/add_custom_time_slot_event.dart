part of 'add_custom_time_slot_bloc.dart';

@immutable
abstract class AddCustomTimeSlotEvent {}

class GetCustomTimeSlotEvent extends AddCustomTimeSlotEvent {}

class ProfessionalAddCustomTimeSlotEvent extends AddCustomTimeSlotEvent {
  final DateTime from;
  final DateTime to;

  ProfessionalAddCustomTimeSlotEvent({@required this.from, @required this.to});
}

class DeleteCustomTimeSlotEvent extends AddCustomTimeSlotEvent {
  final CustomTimeSlots customTimeSlots;
  DeleteCustomTimeSlotEvent({@required this.customTimeSlots});
}
