import 'package:appointmentproject/BLoC/CompleteRegistrationBloc/bloc.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/UserDetails/components/services_dropdown.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/date_picker.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'background.dart';

class Body extends StatelessWidget {

  static String name;
  static String phone;
  static String country;
  static String city;
  static String address;
  static DateTime dob;
  static String need;

  CompleteRegistrationBloc completeRegistrationBloc;
  FirebaseUser user;
  List<Service> services;
  TextEditingController nameController = new TextEditingController();
  Body({@required this.user,@required this.services});

  @override
  Widget build(BuildContext context) {


    completeRegistrationBloc =
        BlocProvider.of<CompleteRegistrationBloc>(context);
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    print("in user details"+ services[0].name);

    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: height * 0.15,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1,
                    Text(
                      "Fill up the details",
                      style: TextStyle(fontFamily:'Raleway',color: Colors.white, fontSize: 35),
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
                                  icon: Icon(Icons.person),
                                  hintText: "name",
                                  onChanged: (value){
                                    name = value;
                                    print(name);
                                  },
                                ),
                                RoundedInputField(
                                  icon: Icon(Icons.phone_android),
                                  hintText: "phone number",
                                  onChanged: (value){
                                    phone = value;
                                    print(phone);
                                  },
                                ),
                                RoundedInputField(
                                  icon: Icon(Icons.location_on),
                                  hintText: "country",
                                  onChanged: (value){
                                    country = value;
                                    print(country);
                                  },
                                ),
                                RoundedInputField(
                                  icon: Icon(Icons.location_city),
                                  hintText: "city",
                                  onChanged: (value){
                                    city = value;
                                    print(city);
                                  },
                                ),
                                RoundedInputField(
                                  icon: Icon(Icons.my_location),
                                  hintText: "address",
                                  onChanged: (value){
                                    address = value;
                                    print(address);
                                  },
                                ),
                                DatePicker(dateTime:DateTime.now()),
                                DropDownServices(services: services),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      RoundedButton(
                        text: "Complete Registration",
                        press: () async {
                           completeRegistration(context);
                        },
                      ),
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


  showAddressValue(String val){
    print("in function "+val);
  }

  showDob(String val){

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

  void completeRegistration(context) {
    need = DropDownServices.selectedNeed;
    dob = DatePicker.selectedDate;

    if(name == null){
      showErrorDialog("please enter your name", context);
      return;
    }
    if(phone == null){
      showErrorDialog("please enter your phone number", context);
      return;
    }
    if(country == null){
      showErrorDialog("please enter your country name", context);
      return;
    }
    if(city == null){
      showErrorDialog("please enter your city name", context);
      return;
    }
    if(address == null){
      showErrorDialog("please enter your address", context);
      return;
    }
    if(dob == null){
      showErrorDialog("please select date of birth", context);
      return;
    }
    if(need == null){
      showErrorDialog("please select your need", context);
      return;
    }

    completeRegistrationBloc.add(
        CompleteRegistrationButtonPressedEvent(
            name: name,
            phone: phone,
            country:country,
            city:city,
            address: address,
            dob: dob,
            user: user,
            need: need));
  }
}
