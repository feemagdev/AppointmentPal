import 'package:appointmentproject/bloc/SignupBloc/signup_bloc.dart';
import 'package:appointmentproject/ui/Client/CompleteDetails/complete_detail_screen.dart';
import 'package:appointmentproject/ui/Login/login_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupBody extends StatefulWidget {
  @override
  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwrodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessfulState) {
                      naviagteToCompleteDetailScreen(state.user.uid, context);
                    } else if (state is SignUpFailureState) {
                      errorDialogAlert(state.message);
                    }
                  },
                  child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                    if (state is SignupInitial) {
                      return SingleChildScrollView(
                        child: loginFormUI(),
                      );
                    } else if (state is SignUpLoadingState) {
                      return CircularProgressIndicator();
                    }
                    return SingleChildScrollView(
                      child: loginFormUI(),
                    );
                  }),
                )
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Sign Up",
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
                    "Welcome!",
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
                "Please sign up to continue",
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
                        "SIGN IN",
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
                        BlocProvider.of<SignupBloc>(context).add(
                            SignUpButtonEvent(
                                email: _emailController.text,
                                password: _passwrodController.text));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("SIGN UP "),
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

  String passwordValidator(String password) {
    if (password == null || password.isEmpty) {
      return "Please write password";
    } else if (password.length < 6) {
      return "Please use a strong password";
    } else
      return null;
  }

  void naviagteToCompleteDetailScreen(String uid, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CompleteDetailScreen(uid: uid);
    }));
  }

  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
}
