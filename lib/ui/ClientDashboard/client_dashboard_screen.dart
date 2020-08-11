
import 'package:appointmentproject/BLoC/ClientDashboardBloc/client_dashboard_bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class ClientDashboardScreen extends StatelessWidget {

  final FirebaseUser user;
  final Client client;
   const ClientDashboardScreen({@required this.user, @required this.client});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocProvider(
        create: (context) => ClientDashboardBloc(),
        child: Scaffold(
          body: Body(user:user,client:client),
        ),
      ),
    );
  }
}
