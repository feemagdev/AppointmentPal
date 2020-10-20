




import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalSelectCustomerBloc/professional_select_customer_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/components/professional_select_customer_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ProfessionalSelectCustomerScreen extends StatelessWidget{
  final Professional professional;
  final DateTime selectedDateTime;
  final Schedule schedule;
  ProfessionalSelectCustomerScreen({@required this.professional,@required this.selectedDateTime,@required this.schedule});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalSelectCustomerBloc(professional:professional,selectedDateTime: selectedDateTime,schedule:schedule),
      child: ProfessionalSelectCustomerScreenBody(),
    );
  }


}