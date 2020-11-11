




import 'package:appointmentproject/bloc/ProfessionalBloc/UpdateAppointmentBloc/update_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/UpdateAppointmentScreen/components/update_appointment_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UpdateAppointmentScreen extends StatelessWidget {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  final Manager manager;

  UpdateAppointmentScreen(
      {@required this.professional,
      @required this.appointment,
      @required this.customer,
      this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateAppointmentBloc(
          professional: professional,
          appointment: appointment,
          customer: customer,
          manager: manager),
      child: UpdateAppointmentScreenBody(),
    );
  }
}
