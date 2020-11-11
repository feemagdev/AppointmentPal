import 'package:appointmentproject/bloc/ProfessionalBloc/AddCustomTimeSlotBloc/add_custom_time_slot_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AddCustomTimeSlotScreen/components/add_custom_time_slot_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCustomTimeSlotScreen extends StatelessWidget {
  final Professional professional;
  final String day;

  AddCustomTimeSlotScreen({@required this.professional,@required this.day});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddCustomTimeSlotBloc(professional: professional, day: day),
      child: AddCustomTimeSlotBody(),
    );
  }
}
