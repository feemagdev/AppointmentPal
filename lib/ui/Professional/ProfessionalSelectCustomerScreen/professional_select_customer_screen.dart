import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalSelectCustomerBloc/professional_select_customer_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/components/professional_select_customer_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ProfessionalSelectCustomerScreen extends StatelessWidget {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Appointment appointment;
  final Customer customer;

  ProfessionalSelectCustomerScreen(
      {@required this.professional,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.appointment,
      this.customer});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalSelectCustomerBloc(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime,appointment: appointment,customer: customer),
      child: ProfessionalSelectCustomerScreenBody(),
    );
  }
}
