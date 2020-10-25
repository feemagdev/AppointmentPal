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
  Stream<TodayAppointmentState> mapEventToState(
      TodayAppointmentEvent event,) async* {
    if (event is GetAllTodayAppointments) {
      List<Appointment> appointments = List();
      List<Customer> customers = List();
      appointments = await AppointmentRepository.defaultConstructor()
          .getTodayAppointmentOfProfessional(professional.getProfessionalID());
      if (appointments.isNotEmpty) {
        await Future.forEach(appointments, (element) async{
          customers.add(await CustomerRepository.defaultConstructor().getCustomer(element.getCustomerID()));
        });
      }

      yield GetAllTodayAppointmentState(appointments: appointments,customers: customers);
    }
  }

  @override
  TodayAppointmentState get initialState => TodayAppointmentInitial();
}
