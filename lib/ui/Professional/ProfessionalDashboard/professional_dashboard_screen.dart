import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalDashboardBloc/professional_dashboard_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/components/professional_dashboard_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

class ProfessionalDashboard extends StatelessWidget {
  final Professional professional;

  const ProfessionalDashboard({@required this.professional});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider(
        create: (context)=>ProfessionalDashboardBloc(),
        child: Scaffold(
          body: ProfessionalDashboardBody(professional: professional),
        ),
      ),
    );
  }
}
