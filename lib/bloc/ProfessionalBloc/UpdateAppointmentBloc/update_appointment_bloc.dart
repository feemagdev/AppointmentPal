import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
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
  final Manager manager;

  UpdateAppointmentBloc(
      {@required this.professional,
      @required this.appointment,
      @required this.customer,
      this.manager});

  @override
  Stream<UpdateAppointmentState> mapEventToState(
    UpdateAppointmentEvent event,
  ) async* {
    if (event is UpdateAppointmentDateTimeEvent) {
      yield UpdateAppointmentDateTimeState();
    } else if (event is MoveToEditAppointmentScreenEvent) {
      yield MoveToEditAppointmentScreenState();
    } else if (event is UpdateAppointmentSelectCustomerEvent) {
      yield UpdateAppointmentSelectCustomerState();
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
  UpdateAppointmentState get initialState => UpdateAppointmentInitial();
}
