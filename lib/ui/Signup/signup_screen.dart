import 'package:appointmentproject/bloc/SignupBloc/signup_bloc.dart';
import 'package:appointmentproject/ui/Signup/components/signup_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SignupBloc(), child: SignupBody());
  }
}
