import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalAddNewCustomerBloc/professional_add_new_customer_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddNewCustomer/components/professional_add_new_customer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalAddNewCustomerScreen extends StatelessWidget {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Appointment appointment;
  final Customer customer;
  final Manager manager;

  ProfessionalAddNewCustomerScreen(
      {@required this.professional,
      this.appointmentStartTime,
      this.appointmentEndTime,
      this.appointment,
      this.customer,
      this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalAddNewCustomerBloc(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime,
          appointment: appointment,
          customer: customer,
          manager: manager),
      child: ProfessionalAddNewCustomerBody(),
    );
  }
}
