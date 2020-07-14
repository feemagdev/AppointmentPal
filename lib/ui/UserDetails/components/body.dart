import 'package:appointmentproject/BLoC/CompleteRegistrationBloc/bloc.dart';
import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta/meta.dart';

import '../../client_home_page.dart';
import 'background.dart';

class Body extends StatelessWidget {
  String name;
  String address;
  String phone;
  CompleteRegistrationBloc completeRegistrationBloc;
  FirebaseUser user;

  Body({@required this.user});

  @override
  Widget build(BuildContext context) {
    completeRegistrationBloc =
        BlocProvider.of<CompleteRegistrationBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocListener<CompleteRegistrationBloc,
                CompleteRegistrationBlocState>(
              listener: (context, state) {
                if (state is SuccessfulCompleteRegistrationBlocState) {
                  navigateToClientDashboard(context, state.user);
                }
              },
              child: BlocBuilder<CompleteRegistrationBloc,
                      CompleteRegistrationBlocState>(
                  // ignore: missing_return
                  builder: (context, state) {
                if (state is InitialCompleteRegistrationBlocState) {
                  return Container();
                } else if (state is SuccessfulCompleteRegistrationBlocState) {
                  return Container();
                } else if (state is FailureCompleteRegistrationBlocState) {
                  return buildFailureUi(state.message);
                }
              }),
            ),
            Text(
              "Fill the details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.20,
            ),
            RoundedInputField(
              icon: Icon(Icons.person),
              hintText: "Name",
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              hintText: "Address",
              icon: Icon(Icons.location_city),
              onChanged: (value) {
                address = value;
              },
            ),
            RoundedInputField(
              hintText: "phone",
              icon: Icon(Icons.phone),
              onChanged: (value) {
                phone = value;
              },
            ),
            RoundedButton(
              text: "Complete Registration",
              press: () async {
                completeRegistrationBloc.add(
                    CompleteRegistrationButtonPressedEvent(
                        name: name, address: address, phone: phone,user:user));
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  void navigateToClientDashboard(BuildContext context, FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ClientDashboardScreen(user: user);
    }));
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
