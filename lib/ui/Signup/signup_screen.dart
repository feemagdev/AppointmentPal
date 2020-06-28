import 'package:appointmentproject/BLoC/SignUpBloc/sign_up_bloc.dart';
import 'package:appointmentproject/ui/Signup/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
