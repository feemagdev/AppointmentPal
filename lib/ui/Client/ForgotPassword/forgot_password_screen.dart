

import 'package:appointmentproject/bloc/ClientBloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:appointmentproject/ui/Client/ForgotPassword//components/body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
