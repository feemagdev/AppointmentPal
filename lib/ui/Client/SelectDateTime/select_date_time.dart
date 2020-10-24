


import 'package:appointmentproject/bloc/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';



class SelectDateTime extends StatelessWidget {

  final Professional professional;
  final Service service;
  final SubServices subService;
  final Client client;
  final FirebaseUser user;

  SelectDateTime({@required this.professional,@required this.service,@required this.subService,@required this.client,@required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectDateTimeBloc(professional:professional),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Book Appointment"),
        ),
          body: Body(client: client,service: service,subServices: subService,user: user,)),
    );
  }
}
