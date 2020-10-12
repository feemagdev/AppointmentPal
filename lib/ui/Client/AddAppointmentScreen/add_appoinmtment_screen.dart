import 'package:appointmentproject/BLoC/AddAppointmentBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AddAppointmentScreen extends StatelessWidget {

  final List<Service> servicesList;
  final Client client;
  final FirebaseUser user;
  AddAppointmentScreen({@required this.servicesList,@required this.client,@required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAppointmentBloc(),
      child: Scaffold(
        body: Body(servicesList: servicesList,client:client,user:user),
      ),
    );
  }
}
