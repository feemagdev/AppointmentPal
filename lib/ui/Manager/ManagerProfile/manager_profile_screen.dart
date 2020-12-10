import 'package:appointmentproject/bloc/ManagerBloc/ManagerProfileBloc/manager_profile_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerProfile/components/manager_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerProfileScreen extends StatelessWidget {
  final Manager manager;
  ManagerProfileScreen({@required this.manager});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerProfileBloc(manager: manager),
      child: ManagerProfileProfileBody(),
    );
  }
}
