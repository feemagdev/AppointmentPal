import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalAddNewCustomerBloc/professional_add_new_customer_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AppointmentBookingScreen/appointment_booking_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/professional_select_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalAddNewCustomerBody extends StatefulWidget {
  @override
  _ProfessionalAddNewCustomerBodyState createState() =>
      _ProfessionalAddNewCustomerBodyState();
}

class _ProfessionalAddNewCustomerBodyState
    extends State<ProfessionalAddNewCustomerBody> {
  final _formKey = GlobalKey<FormState>();
  Professional professional;
  DateTime appointmentStartTime;
  DateTime appointmentEndTime;

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    bool customerAlreadyExist = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add new customer"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<ProfessionalAddNewCustomerBloc>(context).add(
                MoveBackToSelectCustomerScreenEvent(
                    professional: professional,
                    appointmentEndTime: appointmentEndTime,
                    appointmentStartTime: appointmentStartTime));
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<ProfessionalAddNewCustomerBloc,
                  ProfessionalAddNewCustomerState>(
                listener: (context, state) {
                  if (state is CustomerAddedSuccessfullyState) {
                    moveToAppointmentBookingScreen(
                        state.professional,
                        state.customer,
                        state.appointmentStartTime,
                        state.appointmentEndTime);
                  } else if (state is MoveBackToSelectCustomerScreenState) {
                    navigateToSelectCustomerScreen(
                        state.professional,
                        state.appointmentEndTime,
                        state.appointmentStartTime,
                        context);
                  }
                },
                child: BlocBuilder<ProfessionalAddNewCustomerBloc,
                    ProfessionalAddNewCustomerState>(
                  builder: (context, state) {
                    if (state is ProfessionalAddNewCustomerInitial) {
                      professional = state.professional;
                      appointmentStartTime = state.appointmentStartTime;
                      appointmentEndTime = state.appointmentEndTime;
                      return Container();
                    } else if (state is CustomerAlreadyExistState) {
                      customerAlreadyExist = true;
                    }else if(state is CustomerCanBeAdded){
                      customerAlreadyExist = false;
                    }
                    return Container();
                  },
                ),
              ),
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
                        Container(
                          height: deviceWidth < 365 ? 60 : 70,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: "Phone",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter phone';
                              } else if (!phoneValidator(value)) {
                                return "Please enter correct phone number";
                              }
                              BlocProvider.of<ProfessionalAddNewCustomerBloc>(
                                      context)
                                  .add(CheckPhoneEvent(
                                      professional: professional,
                                      phone: value));
                              if (customerAlreadyExist) {
                                return "phone already exist";
                              }
                              return null;
                            },
                          ),
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
                                    .add(AddNewCustomerButtonPressedEvent(
                                        professional: professional,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        address: addressController.text,
                                        city: cityController.text,
                                        country: countryController.text,
                                        appointmentStartTime:
                                            appointmentStartTime,
                                        appointmentEndTime:
                                            appointmentEndTime));
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
        ),
      ),
    );
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

  void moveToAppointmentBookingScreen(
      Professional professional,
      Customer customer,
      DateTime appointmentStartTime,
      DateTime appointmentEndTime) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AppointmentBookingScreen(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          customer: customer,
          appointmentEndTime: appointmentEndTime);
    }));
  }

  void navigateToSelectCustomerScreen(
      Professional professional,
      DateTime appointmentEndTime,
      DateTime appointmentStartTime,
      BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectCustomerScreen(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime);
    }));
  }
}
