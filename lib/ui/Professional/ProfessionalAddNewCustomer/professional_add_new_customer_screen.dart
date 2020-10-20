import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalAddNewCustomerBloc/professional_add_new_customer_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddNewCustomer/components/professional_add_new_customer_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalAddNewCustomerScreen extends StatelessWidget {
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;

  ProfessionalAddNewCustomerScreen(
      {@required this.professional, this.selectedDateTime, this.schedule});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalAddNewCustomerBloc(
          professional: professional,
          selectedDateTime: selectedDateTime,
          schedule: schedule),
      child: ProfessionalAddNewCustomerBody(),
    );
  }
}
