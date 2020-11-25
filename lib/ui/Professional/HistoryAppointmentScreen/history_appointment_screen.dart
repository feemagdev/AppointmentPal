import 'package:appointmentproject/bloc/ProfessionalBloc/HistoryAppointmentBloc/history_appointment_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/HistoryAppointmentScreen/components/history_appointment_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HistoryAppointmentScreen extends StatelessWidget {
  final Professional professional;
  HistoryAppointmentScreen({@required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryAppointmentBloc(professional: professional),
      child: HistoryAppointmentBody(),
    );
  }
}
