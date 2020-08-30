
import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/BLoC/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'components/body.dart';



class SelectDateTime extends StatelessWidget {

  final Professional professional;
  final Service service;
  final SubServices subService;

  SelectDateTime({@required this.professional,@required this.service,@required this.subService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectDateTimeBloc(professional:professional),
      child: Body(),
    );
  }
}
