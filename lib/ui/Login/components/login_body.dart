import 'package:appointmentproject/bloc/LoginBloc/login_bloc.dart';
import 'package:appointmentproject/bloc/LoginBloc/login_event.dart';
import 'package:appointmentproject/bloc/LoginBloc/login_state.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Client/CompleteDetails/complete_detail_screen.dart';
import 'package:appointmentproject/ui/Client/ForgotPassword/forgot_password_screen.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwrodController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Stack(
                children: [
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is ProfessionalLoginSuccessState) {
                        navigateToProfessionalHomePage(
                            context, state.professional);
                      } else if (state is ForgotPasswordState) {
                        navigateToForgotPasswordPage(context);
                      } else if (state is ManagerLoginSuccessState) {
                        naviagetToManagerDashboard(context, state.manager);
                      } else if (state is LoginFailureState) {
                        infoDialogAlert(state.message);
                      } else if (state is MoveToSignUpScreenState) {
                        navigateToSignupScreen(context);
                      } else if (state is UserDetailNotFilledState) {
                        navigateToDetailFillingScreen(state.uid, context);
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginInitialState) {
                        return SingleChildScrollView(child: loginFormUI());
                      } else if (state is LoginLoadingState) {
                        return buildLoadingUi();
                      } else if (state is ProfessionalLoginSuccessState) {
                        return Container();
                      } else if (state is ManagerLoginSuccessState) {
                        return Container();
                      }
                      return SingleChildScrollView(child: loginFormUI());
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginFormUI() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  Text(
                    "Hi, ",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Good Day!",
                    style: TextStyle(
                        fontSize: 42,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10),
              child: Text(
                "Please sign in to continue",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 6.0,
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0))
                ]),
                height: deviceWidth < 365 ? 80 : 80,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, right: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "abc@yourdomain.com",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: deviceWidth < 365 ? 80 : 80,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 6.0,
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0))
                ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, right: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextField(
                          controller: _passwrodController,
                          decoration: InputDecoration(
                            hintText: "******",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FadeAnimation(
                    1.5,
                    GestureDetector(
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceWidth < 400 ? 15 : 20,
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context)
                            .add(ForgotPasswordButtonPressedEvent());
                      },
                    )),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      bool emailValidation =
                          emaillValidator(_emailController.text);

                      String passwordValidation =
                          passwordValidator(_passwrodController.text);
                      if (!emailValidation) {
                        errorDialogAlert("Invalid email");
                      } else if (passwordValidation != null) {
                        errorDialogAlert(passwordValidation);
                      } else {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginButtonPressedEvent(
                                email: _emailController.text,
                                password: _passwrodController.text));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("LOGIN   "),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(MoveToSignUpScreenEvent());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "Sign Up",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void navigateToProfessionalHomePage(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }

  void navigateToForgotPasswordPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ForgotPasswordScreen();
    }));
  }

  void naviagetToManagerDashboard(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(
        manager: manager,
      );
    }));
  }

  void navigateToSignupScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignUpScreen();
    }));
  }

  Widget buildInitialUi() {
    return Container();
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  bool emaillValidator(String email) {
    return EmailValidator.validate(email);
  }

  errorDialogAlert(String message) {
    Alert(
      context: this.context,
      type: AlertType.error,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  infoDialogAlert(String message) {
    Alert(
      context: this.context,
      type: AlertType.info,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  String passwordValidator(String password) {
    if (password == null || password.isEmpty) {
      return "Please write password";
    } else if (password.length < 6) {
      return "Please use a strong password";
    } else
      return null;
  }

  void navigateToDetailFillingScreen(String uid, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CompleteDetailScreen(uid: uid);
    }));
  }
}
