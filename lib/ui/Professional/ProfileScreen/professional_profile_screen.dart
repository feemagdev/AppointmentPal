import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalProfileBloc/professional_profile_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfileScreen/components/professional_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  final Professional professional;
  final Manager manager;
  ProfessionalProfileScreen({@required this.professional, this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfessionalProfileBloc(professional: professional, manager: manager),
      child: ProfessionalProfileBody(),
    );
  }
}
