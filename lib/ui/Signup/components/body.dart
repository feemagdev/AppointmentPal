import 'package:appointmentproject/BLoC/SignUpBloc/bloc.dart';
import 'package:appointmentproject/BLoC/SignUpBloc/sign_up_bloc.dart';
import 'package:appointmentproject/ui/Login/login_screen.dart';
import 'package:appointmentproject/ui/Signup/components/social_icon.dart';
import 'package:appointmentproject/ui/UserDetails/user_detail_screen.dart';
import 'package:appointmentproject/ui/components/already_have_an_account_acheck.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:appointmentproject/ui/components/rounded_password_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../professional_home_page.dart';
import 'background.dart';
import 'or_divider.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  String email;
  String password;
  SignUpBloc signUpBloc;



  @override
  Widget build(BuildContext context) {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () async {
                if (!EmailValidator.validate(email)) {
                  String message = "invalid email";
                  showErrorDialog(message, context);
                  return;
                }
                if (password.length <= 5) {
                  String message = "please use a strong password";
                  showErrorDialog(message, context);
                  return;
                }
                signUpBloc.add(
                    SignUpButtonPressedEvent(email: email, password: password));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () async {
                navigateToLoginPage(context);
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
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
