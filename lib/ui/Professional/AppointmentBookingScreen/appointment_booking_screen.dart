
import 'package:appointmentproject/bloc/ProfessionalBloc/AppointmentBookingBloc/appointment_booking_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AppointmentBookingScreen/components/appointment_booking_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final Professional professional;
  final Customer customer;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Manager manager;

  AppointmentBookingScreen(
      {@required this.professional,
      @required this.customer,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.manager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppointmentBookingBloc(
              professional: professional,
              customer: customer,
              appointmentStartTime: appointmentStartTime,
              appointmentEndTime: appointmentEndTime,
              manager: manager),
      child: AppointmentBookingScreenBody(),
    );
  }
}
