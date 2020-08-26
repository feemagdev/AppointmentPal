import 'package:appointmentproject/BLoC/SignUpBloc/bloc.dart';
import 'package:appointmentproject/BLoC/SignUpBloc/sign_up_bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/ClientEmailVerification/email_verification.dart';
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
import 'background.dart';


class Body extends StatelessWidget {

  SignUpBloc signUpBloc;
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.height;
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccessfulState) {
                navigateToEmailVerificationPage(context, state.user);
              }
            },
            child: BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpInitialState) {
                    return Container();
                  } else if (state is SignUpLoadingState) {
                    return buildLoadingUi();
                  } else if (state is SignUpSuccessfulState) {
                    return Container();
                  } else if (state is SignUpFailureState) {
                    WidgetsBinding.instance.addPostFrameCallback((_){
                      showErrorDialog(state.message, context);
                    });
                  }
                  return Container();
                }),
          ),
          SizedBox(height: deviceHeight * 0.15,),
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
                                    email = value;
                                  },
                                ),
                                RoundedPasswordField(
                                  onChanged: (value) {
                                    password = value;
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
                              height: deviceWidth < 400 ? deviceHeight * 0.09:deviceHeight * 0.06,
                            color: Color.fromRGBO(56, 178, 227,1),
                            textColor: Colors.white,
                            text: "Sign up",
                            press: () async {
                              print('button pressed');
                              print(email);
                              if (email == null ||
                                  !EmailValidator.validate(email)) {
                                String message = "invalid email";
                                showErrorDialog(message, context);
                                return;
                              }
                              if (password == null) {
                                String message = "please write password again";
                                showErrorDialog(message, context);
                                return;
                              }
                              if(password.length <= 5){
                                String message = "please use strong password";
                                showErrorDialog(message, context);
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

  void navigateToClientDetailsPage(BuildContext context, FirebaseUser user,List<Service> services) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserDetail(user: user,services:services);
    }));
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }

  void navigateToEmailVerificationPage(BuildContext context,FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ClientEmailVerification(user:user);
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
