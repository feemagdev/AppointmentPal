import 'package:appointmentproject/bloc/CompleteDetailBloc/complete_detail_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CompleteDetailBody extends StatefulWidget {
  @override
  _CompleteDetailBodyState createState() => _CompleteDetailBodyState();
}

class _CompleteDetailBodyState extends State<CompleteDetailBody> {
  final _professionalFormKey = GlobalKey<FormState>();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  List<String> _status = ["Professional", "Manager"];
  String _verticalGroupValue = "Professional";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        body: Stack(
          children: [
            BlocListener<CompleteDetailBloc, CompleteDetailState>(
              listener: (context, state) {
                if (state is ProfessionalRegisrteredSuccessfullyState) {
                  navigateToProfessionalDashboard(state.professional, context);
                } else if (state is ManagerRegisrteredSuccessfullyState) {
                  navigateToManagerDashboard(state.manager, context);
                } else if (state is RegistrationFailedState) {
                  errorDialogAlert("Registration Failed please try again");
                }
              },
              child: BlocBuilder<CompleteDetailBloc, CompleteDetailState>(
                builder: (context, state) {
                  if (state is CompleteRegistrationLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CompleteDetailInitial) {
                    return SingleChildScrollView(child: professionalFormUI());
                  } else if (state is ManagerRegisrteredSuccessfullyState) {
                    return Container();
                  }
                  return SingleChildScrollView(child: professionalFormUI());
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget professionalFormUI() {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Form(
        key: _professionalFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 10),
              child: Text(
                "Complete Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            _radioButton(),
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
                        "Full Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "John Doe",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.name,
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
                        "Phone",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: "xxxxxxxxxxx",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
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
                        "Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: "street 123 house",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),
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
                        "City",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: "Lahore",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                        ),
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
                        "Country",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: TextField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            hintText: "Pakistan",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 220,
                  child: ElevatedButton(
                    onPressed: () {
                      String nameValidation =
                          nameValidator(_nameController.text);
                      String addressValidation =
                          addressValidator(_addressController.text);
                      String cityValidation =
                          cityValidator(_cityController.text);
                      String countryValidation =
                          countryValidator(_countryController.text);
                      bool phoneValidation =
                          phoneValidator(_phoneController.text);

                      if (nameValidation != null) {
                        errorDialogAlert(nameValidation);
                      } else if (addressValidation != null) {
                        errorDialogAlert(addressValidation);
                      } else if (cityValidation != null) {
                        errorDialogAlert(cityValidation);
                      } else if (countryValidation != null) {
                        errorDialogAlert(countryValidation);
                      } else if (!phoneValidation) {
                        errorDialogAlert("Please enter correct phone number");
                      } else {
                        BlocProvider.of<CompleteDetailBloc>(context).add(
                            CompleteRegistrationButtonEvent(
                                name: _nameController.text,
                                phone: _phoneController.text,
                                address: _addressController.text,
                                city: _cityController.text,
                                country: _countryController.text,
                                type: _verticalGroupValue));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Complete Registraion "),
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

  _radioButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RadioGroup<String>.builder(
        direction: Axis.horizontal,
        groupValue: _verticalGroupValue,
        onChanged: (value) {
          if (value != _verticalGroupValue) {
            setState(() {
              _verticalGroupValue = value;
              print(_verticalGroupValue);
            });
          }
        },
        items: _status,
        itemBuilder: (item) => RadioButtonBuilder(
          item,
        ),
      ),
    );
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

  String nameValidator(String text) {
    if (text == null || text == "") {
      return "Please enter name";
    } else if (text.length < 2) {
      return "Name charcaters should be more than 2";
    } else
      return null;
  }

  String addressValidator(String text) {
    if (text == null || text == "") {
      return "Please enter address";
    } else if (text.length < 5) {
      return "Address charcaters should be more than 5";
    } else
      return null;
  }

  String cityValidator(String text) {
    if (text == null || text == "") {
      return "Please enter City name";
    } else if (text.length < 2) {
      return "City charcaters should be more than 2";
    } else
      return null;
  }

  String countryValidator(String text) {
    if (text == null || text == "") {
      return "Please enter Country name";
    } else if (text.length < 2) {
      return "Country charcaters should be more than 2";
    } else
      return null;
  }

  bool phoneValidator(String phone) {
    String pattern =
        r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(phone)) {
      return true;
    }
    return false;
  }

  void navigateToProfessionalDashboard(
      Professional professional, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }

  void navigateToManagerDashboard(Manager manager, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(manager: manager);
    }));
  }
}
