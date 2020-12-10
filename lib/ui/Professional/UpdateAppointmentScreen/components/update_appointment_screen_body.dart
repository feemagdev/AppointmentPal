import 'package:appointmentproject/bloc/ProfessionalBloc/UpdateAppointmentBloc/update_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditAppointmentScreen/professional_edit_appointment_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/professional_select_customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateAppointmentScreenBody extends StatefulWidget {
  @override
  _UpdateAppointmentScreenBodyState createState() =>
      _UpdateAppointmentScreenBodyState();
}

class _UpdateAppointmentScreenBodyState
    extends State<UpdateAppointmentScreenBody> {
  bool cancelCheck = false;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final Professional _professional =
        BlocProvider.of<UpdateAppointmentBloc>(context).professional;
    final Appointment _appointment =
        BlocProvider.of<UpdateAppointmentBloc>(context).appointment;
    final Customer _customer =
        BlocProvider.of<UpdateAppointmentBloc>(context).customer;
    final Manager _manager =
        BlocProvider.of<UpdateAppointmentBloc>(context).manager;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Update Appointment"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<UpdateAppointmentBloc>(context)
                    .add(MoveToEditAppointmentScreenEvent());
              },
            ),
          ),
          body: Container(
            child: Column(
              children: [
                BlocListener<UpdateAppointmentBloc, UpdateAppointmentState>(
                  listener: (context, state) {
                    if (state is UpdateAppointmentDateTimeState) {
                      moveToSelectDateTimeScreen(context, _professional,
                          _appointment, _customer, _manager);
                    } else if (state is MoveToEditAppointmentScreenState) {
                      moveToEditAppointmentScreen(
                          context, _professional, _manager);
                    } else if (state is UpdateAppointmentSelectCustomerState) {
                      navigateToSelectCustomerScreen(context, _professional,
                          _appointment, _customer, _manager);
                    } else if (state is AppointmentUpdatedSuccessfullyState) {
                      showSuccessfulDialog(
                          context,
                          "Appointment Updated Successfully",
                          _professional,
                          _manager);
                    } else if (state
                        is UpdateAppointmentSuccessfullyWithoutMessage) {
                      errorSmsDialog(state.message);
                    } else if (state
                        is UpdateAppointmentScreenSmsServiceNotPurchasesState) {
                      errorSmsDialog(
                          "You have not purchase sms service.\n Go to setting to see packages");
                    } else if (state is AppointmentCancelledSuccessfullyState) {
                      showSuccessfulDialog(
                          context,
                          "Appointment Canceled Successfully",
                          _professional,
                          _manager);
                    }
                  },
                  child: BlocBuilder<UpdateAppointmentBloc,
                      UpdateAppointmentState>(
                    builder: (context, state) {
                      if (state is UpdateAppointmentInitial) {
                        return appointmentBookingUI(_appointment, _customer,
                            _professional, deviceWidth);
                      } else if (state is UpdateAppointmentLoadingState) {
                        return loadingCircularProgressIndicator();
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

  Widget appointmentBookingUI(Appointment appointment, Customer customer,
      Professional professional, double deviceWidth) {
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
          InkWell(
            onTap: () {
              BlocProvider.of<UpdateAppointmentBloc>(context)
                  .add(UpdateAppointmentDateTimeEvent());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                          DateFormat.yMMMMd('en_US').format(
                              appointment.getAppointmentStartTime().toDate()),
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat.jm().format(appointment
                                  .getAppointmentStartTime()
                                  .toDate()),
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
                              DateFormat.jm().format(
                                  appointment.getAppointmentEndTime().toDate()),
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
                Row(
                  children: [Icon(Icons.edit)],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Divider(),
          SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<UpdateAppointmentBloc>(context)
                  .add(UpdateAppointmentSelectCustomerEvent());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Row(
                  children: [Icon(Icons.edit)],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Divider(),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text("Update Appointment"),
                onPressed: () {
                  cancelCheck = false;
                  smsInfoDialog("Do you want to send SMS to your customer ?",
                      appointment);
                },
              ),
              RaisedButton(
                child: Text("Cancel Appointment"),
                onPressed: () {
                  cancelCheck = true;
                  smsInfoDialog("Do you want to send SMS to your customer ?",
                      appointment);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void moveToSelectDateTimeScreen(
      BuildContext context,
      Professional professional,
      Appointment appointment,
      Customer customer,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(
        professional: professional,
        appointment: appointment,
        customer: customer,
        manager: manager,
      );
    }));
  }

  void moveToEditAppointmentScreen(
      BuildContext context, Professional professional, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalEditAppointmentScreen(
        professional: professional,
        manager: manager,
      );
    }));
  }

  void navigateToSelectCustomerScreen(
      BuildContext context,
      Professional professional,
      Appointment appointment,
      Customer customer,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectCustomerScreen(
        professional: professional,
        appointmentStartTime: appointment.getAppointmentStartTime().toDate(),
        appointmentEndTime: appointment.getAppointmentEndTime().toDate(),
        appointment: appointment,
        customer: customer,
        manager: manager,
      );
    }));
  }

  void navigateToDashboard(BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }

  Widget loadingCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void navigateToManagerDashboard(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(manager: manager);
    }));
  }

  smsInfoDialog(String message, Appointment appointment) async {
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
            if (cancelCheck) {
              BlocProvider.of<UpdateAppointmentBloc>(context).add(
                  CancelAppointmentEvent(
                      appointment: appointment, smsCheck: true));
            } else {
              BlocProvider.of<UpdateAppointmentBloc>(context).add(
                  UpdateAppointmentButtonPressedEvent(
                      appointment: appointment, smsCheck: true));
            }
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
            if (cancelCheck) {
              BlocProvider.of<UpdateAppointmentBloc>(context).add(
                  CancelAppointmentEvent(
                      appointment: appointment, smsCheck: false));
            } else {
              BlocProvider.of<UpdateAppointmentBloc>(context).add(
                  UpdateAppointmentButtonPressedEvent(
                      appointment: appointment, smsCheck: false));
            }
          },
          width: 120,
        )
      ],
    ).show();
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
        navigateToDashboard(context, professional);
      } else {
        navigateToManagerDashboard(context, manager);
      }
    });
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
}
