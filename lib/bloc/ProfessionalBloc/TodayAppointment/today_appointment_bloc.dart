import 'dart:async';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'today_appointment_event.dart';

part 'today_appointment_state.dart';

class TodayAppointmentBloc
    extends Bloc<TodayAppointmentEvent, TodayAppointmentState> {
  final Professional professional;

  TodayAppointmentBloc({@required this.professional});

  @override
  TodayAppointmentState get initialState => TodayAppointmentInitial();

  @override
  Stream<TodayAppointmentState> mapEventToState(
    TodayAppointmentEvent event,
  ) async* {
    if (event is GetAllTodayAppointments) {
      yield TodayAppointmentLoadingState();
      List<Appointment> appointments = List();
      List<Customer> customers = List();
      appointments = await getListOfAppointments();
      if (appointments.isNotEmpty) {
        customers = await getListOfAppointmentCustomers(appointments);
      }
      yield GetAllTodayAppointmentState(
          appointments: appointments, customers: customers);
    } else if (event is MarkAppointmentComplete) {
      yield TodayAppointmentLoadingState();
      bool checkStatus = await AppointmentRepository.defaultConstructor()
          .markTheAppointmentComplete(event.appointment);
      if (checkStatus) {
        List<Appointment> appointments = List();
        List<Customer> customers = List();
        appointments = await getListOfAppointments();
        if (appointments.isNotEmpty) {
          customers = await getListOfAppointmentCustomers(appointments);
        }
        yield GetAllTodayAppointmentState(
            appointments: appointments, customers: customers);
      }
    } else if (event is MarkAppointmentCancel) {
      yield TodayAppointmentLoadingState();
      bool checkStatus = await AppointmentRepository.defaultConstructor()
          .markTheAppointmentCancel(event.appointment);
      if (checkStatus) {
        List<Appointment> appointments = List();
        List<Customer> customers = List();
        appointments = await getListOfAppointments();
        if (appointments.isNotEmpty) {
          customers = await getListOfAppointmentCustomers(appointments);
        }
        yield GetAllTodayAppointmentState(
            appointments: appointments, customers: customers);
      }
    }
  }

  Future<List<Appointment>> getListOfAppointments() async {
    return await AppointmentRepository.defaultConstructor()
        .getTodayAppointmentOfProfessional(professional.getProfessionalID());
  }

  Future<List<Customer>> getListOfAppointmentCustomers(
      List<Appointment> appointments) async {
    List<Customer> customers = List();
    await Future.forEach(appointments, (element) async {
      customers.add(await CustomerRepository.defaultConstructor()
          .getCustomer(element.getProfessionalID(), element.getCustomerID()));
    });
    return customers;
  }
}
