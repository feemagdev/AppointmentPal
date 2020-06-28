import 'package:appointmentproject/BLoC/loginBloc/login_bloc.dart';
import 'package:appointmentproject/BLoC/loginBloc/login_event.dart';
import 'package:appointmentproject/BLoC/loginBloc/login_state.dart';
import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:appointmentproject/ui/components/already_have_an_account_acheck.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:appointmentproject/ui/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../client_home_page.dart';
import '../../professional_home_page.dart';
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value){email = value;},
            ),
            RoundedPasswordField(
              onChanged: (value){password = value;},
            ),
            BlocListener<LoginBloc,LoginState>(
              // ignore: missing_return
              listener: (context,state){
                if(state is ClientLoginSuccessState){
                  print("login body client login");
                  navigateToClientHomePage(context, state.getUser);
                }
                else if(state is ProfessionalLoginSuccessState){
                  print("login body professional login");
                  print(state.user.email);
                  navigateToProfessionalHomePage(context, state.getUser);
                }
              },
              child: BlocBuilder<LoginBloc,LoginState>(
                // ignore: missing_return
                  builder: (context,state){
                    if(state is LoginInitialState){
                      return buildInitialUi();
                    }else if(state is LoginLoadingState){
                      return buildLoadingUi();
                    } else if(state is ProfessionalLoginSuccessState){
                      return Container();
                    }else if(state is ClientLoginSuccessState){
                      return Container();
                    }else if(state is LoginFailureState){
                      return buildFailureUi(state.message);
                    }
                  }
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press :  () async {
                loginBloc.add(LoginButtonPressed(
                  email: email,
                  password: password,
                ));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInitialUi(){
    return Container();
  }

  Widget buildLoadingUi(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildFailureUi(String message){
    return Text(
      message,
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }

  void navigateToHomePage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ClientHomePageParent();
    }));
  }

  void navigateToSignUpPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SignUpScreen();
    }));
  }

  void navigateToProfessionalHomePage(BuildContext context, FirebaseUser user){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ProfessionalHomePageParent(user: user);
    }));
  }

  void navigateToClientHomePage(BuildContext context,FirebaseUser user){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ClientDashboardScreen(user: user);
    }));
  }
}
