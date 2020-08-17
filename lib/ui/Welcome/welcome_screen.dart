
import 'package:appointmentproject/BLoC/SplashScreen/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:appointmentproject/ui/Welcome/components/body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc()..add(SplashScreenStartEvent()),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}

