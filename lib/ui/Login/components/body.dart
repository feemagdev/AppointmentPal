

import 'package:appointmentproject/bloc/LoginBloc/login_bloc.dart';
import 'package:appointmentproject/bloc/LoginBloc/login_event.dart';
import 'package:appointmentproject/bloc/LoginBloc/login_state.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/Client/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/Client/ForgotPassword/forgot_password_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/already_have_an_account_acheck.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:appointmentproject/ui/components/rounded_password_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Body extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    String email;
    String password;
    return Background(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                print("in bloc");
                if (state is ClientLoginSuccessState) {
                  print("login body client login");
                  navigateToClientHomePage(context, state.user, state.client);
                } else if (state is ProfessionalLoginSuccessState) {
                  print("login body professional login");
                  navigateToProfessionalHomePage(context, state.professional);
                }else if(state is ClientDetailsNotFilledSignIn){
                  print("no details found");
                  navigateToClientDetailsPage(context,state.services,state.user);
                }else if(state is ForgotPasswordState){
                  navigateToForgotPasswordPage(context);
                }else if(state is DoNotHaveAnAccountState){
                  navigateToSignUpPage(context);
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
                  print("login body success");
                  return Container();
                } else if(state is DoNotHaveAnAccountState){
                  return Container();
                }else if (state is LoginFailureState) {
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    showErrorDialog(state.message, context);
                  });
                }else if(state is ClientDetailsNotFilledSignIn){
                  return Container();
                }else if(state is ForgotPasswordState){
                  return Container();
                }
                print("no state is run");
                return Container();
              }),
            ),
            SizedBox(height: deviceHeight * 0.10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: deviceWidth < 400 ? 15 : 25,)),
                      ),
                  SizedBox(height: 10),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: deviceWidth < 400 ? 12 : 20,),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Center(
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
                          SizedBox(height: 40),
                          FadeAnimation(
                              1.5,
                              GestureDetector(
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.grey,
                                    fontSize: deviceWidth < 400 ? 15:20,
                                  ),

                                ),
                                onTap: (){
                                  print("forgot button tap");
                                  BlocProvider.of<LoginBloc>(context).add(ForgotPasswordButtonPressedEvent());
                                },
                              )),
                          SizedBox(height: 40),
                          FadeAnimation(
                              1.6,
                              RoundedButton(
                                height: deviceWidth < 400 ? 40:60,
                                color: Colors.blue,
                                textColor: Colors.white,
                                fontSize: deviceWidth < 400 ? 15:20,
                                text: "Login",
                                press: ()  {
                                  print(email);
                                  if (email == null ||
                                      !EmailValidator.validate(email)) {
                                    String message = "invalid email";
                                    showErrorDialog(message, context);
                                    return;
                                  }
                                  if (password.length <= 5) {
                                    String message = "too short";
                                    showErrorDialog(message, context);
                                    return;
                                  }
                                  BlocProvider.of<LoginBloc>(context).add(LoginButtonPressedEvent(
                                        email: email, password: password));

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
                                            text:"Don't have an account ? sign Up",
                                            press: ()  {
                                              BlocProvider.of<LoginBloc>(context).add(DoNotHaveAnAccountEvent());
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

  void navigateToProfessionalHomePage(BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional,);
    }));
  }

  void navigateToClientHomePage(BuildContext context, FirebaseUser user,Client client) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ClientDashboardScreen(user: user,client: client,);
    }));
  }

  void navigateToClientDetailsPage(BuildContext context, List<Service> services,FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserDetail(user: user,services: services,);
    }));
  }

  void navigateToForgotPasswordPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ForgotPasswordScreen();
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
