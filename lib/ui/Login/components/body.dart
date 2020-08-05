
import 'package:appointmentproject/BLoC/LoginBloc/login_bloc.dart';
import 'package:appointmentproject/BLoC/LoginBloc/login_event.dart';
import 'package:appointmentproject/BLoC/LoginBloc/login_state.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/already_have_an_account_acheck.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:appointmentproject/ui/components/rounded_password_field.dart';
import 'package:appointmentproject/ui/professional_home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'background.dart';

class Body extends StatelessWidget {
  String email;
  String password;
  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<LoginBloc, LoginState>(
            // ignore: missing_return
            listener: (context, state) {
              if (state is ClientLoginSuccessState) {
                print("login body client login");
                navigateToClientHomePage(context, state.user);
              } else if (state is ProfessionalLoginSuccessState) {
                print("login body professional login");
                print(state.user.email);
                navigateToProfessionalHomePage(context, state.user);
              }else if(state is ClientDetailsNotFilledSignIn){
                print("no details found");
                navigateToClientDetailsPage(context,state.services,state.user);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
              if (state is LoginInitialState) {
                return buildInitialUi();
              } else if (state is LoginLoadingState) {
                return buildLoadingUi();
              } else if (state is ProfessionalLoginSuccessState) {
                return Container();
              } else if (state is ClientLoginSuccessState) {
                return Container();
              } else if (state is LoginFailureState) {
                return buildFailureUi(state.message);
              }else if(state is ClientDetailsNotFilledSignIn){
                return Container();
              }
              return Container();
            }),
          ),
          SizedBox(height: size.height * 0.15),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1,
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )),
                SizedBox(height: 10),
                FadeAnimation(
                    1.3,
                    Text(
                      "Welcome Back",
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
                      SizedBox(height: 60,),
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
                      SizedBox(height: 40),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          )),
                      SizedBox(height: 40),
                      FadeAnimation(
                          1.6,
                          RoundedButton(
                            text: "LOGIN",
                            press: () async {
                              if (this.email == null ||
                                  !EmailValidator.validate(this.email)) {
                                String message = "invalid email";
                                showErrorDialog(message, context);
                                return;
                              }
                              if (password.length <= 5) {
                                String message = "too short";
                                showErrorDialog(message, context);
                                return;
                              }
                              loginBloc.add(LoginButtonPressedEvent(
                                  email: this.email, password: this.password));
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
                                      AlreadyHaveAnAccountCheck(
                                        login: true,
                                        press: () async {
                                          navigateToSignUpPage(context);
                                        },
                                      ),
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



  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpScreen();
    }));
  }

  void navigateToProfessionalHomePage(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalHomePageParent(user: user);
    }));
  }

  void navigateToClientHomePage(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ClientDashboardScreen(user: user);
    }));
  }

  void navigateToClientDetailsPage(BuildContext context, List<Service> services,FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserDetail(user: user,services: services,);
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
