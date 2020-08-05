import 'package:appointmentproject/BLoC/EmailVerfificationBloc/email_verification_bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class Body extends StatelessWidget {

  final FirebaseUser user;
  EmailVerificationBloc emailVerificationBloc;
  Body({@required this.user});

  @override
  Widget build(BuildContext context) {
    emailVerificationBloc = BlocProvider.of<EmailVerificationBloc>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BlocListener<EmailVerificationBloc, EmailVerificationState>(
            listener: (context, state) {
              if (state is EmailVerified) {
                navigateToClientDetailsPage(context,state.user,state.services);
              }
            },
            child: BlocBuilder<EmailVerificationBloc, EmailVerificationState>(
                builder: (context, state) {
                  if (state is EmailVerificationInitial) {
                    return Container();
                  } else if (state is EmailVerified) {
                    return Container();
                  } else if (state is EmailNotVerified) {
                    String message = "email not verified";
                    print(message);
                    //showErrorDialog(message, context);
                  }else if(state is VerificationEmailSent){
                    String message = "verification email sent";
                    print(message);
                   // showErrorDialog(message, context);
                  }
                  return Container();
                }),
          ),
          Text("verification email sent to you"),
          SizedBox(height: 20,),
          RoundedButton(
            text: "Send email again",
            press: () {
              emailVerificationBloc.add(SendEmailVerificationEvent(user: user));
            },
          ),
          SizedBox(height: 20,),
          RoundedButton(
            text: "Click here after verification",
            press: () {
              emailVerificationBloc.add(CheckEmailVerification(user: user));
            },
          )
        ],
      ),
    );
  }

  void navigateToClientDetailsPage(BuildContext context, FirebaseUser user,List<Service> services) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserDetail(user: user,services:services);
    }));
  }


  showErrorDialog(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}