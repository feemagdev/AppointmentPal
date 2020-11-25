import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_appointment_event.dart';
part 'history_appointment_state.dart';

class HistoryAppointmentBloc
    extends Bloc<HistoryAppointmentEvent, HistoryAppointmentState> {
  final Professional professional;
  HistoryAppointmentBloc({@required this.professional});
  @override
  Stream<HistoryAppointmentState> mapEventToState(
    HistoryAppointmentEvent event,
  ) async* {
    if (event is GetHistoryOfCompletedAppointmentEvent) {
      yield HistoryAppointmentLoadingState();
      List<Appointment> appointmentList = List();
      appointmentList = await AppointmentRepository.defaultConstructor()
          .getCompletedAppointmentList(
              professional.getProfessionalID(), event.dateTime);
      List<Customer> customerList = List();
      if (appointmentList.isNotEmpty || appointmentList.length != 0) {
        await Future.forEach(appointmentList, (element) async {
          customerList.add(await CustomerRepository.defaultConstructor()
              .getCustomer(
                  element.getProfessionalID(), element.getCustomerID()));
        });
        yield GetHistoryOfCompletedAppointmentState(
            appointmentList: appointmentList, customerList: customerList);
      } else {
        yield NoHistoryCompletedAppointmentFoundState();
      }
    } else if (event is GetHistoryOfCanceledAppointmentEvent) {
      yield HistoryAppointmentLoadingState();
      List<Appointment> appointmentList = List();
      appointmentList = await AppointmentRepository.defaultConstructor()
          .getCanceledAppointmentList(
              professional.getProfessionalID(), event.dateTime);
      List<Customer> customerList = List();
      if (appointmentList.isNotEmpty || appointmentList.length != 0) {
        await Future.forEach(appointmentList, (element) async {
          customerList.add(await CustomerRepository.defaultConstructor()
              .getCustomer(
                  element.getProfessionalID(), element.getCustomerID()));
        });
        yield GetHistoryOfCanceledAppointmentState(
            appointmentList: appointmentList, customerList: customerList);
      } else {
        yield NoHistoryCompletedAppointmentFoundState();
      }
    }
  }

  @override
  HistoryAppointmentState get initialState => HistoryAppointmentInitial();
}
