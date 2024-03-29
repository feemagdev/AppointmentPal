import 'package:appointmentproject/bloc/ProfessionalBloc/AppointmentBookingBloc/appointment_booking_bloc.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppointmentBookingScreenBody extends StatefulWidget {
  @override
  _AppointmentBookingScreenBodyState createState() =>
      _AppointmentBookingScreenBodyState();
}

class _AppointmentBookingScreenBodyState
    extends State<AppointmentBookingScreenBody> {
  @override
  Widget build(BuildContext context) {
    Professional professional =
        BlocProvider.of<AppointmentBookingBloc>(context).professional;
    Manager manager = BlocProvider.of<AppointmentBookingBloc>(context).manager;
    double deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("New Appointment"),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                showAlertDialog(context, professional, manager);
              },
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                BlocListener<AppointmentBookingBloc, AppointmentBookingState>(
                  listener: (context, state) async {
                    if (state is AppointmentBookedSuccessfully) {
                      await showSuccessfulDialog(
                          context,
                          "Appointment booked successfully",
                          professional,
                          manager);
                    } else if (state
                        is AppointmentBookedSuccessfullyWithoutMessage) {
                      errorSmsDialog(state.message);
                    } else if (state
                        is AppointmentBookingScreenSmsServiceNotPurchasesState) {
                      errorSmsDialog(
                          "You have not purchase sms service.\n Go to setting to see packages");
                    }
                  },
                  child: BlocBuilder<AppointmentBookingBloc,
                      AppointmentBookingState>(
                    builder: (context, state) {
                      if (state is AppointmentBookingInitial) {
                        return appointmentBookingUI(
                            state.appointmentStartTime,
                            state.appointmentEndTime,
                            state.customer,
                            professional,
                            deviceWidth);
                      } else if (state is AppointmentBookingLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appointmentBookingUI(
      DateTime appointmentStartTime,
      DateTime appointmentEndTime,
      Customer customer,
      Professional professional,
      double deviceWidth) {
    double fontSize = 12;
    double iconSize = 20;
    if (deviceWidth < 360) {
      fontSize = 17;
      iconSize = 25;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.access_time_outlined,
                    size: iconSize,
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd('en_US').format(appointmentStartTime),
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat.jm().format(appointmentStartTime),
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: iconSize,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        DateFormat.jm().format(appointmentEndTime),
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Divider(),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person_outline,
                    size: iconSize,
                  )),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.getName()),
                  Text(customer.getPhone()),
                ],
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Divider(),
          SizedBox(
            height: 2,
          ),
          Center(
            child: RaisedButton(
              child: Text("Add Appointment"),
              onPressed: () {
                smsInfoDialog(
                    "Do you want to send SMS to your customer ?",
                    professional,
                    customer,
                    appointmentStartTime,
                    appointmentEndTime);

                print("Appointment added");
              },
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(
      BuildContext context, Professional professional, Manager manager) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Cancel Appointment"),
            content: Text("Quit without booking appointment ?"),
            actions: [
              Row(
                children: [
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (manager == null) {
                        navigateToDashboardScreen(context, professional);
                      } else {
                        navigateToManagerDashboardScreen(context, manager);
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () => {Navigator.of(context).pop()},
                  ),
                ],
              )
            ],
          );
        });
  }

  showSuccessfulDialog(BuildContext context, String message,
      Professional professional, Manager manager) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(
              message,
              style: TextStyle(color: Colors.green),
            ),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }).then((value) {
      if (manager == null) {
        navigateToDashboardScreen(context, professional);
      } else {
        navigateToManagerDashboardScreen(context, manager);
      }
    });
  }

  smsInfoDialog(String message, Professional professional, Customer customer,
      DateTime appointmentStartTime, DateTime appointmentEndTime) async {
    await Alert(
      context: context,
      type: AlertType.info,
      title: "SMS Alert",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<AppointmentBookingBloc>(context).add(
                AddAppointmentButtonPressedEvent(
                    professional: professional,
                    customer: customer,
                    appointmentStartTime: appointmentStartTime,
                    appointmentEndTime: appointmentEndTime,
                    smsCheck: true));
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<AppointmentBookingBloc>(context).add(
                AddAppointmentButtonPressedEvent(
                    professional: professional,
                    customer: customer,
                    appointmentStartTime: appointmentStartTime,
                    appointmentEndTime: appointmentEndTime,
                    smsCheck: false));
          },
          width: 120,
        )
      ],
    ).show();
  }

  errorSmsDialog(String message) async {
    await Alert(
      context: context,
      type: AlertType.info,
      title: "SMS Not Sent",
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
        ),
      ],
    ).show();
  }

  void navigateToDashboardScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }

  void navigateToManagerDashboardScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(
        manager: manager,
      );
    }));
  }
}
