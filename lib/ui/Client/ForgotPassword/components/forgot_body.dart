import 'package:appointmentproject/bloc/ClientBloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:appointmentproject/ui/Login/login_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotBody extends StatefulWidget {
  @override
  _ForgotBodyState createState() => _ForgotBodyState();
}

class _ForgotBodyState extends State<ForgotBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordEmailSent) {
                      infoDialogAlert(
                          "Password email sent\nPlease also check you spam folder");
                    } else if (state is ForgotPasswordEmailNotSent) {
                      errorDialogAlert(state.message);
                    }
                  },
                  child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                    if (state is ForgotPasswordInitial) {
                      return loginFormUI();
                    }
                    return loginFormUI();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginFormUI() {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Forgot  Password",
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
                    "Don't, ",
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Worry!",
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
                "Please  reset password to continue",
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
              child: Align(
                alignment: Alignment.bottomRight,
                child: FadeAnimation(
                    1.5,
                    GestureDetector(
                      child: Text(
                        "Singn In",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: deviceWidth < 400 ? 15 : 20,
                        ),
                      ),
                      onTap: () {
                        navigateToSignInPage(context);
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
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      bool emailValidation =
                          emaillValidator(_emailController.text);
                      if (!emailValidation) {
                        errorDialogAlert("Invalid email");
                      } else {
                        BlocProvider.of<ForgotPasswordBloc>(context).add(
                            SendPasswordResetLink(
                                email: _emailController.text));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Send reset link",
                        style: TextStyle(fontSize: deviceWidth < 365 ? 15 : 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
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

  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
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
