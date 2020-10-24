

import 'package:appointmentproject/bloc/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/ui/Client/ClientDashboard/client_dashboard_screen.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class Body extends StatelessWidget {
  final Client client;
  final Service service;
  final SubServices subServices;
  final FirebaseUser user;

  Body(
      {@required this.client,
      @required this.service,
      @required this.subServices,
      @required this.user});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    Professional professional;
    Schedule schedule;
    List<DateTime> timeSlots;
    int selectedIndex;
    String name;
    String phone;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "Select date",
              style: TextStyle(fontSize: deviceWidth < 400 ? 12 : 20),
            ),
            SizedBox(height: 20),
            CustomDateView(
              onTap: (DateTime dateTime) {
                BlocProvider.of<SelectDateTimeBloc>(context).add(
                    ShowAvailableTimeEvent(
                        professional: professional, dateTime: dateTime));
              },
            ),
            BlocListener<SelectDateTimeBloc, SelectDateTimeState>(
              listener: (context, state) {
                if (state is AppointmentIsBookedState) {
                  showSuccessfulDialog(context);
                }
              },
              child: BlocBuilder<SelectDateTimeBloc, SelectDateTimeState>(
                builder: (context, state) {
                  if (state is SelectDateTimeInitial) {
                    professional = state.professional;
                    return loadingState(context, state.professional);
                  } else if (state is ShowAvailableTimeState) {
                    professional = state.professional;
                    schedule = state.schedule;
                    timeSlots = state.timeSlots;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Select time",
                        style: TextStyle(fontSize: deviceWidth < 400 ?10:15),
                      ),
                    );
                  } else if (state is TimeSlotSelectedState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Select time",
                        style: TextStyle(fontSize: deviceWidth < 400 ?10:15),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            BlocBuilder<SelectDateTimeBloc, SelectDateTimeState>(
              builder: (context, state) {
                if (state is ShowAvailableTimeState) {
                  return timeSlotBuilder(context, state.timeSlots, null,
                      state.professional, state.schedule);
                } else if (state is NoScheduleAvailable) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "sorry no schedule available for this date",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: deviceWidth < 400 ?10:15,
                      ),
                    ),
                  );
                } else if (state is TimeSlotSelectedState) {
                  selectedIndex = state.selectedIndex;
                  timeSlots = state.timeSlots;
                  schedule = state.schedule;
                  return timeSlotBuilder(
                      context,
                      state.timeSlots,
                      state.selectedIndex,
                      state.professional,
                      state.schedule);
                }
                return Container();
              },
            ),
            Column(
              children: [
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter Name",
                      style: TextStyle(
                        fontSize: deviceWidth < 400 ?10:15
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: deviceWidth < 400 ? 50:70,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Name",
                            enabledBorder: OutlineInputBorder()),
                        onChanged: (text) {
                          name = text;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("Enter your phone number",
                        style: TextStyle(
                        fontSize: deviceWidth < 400 ?10:15
                    ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: deviceWidth < 400 ? 50:70,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Phone",
                            enabledBorder: OutlineInputBorder()),
                        onChanged: (text) {
                          phone = text;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                RoundedButton(
                  text: "Book appointment",
                  width: deviceWidth < 400 ? 200:300,
                  height: deviceWidth < 400 ? 40:55,
                  fontSize: deviceWidth < 400 ? 10:20,
                  color: Colors.blue,
                  textColor: Colors.white,
                  press: () {
                    if (name == null || name.isEmpty) {
                      showErrorDialog("please enter name", context);
                      return;
                    }
                    if (name.length <= 2) {
                      showErrorDialog(
                          "name length should be more than 2", context);
                      return;
                    }

                    String phoneValidation = phoneValidator(phone);
                    if(phoneValidation!=null){
                      showErrorDialog(phoneValidation, context);
                      return;
                    }
                    if(selectedIndex == null){
                      showErrorDialog("please select a time", context);
                      return;
                    }



                    BlocProvider.of<SelectDateTimeBloc>(context).add(
                        AppointmentIsBookedEvent(
                            professional: professional,
                            client: client,
                            service: service,
                            subServices: subServices,
                            dateTime: timeSlots[selectedIndex],
                            user: user,
                            name: name,
                            phone: phone));


                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingState(BuildContext context, Professional professional) {
    BlocProvider.of<SelectDateTimeBloc>(context).add(
        ShowAvailableTimeEvent(professional: professional, dateTime: null));
    return Container();
  }

  Widget timeSlotsUI(
      DateTime time,
      Color color,
      BuildContext context,
      int selectedIndex,
      Professional professional,
      List<DateTime> timeSlots,
      Schedule schedule) {
    return InkWell(
      onTap: () {
        BlocProvider.of<SelectDateTimeBloc>(context).add(TimeSlotSelectedEvent(
            professional: professional,
            scheduleIndex: selectedIndex,
            schedules: timeSlots,
            schedule: schedule));
      },
      child: Container(
        width: 72,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(DateFormat.jm().format(time))),
      ),
    );
  }

  Widget timeSlotBuilder(BuildContext context, List<DateTime> timeSlots,
      int selectedIndex, Professional professional, Schedule schedule) {
    return Container(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: timeSlots.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 7, top: 10),
          child: timeSlotsUI(
              timeSlots[index],
              selectedIndex == index ? Colors.blue : Colors.white,
              context,
              index,
              professional,
              timeSlots,
              schedule),
        ),
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
                onPressed: () => {Navigator.of(context).pop()},
              )
            ],
          );
        });
  }

  showSuccessfulDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(
              "your appointment booked successfully",
              style: TextStyle(color: Colors.green),
            ),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: () => {Navigator.of(context).pop(),
                  navigateToDashboardScreen(context)},
              )
            ],
          );
        });
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ClientDashboardScreen(
        client: client,
        user: user,
      );
    }));
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


}



