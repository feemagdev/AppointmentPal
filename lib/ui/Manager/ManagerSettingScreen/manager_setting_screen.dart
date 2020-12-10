import 'package:appointmentproject/bloc/ManagerBloc/ManagerSettingScreenBloc/manager_setting_screen_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerSettingScreen/components/manager_setting_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerSettingScreen extends StatelessWidget {
  final Manager manager;
  ManagerSettingScreen({@required this.manager});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contex) => ManagerSettingScreenBloc(manager: manager),
      child: ManagerSettingScreenBody(),
    );
  }
}
