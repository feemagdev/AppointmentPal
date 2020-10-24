part of 'professional_edit_appointment_new_date_time_bloc.dart';

@immutable
abstract class ProfessionalEditAppointmentNewDateTimeState {}

class EditAppointmentNewDateTimeInitial extends ProfessionalEditAppointmentNewDateTimeState {
  final Appointment appointment;
  EditAppointmentNewDateTimeInitial({@required this.appointment});
}



class EditAppointmentShowSelectedDayAvailableTimeState extends ProfessionalEditAppointmentNewDateTimeState{
  final Appointment appointment;
  final Schedule schedule;
  final List<DateTime> timeSlots;


  EditAppointmentShowSelectedDayAvailableTimeState({@required this.appointment,@required this.timeSlots,@required this.schedule});
}

class EditAppointmentNewDateTimeNoAvailableTimeState extends ProfessionalEditAppointmentNewDateTimeState{
  final Appointment appointment;
  final DateTime dateTime;
  EditAppointmentNewDateTimeNoAvailableTimeState({@required this.appointment,@required this.dateTime});

}

class ProfessionalTimeSlotSelectedState extends ProfessionalEditAppointmentNewDateTimeState{
  final Appointment appointment;
  final Schedule schedule;
  final List<DateTime> timeSlots;
  final int selectedIndex;

  ProfessionalTimeSlotSelectedState({@required this.appointment,this.schedule,this.timeSlots,this.selectedIndex});
}


