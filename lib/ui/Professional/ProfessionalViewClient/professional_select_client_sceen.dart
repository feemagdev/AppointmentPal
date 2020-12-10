import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalSelectClientBloc/professional_select_client_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalViewClient/components/professional_select_client_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSelectClientScreen extends StatelessWidget {
  final Professional professional;
  ProfessionalSelectClientScreen({@required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfessionalSelectClientBloc(professional: professional),
      child: ProfessionalSelectClientBody(),
    );
  }
}
