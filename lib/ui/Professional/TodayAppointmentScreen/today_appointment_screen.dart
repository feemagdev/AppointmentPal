



import 'package:appointmentproject/bloc/ProfessionalBloc/TodayAppointment/today_appointment_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/TodayAppointmentScreen/components/today_appointment_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayAppointmentScreen extends StatelessWidget {
  final Professional professional;

  TodayAppointmentScreen({@required this.professional});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodayAppointmentBloc(professional:professional),
      child: TodayAppointmentScreenBody(),
    );
  }
}
