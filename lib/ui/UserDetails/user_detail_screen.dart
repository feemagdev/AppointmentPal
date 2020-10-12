import 'package:appointmentproject/BLoC/ClientBloc/CompleteRegistrationBloc/bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/UserDetails/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class UserDetail extends StatelessWidget {

  final FirebaseUser user;
  final List<Service> services;
  UserDetail({@required this.user,@required this.services});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteRegistrationBloc(),
      child: Scaffold(
        body: Body(user: user,services: services,),
      ),
    );
  }
}