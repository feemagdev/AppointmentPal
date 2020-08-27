import 'package:appointmentproject/BLoC/CompleteRegistrationBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'background.dart';

class Body extends StatefulWidget {
  final FirebaseUser user;
  final List<Service> services;

  Body({@required this.user, @required this.services});

  _Form createState() => _Form(user: user, services: services);
}

class _Form extends State<Body> {
  CompleteRegistrationBloc completeRegistrationBloc;

  FirebaseUser user;
  List<Service> services;
  List<DropdownMenuItem<Service>> list;
  TextEditingController dobTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  Service selectedNeed;
  DateTime dob;



  _Form({@required this.user, @required this.services});

  @override
  void initState() {
    super.initState();
    list = buildDropDownMenuItems(services);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.height;
    completeRegistrationBloc =
        BlocProvider.of<CompleteRegistrationBloc>(context);

    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<CompleteRegistrationBloc, CompleteRegistrationBlocState>(
            listener: (context, state) {
              if (state is SuccessfulCompleteRegistrationBlocState) {
                navigateToClientDashboard(context, state.user, state.client);
              }
            },
            child: BlocBuilder<CompleteRegistrationBloc,
                CompleteRegistrationBlocState>(builder: (context, state) {
              if (state is InitialCompleteRegistrationBlocState) {
                return Container();
              } else if (state is SuccessfulCompleteRegistrationBlocState) {
                return Container();
              } else if (state is FailureCompleteRegistrationBlocState) {
                return buildFailureUi(state.message);
              }
              return Container();
            }),
          ),
          SizedBox(
            height: deviceHeight * 0.15,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1,
                    Text(
                      "Fill up the details",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 35),
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
                                        color:
                                            Color.fromRGBO(59, 193, 226, 0.7),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: [
                                  textStyleContainer(
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      controller: nameTextController,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          hintText: "Name",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  textStyleContainer(
                                    TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: phoneTextController,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.phone_in_talk),
                                          hintText: "Phone",
                                          hintStyle:
                                          TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  textStyleContainer(
                                    TextField(
                                      controller: countryTextController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.location_on),
                                          hintText: "Country",
                                          hintStyle:
                                          TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onTap: (){
                                        _openCountryPickerDialog();
                                      },
                                    ),
                                  ),
                                  textStyleContainer(
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      controller: cityTextController,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.location_city),
                                          hintText: "City",
                                          hintStyle:
                                          TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  textStyleContainer(
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      controller: addressTextController,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.location_on),
                                          hintText: "Address",
                                          hintStyle:
                                          TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  textStyleContainer(
                                    TextField(
                                      readOnly: true,
                                      controller: dobTextController,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.date_range),
                                          hintText: "Date of birth",
                                          hintStyle:
                                          TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onTap: (){
                                        _selectDate();
                                      },
                                    ),
                                  ),
                                  dropDownNeeds(context),

                                ],
                              ))),
                      SizedBox(
                        height: 40,
                      ),
                      RoundedButton(
                        text: "Complete Registration",
                        color: Color.fromRGBO(56, 178, 227, 1),
                        textColor: Colors.white,
                        fontSize: 12,
                        height: deviceWidth < 400
                            ? deviceHeight * 0.09
                            : deviceHeight * 0.07,
                        width: deviceWidth < 400
                            ? deviceHeight * 0.3
                            : deviceHeight * 0.5,
                        press: () {
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

  Future _selectDate() async {
    DateTime lastDate = DateTime.now();
    Duration duration = Duration(days: 365);
    lastDate.add(duration);
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: dob == null ? DateTime.now() : dob,
      firstDate:  DateTime(1800),
      lastDate:  lastDate,
    );
    if (picked != null) {
      setState(() {
        dob = picked;
        dobTextController.text = picked.toIso8601String();
      });
    }
  }

  Widget dropDownNeeds(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200]))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //        Text("select need"),
            DropdownButtonHideUnderline(
              child: DropdownButton<Service>(
                isExpanded: false,
                hint: Text("select need"),
                value: selectedNeed,
                items: list,
                onChanged: (value) {
                  setState(() {
                    selectedNeed = value;
                  });
                },
              ),
            ),
          ],
        ));
  }

  List<DropdownMenuItem<Service>> buildDropDownMenuItems(
      List<Service> services) {
    List<DropdownMenuItem<Service>> items = List();
    for (Service listItem in services) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.getName()),
          value: listItem,
        ),
      );
    }
    return items;
  }


  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.blue),
        child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.blue,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() {
                  countryTextController.text = country.name;
                }),
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],),
  ));


  void navigateToClientDashboard(
      BuildContext context, FirebaseUser user, Client client) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ClientDashboardScreen(user: user, client: client);
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





  void completeRegistration(context) {
    String nameValidation = nameValidator(nameTextController.text);
    if(nameValidation!=null){
      showErrorDialog(nameValidation, context);
      return;
    }
    String phoneValidation = phoneValidator(phoneTextController.text);
    if(phoneValidation!=null){
      showErrorDialog(phoneValidation, context);
      return;
    }
    String countryValidation = countryValidator(countryTextController.text);
    if(countryValidation!=null){
      showErrorDialog(countryValidation, context);
      return;
    }

    String cityValidation  = cityValidator(cityTextController.text);
    if(cityValidation!=null){
      showErrorDialog(cityValidation, context);
      return;
    }
    String dobValidation = dobValidator(dobTextController.text);
    if(dobValidation!=null){
      showErrorDialog(dobValidation, context);
      return;
    }
    if(selectedNeed == null){
      showErrorDialog("please select your need", context);
      return;
    }
    completeRegistrationBloc.add(CompleteRegistrationButtonPressedEvent(
      name: nameTextController.text,
      phone: phoneTextController.text,
      country: countryTextController.text,
      city: cityTextController.text,
      address: addressTextController.text,
      dob: dob,
      user: user,
      need: selectedNeed,
    ));





  }

   String nameValidator(String name){
    if(nameTextController.text == null || nameTextController.text.isEmpty){
      if(nameTextController.text.length <=2 ){
        return "name length should be more than 3";
      }
      return "please enter name";
    }
    return null;
  }

   String phoneValidator(String phone){
    String pattern = r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";
    RegExp regExp = new RegExp(pattern);
    if (phone.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(phone)) {
      return 'Please enter valid mobile number';
    }
    return null;

  }

  String countryValidator(String country){
    if(country.length == 0){
      return "please select a country";
    }
    return null;
  }

  String cityValidator(String city){
    if(city.length == 0){
      return "please enter city";
    }
    return null;
  }

  String dobValidator(String dob){
    if(dob.length == 0){
      return"please select date of birth";
    }
    return null;
  }


}







Widget textStyleContainer(Widget textField) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]))),
    child: textField,
  );
}
