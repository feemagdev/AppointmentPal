import 'package:appointmentproject/bloc/ProfessionalBloc/AutomaticBusinessHoursBloc/automatic_business_hours_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AutomaticBusinessHoursScreen/components/automatic_business_hours_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AutomaticBusinessHoursScreen extends StatelessWidget {
  final Professional professional;
  AutomaticBusinessHoursScreen({@required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AutomaticBusinessHoursBloc(professional: professional),
      child: AutomaticBusinessHoursBody(),
    );
  }
}
