


import 'package:appointmentproject/bloc/UserRoleBloc/user_role_bloc.dart';
import 'package:appointmentproject/bloc/UserRoleBloc/user_role_state.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';





class CheckUserRole extends StatelessWidget{
  final User user;
  CheckUserRole({@required this.user});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRoleBloc,UserRoleState>(
      builder: (context,state){
        if(state is ProfessionalState){
          return ProfessionalDashboard(professional: state.professional);
        }
        else if(state is InitialUserRoleState){
          return userInitialState(context);
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