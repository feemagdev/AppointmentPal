
import 'package:appointmentproject/BLoC/UserRoleBloc/bloc.dart';
import 'package:appointmentproject/model/service.dart';

import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/professional_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';





class CheckUserRole extends StatelessWidget{
  final FirebaseUser user;
  CheckUserRole({@required this.user});
  @override
  Widget build(BuildContext context) {
    print("in check user role helper");
    return BlocBuilder<UserRoleBloc,UserRoleState>(
      builder: (context,state){
        if(state is ProfessionalState){
          print("if professional state run");
          return ProfessionalHomePageParent(user: user);
        }
        else if(state is ClientState){
          print("else if client state run");
          return ClientDashboardScreen(user:user,client: state.client);
        }
        else if(state is InitialUserRoleState){
          return userInitialState(context);
        }else if(state is ClientDetailsNotFilled){
          return UserDetail(user: user, services: state.services);
        }
        return Container();
      },
    );
  }

  Widget userInitialState(BuildContext context){
    return Container(
      child: Center(
        heightFactor: 30,
        widthFactor: 30,
        child: CircularProgressIndicator(),
      )
    );
  }

}