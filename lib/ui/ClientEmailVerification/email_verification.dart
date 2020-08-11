
import 'package:appointmentproject/BLoC/EmailVerificationBloc/email_verification_bloc.dart';
import 'package:appointmentproject/ui/ClientEmailVerification/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ClientEmailVerification extends StatelessWidget {
  final FirebaseUser user;
  ClientEmailVerification({@required this.user});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailVerificationBloc(),
      child: Scaffold(
        body: Body(user: user),
      ),
    );
  }
}
