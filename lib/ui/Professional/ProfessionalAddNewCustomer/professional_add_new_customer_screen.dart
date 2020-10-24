import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalAddNewCustomerBloc/professional_add_new_customer_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddNewCustomer/components/professional_add_new_customer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalAddNewCustomerScreen extends StatelessWidget {
  final Professional professional;
  final DateTime appointmentStartTime;
  final DateTime  appointmentEndTime;

  ProfessionalAddNewCustomerScreen(
      {@required this.professional, this.appointmentStartTime, this.appointmentEndTime});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalAddNewCustomerBloc(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime),
      child: ProfessionalAddNewCustomerBody(),
    );
  }
}
