import 'package:appointmentproject/BLoC/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalAddNewCustomerBloc/professional_add_new_customer_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
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
  DateTime selectedDateTime;
  Schedule schedule;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new customer"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            BlocProvider.of<ProfessionalAddNewCustomerBloc>(context).add(MoveBackToSelectCustomerScreenEvent(professional: professional, appointmentTime: selectedDateTime, schedule: schedule));
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
                    moveToAppointmentBookingScreen(state.professional,
                        state.customer, state.selectedDateTime,state.schedule);
                  }else if(state is MoveBackToSelectCustomerScreenState){
                    navigateToSelectCustomerScreen(state.professional,state.schedule,state.appointmentTime,context);
                  }
                },
                child: BlocBuilder<ProfessionalAddNewCustomerBloc,
                    ProfessionalAddNewCustomerState>(
                  builder: (context, state) {
                    if (state is ProfessionalAddNewCustomerInitial) {
                      professional = state.professional;
                      selectedDateTime = state.selectedDateTime;
                      schedule = state.schedule;
                    }
                    return Container();
                  },
                ),
              ),
              Center(
                  child: SizedBox(
                height: deviceHeight * 0.30,
                child: Icon(
                  Icons.person,
                  size: deviceHeight * 0.30,
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
                              labelText: "Enter name",
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
                          height: 20,
                        ),
                        Container(
                          height: deviceWidth < 365 ? 60 : 70,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: "Enter phone",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter phone';
                              } else if (!phoneValidator(value)) {
                                return "Please enter correct phone number";
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
                                        schedule: schedule,selectedDateTime: selectedDateTime));
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

  void moveToAppointmentBookingScreen(Professional professional,
      Customer customer, DateTime selectedDateTime, Schedule schedule) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      print("select professional add customer screen");
      print(selectedDateTime);
      print(schedule.getDuration());
      return AppointmentBookingScreen(
          professional: professional,
          selectedDateTime: selectedDateTime,
          customer: customer,
          schedule: schedule);
    }));
  }

  void navigateToSelectCustomerScreen(Professional professional, Schedule schedule, DateTime appointmentTime, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ProfessionalSelectCustomerScreen(professional: professional, selectedDateTime: appointmentTime, schedule: schedule);
    }));
  }

}
