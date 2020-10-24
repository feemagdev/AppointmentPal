
import 'package:appointmentproject/bloc/ClientBloc/EmailVerificationBloc/email_verification_bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class Body extends StatelessWidget {
  final FirebaseUser user;
  Body({@required this.user});

  @override
  Widget build(BuildContext context) {


    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.height;
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<EmailVerificationBloc, EmailVerificationState>(
            listener: (context, state) {
              if (state is EmailVerified) {
                print("email verified");
                navigateToClientDetailsPage(context, state.user,state.services);
              }
            },
            child: BlocBuilder<EmailVerificationBloc, EmailVerificationState>(

                builder: (context, state) {
              if (state is EmailVerificationInitial) {
                return Container();
              } else if (state is VerificationEmailSent) {
                WidgetsBinding.instance.addPostFrameCallback((_){
                  showErrorDialog("verification email sent", context);
                });

              } else if (state is EmailVerified) {
                return Container();
              } else if (state is EmailNotVerified) {
                WidgetsBinding.instance.addPostFrameCallback((_){
                  showErrorDialog("email not verified", context);
                });
              }else if(state is VerificationSentFailedState){
                WidgetsBinding.instance.addPostFrameCallback((_){
                  showErrorDialog(state.errorMessage, context);
                });
              }
              return Container();
            }),
          ),
          SizedBox(
            height: deviceHeight * 0.15,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1.0,
                    Text(
                      "Please verify your email",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      FadeAnimation(
                          1.3,
                          Text(
                              "Verification email sent. please check your inbox")),
                      SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                          1.6,
                          RoundedButton(
                            text: "send verification email again",
                            color: Color.fromRGBO(56, 178, 227, 1),
                            textColor: Colors.white,
                            height: deviceWidth < 400 ? deviceHeight * 0.09:deviceHeight * 0.07,
                            width: deviceWidth < 400 ? deviceHeight * 0.3:deviceHeight * 0.5,
                            press: () async {
                              BlocProvider.of<EmailVerificationBloc>(context).add(SendEmailVerificationEvent(user: user));
                            },
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                          1.6,
                          RoundedButton(
                            text: "check email verification",
                            color: Color.fromRGBO(56, 178, 227, 1),
                            textColor: Colors.white,
                            height: deviceWidth < 400 ? deviceHeight * 0.09:deviceHeight * 0.07,
                            width: deviceWidth < 400 ? deviceHeight * 0.3:deviceHeight * 0.5,
                            press: () async {
                              BlocProvider.of<EmailVerificationBloc>(context).add(CheckEmailVerification(user: user));
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToClientDetailsPage(
      BuildContext context, FirebaseUser user, List<Service> services) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserDetail(user: user, services: services);
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
                onPressed: () => {
                  Navigator.of(context).pop()
                },
              )
            ],
          );
        });
  }
}
