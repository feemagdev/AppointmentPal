import 'package:appointmentproject/BLoC/SignUpBloc/bloc.dart';
import 'package:appointmentproject/BLoC/SignUpBloc/sign_up_bloc.dart';
import 'package:appointmentproject/ui/Login/login_screen.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/already_have_an_account_acheck.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:appointmentproject/ui/components/rounded_password_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../professional_home_page.dart';
import 'background.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  String email;
  String password;
  SignUpBloc signUpBloc;

  @override
  Widget build(BuildContext context) {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    double height = MediaQuery.of(context).size.height;
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccessfulState) {
                navigateToClientDetailsPage(context, state.user);
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(
                // ignore: missing_return
                builder: (context, state) {
              if (state is SignUpInitialState) {
                return Container();
              } else if (state is SignUpLoadingState) {
                return buildLoadingUi();
              } else if (state is SignUpSuccessfulState) {
                return Container();
              } else if (state is SignUpFailureState) {
                return buildFailureUi(state.message);
              }
            }),
          ),
          SizedBox(
            height: height * 0.15,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1,
                    Text(
                      "Sign Up ",
                      style: TextStyle(fontFamily:'Raleway',color: Colors.white, fontSize: 35),
                    )),
                SizedBox(height: 10),
                FadeAnimation(
                    1.3,
                    Text(
                      "Make your life easy",
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
                                    this.email = value;
                                  },
                                ),
                                RoundedPasswordField(
                                  onChanged: (value) {
                                    this.password = value;
                                  },
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                          1.6,
                          RoundedButton(
                            text: "SIGN UP",
                            press: () async {
                              print('button pressed');
                              print(this.email);
                              if (this.email == null ||
                                  !EmailValidator.validate(this.email)) {
                                String message = "invalid email";
                                showErrorDialog(message, context);
                                return;
                              }
                              if (password.length <= 5) {
                                String message = "please use a strong password";
                                showErrorDialog(message, context);
                                return;
                              }
                              signUpBloc.add(SignUpButtonPressedEvent(
                                  email: email, password: password));
                            },
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(
                                1.9,
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      AlreadyHaveAnAccountCheck(
                                        login: false,
                                        press: () async {
                                          navigateToLoginPage(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                          )
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

  void navigateToClientDetailsPage(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserDetail(user: user);
    }));
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  void navigateToProfessionalHomePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalHomePageParent();
    }));
  }

  Widget buildInitialUi() {
    return Text("Waiting for user registration");
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
