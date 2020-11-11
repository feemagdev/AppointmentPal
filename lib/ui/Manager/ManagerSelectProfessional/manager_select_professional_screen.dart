import 'package:appointmentproject/bloc/ManagerBloc/ManagerSelectProfessionalBloc/manager_select_professional_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/components/manager_select_professional_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ManagerSelectProfessionalScreen extends StatelessWidget {
  final Manager manager;
  final String route;

  ManagerSelectProfessionalScreen({@required this.manager, this.route});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManagerSelectProfessionalBloc(manager: manager, route: route),
      child: ManagerSelectProfessionalBody(),
    );
  }
}
