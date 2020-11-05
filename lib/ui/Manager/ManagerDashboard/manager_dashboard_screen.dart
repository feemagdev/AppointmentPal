import 'package:appointmentproject/bloc/ManagerBloc/ManagerDashboardBloc/manager_dashboard_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/components/manager_dashboard_body.dart';

class ManagerDashboardScreen extends StatelessWidget {
  final Manager manager;

  ManagerDashboardScreen({@required this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerDashboardBloc(manager: manager),
      child: ManagerDashboardBody(),
    );
  }
}
