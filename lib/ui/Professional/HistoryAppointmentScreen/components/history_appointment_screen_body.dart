import 'package:appointmentproject/bloc/ProfessionalBloc/HistoryAppointmentBloc/history_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HistoryAppointmentBody extends StatefulWidget {
  @override
  _HistoryAppointmentBodyState createState() => _HistoryAppointmentBodyState();
}

class _HistoryAppointmentBodyState extends State<HistoryAppointmentBody> {
  final dateController = TextEditingController();
  List<String> _status = ["Completed", "Canceled"];
  String _verticalGroupValue = "Completed";

  DateTime selectedDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Professional professional =
                  BlocProvider.of<HistoryAppointmentBloc>(context).professional;
              naviagateToProfessionalDashboard(context, professional);
            },
          ),
        ),
        body: Column(
          children: [
            _searchBar(),
            _radioButton(),
            BlocListener<HistoryAppointmentBloc, HistoryAppointmentState>(
              listener: (context, state) {},
              child:
                  BlocBuilder<HistoryAppointmentBloc, HistoryAppointmentState>(
                      builder: (context, state) {
                if (state is GetHistoryOfCompletedAppointmentState) {
                  return Expanded(
                      child: appointmentsBuilder(
                          context, state.appointmentList, state.customerList));
                } else if (state is HistoryAppointmentLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetHistoryOfCanceledAppointmentState) {
                  return Expanded(
                      child: appointmentsBuilder(
                          context, state.appointmentList, state.customerList));
                }
                return Container();
              }),
            )
          ],
        ));
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "Select Date"),
          controller: dateController,
          readOnly: true,
          onTap: () async {
            final DateTime pickedDate = await showDatePicker(
              context: context,
              initialDate:
                  selectedDateTime == null ? DateTime.now() : selectedDateTime,
              firstDate: DateTime(2019),
              lastDate: DateTime(DateTime.now().year + 5),
            );
            if (pickedDate != null && pickedDate != selectedDateTime)
              setState(() {
                selectedDateTime = pickedDate;
                dateController.text =
                    DateFormat.yMMMMd('en_US').format(selectedDateTime);
                _verticalGroupValue = "Completed";
                BlocProvider.of<HistoryAppointmentBloc>(context).add(
                    GetHistoryOfCompletedAppointmentEvent(
                        dateTime: pickedDate));
              });
          },
        ),
      ),
    );
  }

  _radioButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RadioGroup<String>.builder(
        direction: Axis.horizontal,
        groupValue: _verticalGroupValue,
        onChanged: (value) {
          if (value != _verticalGroupValue) {
            if (selectedDateTime == null) {
              errorDialog("Please select Date First");
            } else {
              if (value == "Completed") {
                setState(() {
                  print("set state clicked");
                  _verticalGroupValue = value;
                  BlocProvider.of<HistoryAppointmentBloc>(context).add(
                      GetHistoryOfCompletedAppointmentEvent(
                          dateTime: selectedDateTime));
                });
              } else {
                setState(() {
                  print("set state clicked canceled");
                  _verticalGroupValue = value;
                  BlocProvider.of<HistoryAppointmentBloc>(context).add(
                      GetHistoryOfCanceledAppointmentEvent(
                          dateTime: selectedDateTime));
                });
              }
            }
          }
        },
        items: _status,
        itemBuilder: (item) => RadioButtonBuilder(
          item,
        ),
      ),
    );
  }

  Widget appointmentUI(
      BuildContext context, Appointment appointment, Customer customer) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(DateFormat.yMMMMd().format(
                          appointment.getAppointmentStartTime().toDate())),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Customer",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(customer.getName()),
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(DateFormat.jm().format(appointment
                                .getAppointmentStartTime()
                                .toDate())),
                            Icon(Icons.arrow_forward),
                            Text(DateFormat.jm().format(
                                appointment.getAppointmentEndTime().toDate())),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Customer contact",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(customer.getPhone()),
                      ])
                ])));
  }

  Widget appointmentsBuilder(BuildContext context,
      List<Appointment> appointments, List<Customer> customers) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appointments.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 7, top: 10, left: 7),
        child: appointmentUI(context, appointments[index], customers[index]),
      ),
    );
  }

  errorDialog(String message) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
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

  void naviagateToProfessionalDashboard(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }
}
