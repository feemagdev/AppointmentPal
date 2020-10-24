
import 'package:appointmentproject/bloc/ClientBloc/EditAppointmentBloc/edit_appointment_bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/ui/Client/ClientEditAppointmentScreen/components/client_edit_appointment_screen_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class EditAppointmentScreen extends StatelessWidget{
  final Client client;
  EditAppointmentScreen({@required this.client});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditAppointmentBloc(client:client),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit appointment"),
        ),
        body: Body(),
      ),
    );
  }

}