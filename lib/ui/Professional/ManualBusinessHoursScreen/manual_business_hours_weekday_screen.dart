import 'package:appointmentproject/bloc/ProfessionalBloc/ManualBusinessHoursWeekDayBloc/manual_business_hours_weekday_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ManualBusinessHoursScreen/components/manual_business_hours_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class ManualBusinessHoursWeekDayScreen extends StatelessWidget {
  final Professional professional;
  ManualBusinessHoursWeekDayScreen({@required this.professional});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManualBusinessHoursWeekdayBloc(professional:professional),
      child: ManualBusinessHoursWeekdayBody(),
    );
  }
}
