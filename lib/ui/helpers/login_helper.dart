



import 'package:appointmentproject/BLoC/AuthBloc/auth_bloc.dart';
import 'package:appointmentproject/BLoC/AuthBloc/auth_state.dart';
import 'package:appointmentproject/BLoC/UserRoleBloc/user_role_bloc.dart';
import 'package:appointmentproject/BLoC/UserRoleBloc/user_role_event.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'check_user_role_helper.dart';

class LoginHelper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context,state){
        if(state is UnAuthenticatedState){
          print("un-authenticated state");
          return navigateToSignUpPage(context);
        } else if(state is AuthenticatedState){
          print("authenticated run");
          return navigateToCheckUserRole(context,state.user);
        }
        return Container();

      },
      child: BlocBuilder<AuthBloc,AuthState>(builder: (context,state){
        if(state is AuthInitialState){
          return Container();
        }
        return Container();
      }),
    );
  }


  navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SignUpScreen();
    }));
  }


  navigateToCheckUserRole(BuildContext context,FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return BlocProvider(
        create: (context) => UserRoleBloc()..add(CheckUserRoleEvent()),
        child: CheckUserRole(user: user)
      );
    }));
  }


}