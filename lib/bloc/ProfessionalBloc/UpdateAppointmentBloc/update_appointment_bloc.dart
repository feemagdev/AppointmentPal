import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_appointment_event.dart';
part 'update_appointment_state.dart';

class UpdateAppointmentBloc extends Bloc<UpdateAppointmentEvent, UpdateAppointmentState> {

  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  UpdateAppointmentBloc({@required this.professional,@required this.appointment,@required this.customer});



  @override
  Stream<UpdateAppointmentState> mapEventToState(
    UpdateAppointmentEvent event,
  ) async* {

    if(event is UpdateAppointmentDateTimeEvent){
      yield UpdateAppointmentDateTimeState(professional: event.professional, appointment: event.appointment, customer: event.customer);
    }else if(event is MoveToEditAppointmentScreenEvent){
      yield MoveToEditAppointmentScreenState(professional:event.professional);
    }

  }

  @override
  UpdateAppointmentState get initialState => UpdateAppointmentInitial(professional: professional,appointment: appointment,customer: customer);
}
