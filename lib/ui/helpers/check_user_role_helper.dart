
import 'package:appointmentproject/BLoC/UserRoleBloc/bloc.dart';

import 'package:appointmentproject/ui/Client/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
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
    return BlocBuilder<UserRoleBloc,UserRoleState>(
      builder: (context,state){
        if(state is ProfessionalState){
          return ProfessionalDashboard(professional: state.professional);
        }
        else if(state is ClientState){
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
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 20,),
          Center(
            child: Text("please wait ...",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),),
          ),

        ],
      )
    );
  }

}