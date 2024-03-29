import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalAddNewCustomerBloc/professional_add_new_customer_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AppointmentBookingScreen/appointment_booking_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/professional_select_customer_screen.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:appointmentproject/ui/Professional/UpdateAppointmentScreen/update_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfessionalAddNewCustomerBody extends StatefulWidget {
  @override
  _ProfessionalAddNewCustomerBodyState createState() =>
      _ProfessionalAddNewCustomerBodyState();
}

class _ProfessionalAddNewCustomerBodyState
    extends State<ProfessionalAddNewCustomerBody> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  double deviceWidth;
  double deviceHeight;
  Manager manager;
  Professional professional;
  DateTime appointmentEndTime;
  DateTime appointmentStartTime;
  Appointment appointment;
  Customer customer;

  bool customerAlreadyExist = false;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    manager = BlocProvider.of<ProfessionalAddNewCustomerBloc>(context).manager;
    professional =
        BlocProvider.of<ProfessionalAddNewCustomerBloc>(context).professional;
    appointmentEndTime =
        BlocProvider.of<ProfessionalAddNewCustomerBloc>(context)
            .appointmentEndTime;
    appointmentStartTime =
        BlocProvider.of<ProfessionalAddNewCustomerBloc>(context)
            .appointmentStartTime;
    appointment =
        BlocProvider.of<ProfessionalAddNewCustomerBloc>(context).appointment;
    customer =
        BlocProvider.of<ProfessionalAddNewCustomerBloc>(context).customer;

    customerAlreadyExist = false;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add new customer"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (appointment == null) {
                  if (appointmentStartTime == null) {
                    navigateToProfessionalSettingScreen(context, professional);
                  } else {
                    navigateToSelectCustomerScreen(
                        professional,
                        appointmentEndTime,
                        appointmentStartTime,
                        context,
                        appointment,
                        customer,
                        manager);
                  }
                }
              },
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                BlocListener<ProfessionalAddNewCustomerBloc,
                    ProfessionalAddNewCustomerState>(
                  listener: (context, state) {
                    if (state is CustomerAddedSuccessfullyState) {
                      successDialog(state.customer);
                    } else if (state is CustomerAlreadyExistState) {
                      customerAlreadyExist = true;
                      infoDialog("Phone Number Already Exist");
                    }
                  },
                  child: BlocBuilder<ProfessionalAddNewCustomerBloc,
                      ProfessionalAddNewCustomerState>(
                    builder: (context, state) {
                      if (state is ProfessionalAddNewCustomerInitial) {
                        return addNewCustomerUI();
                      } else if (state is CustomerAlreadyExistState) {
                        return addNewCustomerUI();
                      } else if (state is CustomerCanBeAdded) {
                        customerAlreadyExist = false;
                        print("customer can be added");
                        BlocProvider.of<ProfessionalAddNewCustomerBloc>(context)
                            .add(AddNewCustomerButtonPressedEvent(
                                professional: professional,
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                city: cityController.text,
                                country: countryController.text,
                                appointmentStartTime: appointmentStartTime,
                                appointmentEndTime: appointmentEndTime));
                        return Container();
                      } else if (state is AddNewCustomerLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addNewCustomerUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: SizedBox(
            height: deviceHeight * 0.20,
            child: Icon(
              Icons.person,
              size: deviceHeight * 0.20,
              color: Colors.blue,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: deviceWidth < 365 ? 60 : 70,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter name';
                          } else if (value.length <= 2) {
                            return "Name should be greater than 2 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: deviceWidth < 365 ? 60 : 70,
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter phone';
                          } else if (!phoneValidator(value)) {
                            return "Please enter correct phone number";
                          }
                          if (customerAlreadyExist) {
                            return "phone already exist";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: deviceWidth < 365 ? 60 : 70,
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter address';
                          } else if (value.length < 5) {
                            return "Please enter correct address";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: deviceWidth < 365 ? 60 : 70,
                      child: TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                          labelText: "City",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter city name';
                          } else if (value.length < 3) {
                            return "Please enter correct city name";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: deviceWidth < 365 ? 60 : 70,
                      child: TextFormField(
                        controller: countryController,
                        decoration: InputDecoration(
                          labelText: "Country",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter city name';
                          } else if (value.length < 3) {
                            return "Please enter correct country name";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: deviceWidth * 0.50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print("validated");
                            BlocProvider.of<ProfessionalAddNewCustomerBloc>(
                                    context)
                                .add(CheckPhoneEvent(
                                    professional: professional,
                                    phone: phoneController.text));
                          }
                        },
                        child: Text('Add new customer'),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  bool phoneValidator(String phone) {
    String pattern =
        r"^\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(phone)) {
      return true;
    }
    return false;
  }

  void moveToAppointmentBookingScreen(
      Professional professional,
      Customer customer,
      DateTime appointmentStartTime,
      DateTime appointmentEndTime,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AppointmentBookingScreen(
        professional: professional,
        appointmentStartTime: appointmentStartTime,
        customer: customer,
        appointmentEndTime: appointmentEndTime,
        manager: manager,
      );
    }));
  }

  void navigateToSelectCustomerScreen(
      Professional professional,
      DateTime appointmentEndTime,
      DateTime appointmentStartTime,
      BuildContext context,
      Appointment appointment,
      Customer customer,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectCustomerScreen(
        professional: professional,
        appointmentStartTime: appointmentStartTime,
        appointmentEndTime: appointmentEndTime,
        appointment: appointment,
        customer: customer,
        manager: manager,
      );
    }));
  }

  void moveToUpdateAppointmentScreen(BuildContext context, Customer customer,
      Professional professional, Appointment appointment, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UpdateAppointmentScreen(
        professional: professional,
        appointment: appointment,
        customer: customer,
        manager: manager,
      );
    }));
  }

  void navigateToProfessionalDashboard(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }

  void navigateToProfessionalSettingScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen(professional: professional);
    }));
  }

  infoDialog(String message) {
    Alert(
      context: context,
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
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  successDialog(Customer customer) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Customer Added Successfully",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            if (appointment == null) {
              if (appointmentStartTime == null) {
                navigateToProfessionalDashboard(context, professional);
              } else {
                moveToAppointmentBookingScreen(professional, customer,
                    appointmentStartTime, appointmentEndTime, manager);
              }
            } else {
              moveToUpdateAppointmentScreen(
                  context, customer, professional, appointment, manager);
            }
          },
          width: 120,
        )
      ],
    ).show();
  }
}
