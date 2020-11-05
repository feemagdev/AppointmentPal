import 'package:appointmentproject/bloc/ManagerBloc/ManagerAddProfessionalBloc/manager_add_professional_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerAddProfessional/components/manager_add_professioal_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerAddProfessionalScreen extends StatelessWidget {
  final Manager manager;

  ManagerAddProfessionalScreen({@required this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerAddProfessionalBloc(manager: manager),
      child: MnagaerAddProfessionalBody(),
    );
  }
}
