import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalPaymentBloc/professional_payment_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalPaymentScreen/component/professional_payment_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalPaymentScreen extends StatelessWidget {
  final Professional professional;
  final Manager manager;
  ProfessionalPaymentScreen({this.professional, this.manager});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfessionalPaymentBloc(professional: professional, manager: manager),
      child: ProfessionalPaymentBody(),
    );
  }
}
