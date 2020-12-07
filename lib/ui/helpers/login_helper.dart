import 'package:appointmentproject/bloc/AuthBloc/auth_bloc.dart';
import 'package:appointmentproject/bloc/AuthBloc/auth_state.dart';
import 'package:appointmentproject/bloc/UserRoleBloc/user_role_bloc.dart';
import 'package:appointmentproject/bloc/UserRoleBloc/user_role_event.dart';
import 'package:appointmentproject/ui/Login/login_screen.dart';
import 'package:appointmentproject/ui/helpers/check_user_role_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          return navigateToLoginPage(context);
        } else if (state is AuthenticatedState) {
          return navigateToCheckUserRole(context, state.user);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthInitialState) {
          return Container();
        }
        print("no auth state run");
        return Container(
          color: Colors.white,
        );
      }),
    );
  }

  navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  navigateToCheckUserRole(BuildContext context, User user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BlocProvider(
          create: (context) =>
              UserRoleBloc()..add(CheckUserRoleEvent(user: user)),
          child: CheckUserRole(user: user));
    }));
  }
}
