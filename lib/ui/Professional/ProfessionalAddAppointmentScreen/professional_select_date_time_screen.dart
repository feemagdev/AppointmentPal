
import 'package:appointmentproject/bloc/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/components/professional_select_date_time_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSelectDateTimeScreen extends StatelessWidget {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  final Manager manager;

  ProfessionalSelectDateTimeScreen(
      {@required this.professional,
      this.appointment,
      this.customer,
      this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectDateTimeBloc(
            professional: professional,
            appointment: appointment,
            customer: customer,
            manager: manager),
        child: ProfessionalSelectDateTime());
  }
}
