
import 'package:appointmentproject/bloc/LoginBloc/login_bloc.dart';
import 'package:appointmentproject/ui/Login/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
