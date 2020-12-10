import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalEditProfileBloc/professional_edit_profile_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditProfileScreen/components/professional_edit_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalEditProfileScreen extends StatelessWidget {
  final Professional professional;
  ProfessionalEditProfileScreen({@required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfessionalEditProfileBloc(professional: professional),
      child: ProfessionalEditProfileBody(),
    );
  }
}
