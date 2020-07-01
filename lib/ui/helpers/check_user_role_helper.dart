
import 'package:appointmentproject/BLoC/UserRoleBloc/bloc.dart';

import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/Welcome/welcome_screen.dart';
import 'package:appointmentproject/ui/professional_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';





class CheckUserRole extends StatelessWidget{
  final FirebaseUser user;
  UserRoleBloc userRoleBloc;
  CheckUserRole({@required this.user});
  @override
  Widget build(BuildContext context) {
    userRoleBloc = BlocProvider.of(context)..add(CheckUserRoleEvent());
    return BlocBuilder<UserRoleBloc,UserRoleState>(
      builder: (context,state){
        if(state is ProfessionalState){
          print("if professional state run");
          return ProfessionalHomePageParent(user: user);
        }
        else if(state is ClientState){
          print("else if client state run");
          return ClientDashboardScreen(user:user);
        }
        else if(state is InitialUserRoleState){
          return userInitialState(context);
        }
        return Container();
      },
    );
  }

  Widget userInitialState(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        heightFactor: 30,
        widthFactor: 30,
        child: CircularProgressIndicator(),
      )
    );
  }

}