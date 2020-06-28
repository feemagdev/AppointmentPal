
import 'package:appointmentproject/BLoC/ClientDashboardBloc/client_dashboard_bloc.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class ClientDashboardScreen extends StatelessWidget {

  final FirebaseUser user;

   const ClientDashboardScreen({@required this.user});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientDashboardBloc(),
      child: Scaffold(
        body: Body(user:user),
      ),
    );
  }
}
