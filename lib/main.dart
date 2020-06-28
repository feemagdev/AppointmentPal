import 'package:appointmentproject/BLoC/authBloc/auth_bloc.dart';
import 'package:appointmentproject/BLoC/authBloc/auth_event.dart';
import 'package:appointmentproject/BLoC/authBloc/auth_state.dart';
import 'package:appointmentproject/BLoC/userRoleBloc/bloc.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:appointmentproject/ui/helpers/check_user_role_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter bloc",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context,state){
        if(state is AuthInitialState){
          return SplashScreen();
        }else if(state is UnAuthenticatedState){
          return SignUpScreen();
        } else if(state is AuthenticatedState){
          print("authenticated run");
          return BlocProvider(
            create: (context)=> UserRoleBloc()..add(CheckUserRoleEvent()),
            child: CheckUserRole(user: state.user),
          );
        }else{
          return null;
        }
      },
    );
  }
}


class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome"),
    );
  }
  
}
