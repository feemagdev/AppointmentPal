
import 'package:appointmentproject/bloc/ClientBloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:appointmentproject/ui/Login/login_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Body extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    String email;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.height;
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {},
            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
              if (state is ForgotPasswordInitial) {
                return buildInitialUi();
              } else if (state is ForgotPasswordEmailSent) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showErrorDialog(
                      "password email sent\nplease check you spam folder",
                      context);
                });
              } else if (state is ForgotPasswordEmailNotSent) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showErrorDialog(state.message, context);
                });
              }
              return Container();
            }),
          ),
          SizedBox(height: deviceHeight * 0.15),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1,
                    Text(
                      "Reset password here",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )),
                SizedBox(height: 10),
                FadeAnimation(
                    1.3,
                    Text(
                      "please check email in spam also",
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
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(59, 193, 226, 0.7),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                RoundedInputField(
                                  icon: Icon(Icons.email),
                                  hintText: "Email",
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 40),
                      SizedBox(height: 40),
                      FadeAnimation(
                          1.6,
                          RoundedButton(
                            text: "send reset link",
                            color: Color.fromRGBO(56, 178, 227, 1),
                            textColor: Colors.white,
                            height: deviceWidth < 400 ? deviceHeight * 0.09:deviceHeight * 0.07,
                            width: deviceWidth < 400 ? deviceHeight * 0.3:deviceHeight * 0.5,
                            press: () async {
                              if (email == null ||
                                  !EmailValidator.validate(email)) {
                                String message = "invalid email";
                                showErrorDialog(message, context);
                                return;
                              }
                              BlocProvider.of<ForgotPasswordBloc>(context).add(
                                  SendPasswordResetLink(email: email));
                            },
                          )),
                      SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(
                                1.8,
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Text(
                                          "sign in",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        onTap: () {
                                          navigateToSignInPage(context);
                                        },
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      )
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

  Widget buildInitialUi() {
    return Container();
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message) {
    return Text(
      message,
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }

  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
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
