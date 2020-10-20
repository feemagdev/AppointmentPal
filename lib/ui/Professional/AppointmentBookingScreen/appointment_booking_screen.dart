import 'package:appointmentproject/BLoC/ProfessionalBloc/AppointmentBookingBloc/appointment_booking_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Professional/AppointmentBookingScreen/components/appointment_booking_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final Professional professional;
  final Customer customer;
  final DateTime selectedDateTime;
  final Schedule schedule;

  AppointmentBookingScreen(
      {@required this.professional,
      @required this.customer,
      @required this.selectedDateTime,
      @required this.schedule});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentBookingBloc(
          professional: professional,
          customer: customer,
          selectedDateTime: selectedDateTime,
          schedule: schedule),
      child: AppointmentBookingScreenBody(),
    );
  }
}
