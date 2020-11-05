import 'package:appointmentproject/bloc/ManagerBloc/ManagerSelectProfessionalBloc/manager_select_professional_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/components/manager_select_professional_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ManagerSelectProfessionalScreen extends StatelessWidget {
  final Manager manager;

  ManagerSelectProfessionalScreen({@required this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerSelectProfessionalBloc(manager: manager),
      child: ManagerSelectProfessionalBody(),
    );
  }
}
