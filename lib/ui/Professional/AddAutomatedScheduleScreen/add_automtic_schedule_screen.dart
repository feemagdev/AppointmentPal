import 'package:appointmentproject/bloc/ProfessionalBloc/AddAutomaticSchedule/add_automatic_schedule_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AddAutomatedScheduleScreen/components/add_automatic_schedule_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAutomaticScheduleScreen extends StatelessWidget {
  final String day;
  final Professional professional;

  AddAutomaticScheduleScreen({@required this.day, @required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddAutomaticScheduleBloc(day: day, professional: professional),
      child: AddAutomaticScheduleBody(),
    );
  }
}
