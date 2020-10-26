import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_appointment_event.dart';

part 'update_appointment_state.dart';

class UpdateAppointmentBloc
    extends Bloc<UpdateAppointmentEvent, UpdateAppointmentState> {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;

  UpdateAppointmentBloc(
      {@required this.professional,
      @required this.appointment,
      @required this.customer});

  @override
  Stream<UpdateAppointmentState> mapEventToState(
    UpdateAppointmentEvent event,
  ) async* {
    if (event is UpdateAppointmentDateTimeEvent) {
      yield UpdateAppointmentDateTimeState(
          professional: event.professional,
          appointment: event.appointment,
          customer: event.customer);
    } else if (event is MoveToEditAppointmentScreenEvent) {
      yield MoveToEditAppointmentScreenState(professional: event.professional);
    } else if (event is UpdateAppointmentSelectCustomerEvent) {
      yield UpdateAppointmentSelectCustomerState(
          professional: event.professional,
          appointment: event.appointment,
          customer: event.customer);
    }else if(event is UpdateAppointmentButtonPressedEvent){
      yield UpdateAppointmentLoadingState();
      appointment.setCustomerID(customer.getCustomerID());

      bool updated = await AppointmentRepository.defaultConstructor().updateAppointment(appointment);
      if(updated){
        yield AppointmentUpdatedSuccessfullyState();
      }

    }
  }

  @override
  UpdateAppointmentState get initialState => UpdateAppointmentInitial(
      professional: professional, appointment: appointment, customer: customer);
}
