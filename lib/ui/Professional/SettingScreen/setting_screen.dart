import 'package:appointmentproject/bloc/ProfessionalBloc/SettingScreenBloc/setting_screen_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/components/setting_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';






class SettingScreen extends StatelessWidget {
  final Professional professional;
  SettingScreen({@required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingScreenBloc(professional:professional),
      child: SettingScreenBody(),
    );
  }
}
