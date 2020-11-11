
import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalEditAppointment/professional_edit_appointment_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditAppointmentScreen/components/professional_edit_appointment_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ProfessionalEditAppointmentScreen extends StatelessWidget{
  final Professional professional;
  final Manager manager;

  ProfessionalEditAppointmentScreen(
      {@required this.professional, this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalEditAppointmentBloc(
          professional: professional, manager: manager),
      child: ProfessionalEditAppointmentBody(),
    );
  }
}