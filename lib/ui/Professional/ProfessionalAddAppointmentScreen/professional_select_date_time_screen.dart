import 'package:appointmentproject/BLoC/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/components/professional_select_date_time_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSelectDateTimeScreen extends StatelessWidget {
  final Professional professional;
  final Appointment appointment;

  ProfessionalSelectDateTimeScreen(
      {@required this.professional, this.appointment});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectDateTimeBloc(
            professional: professional, appointment: appointment),
        child: ProfessionalSelectDateTime(
          professional: professional,
          appointment: appointment,
        ));
  }
}
