import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/BLoC/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';



class ProfessionalSelectDateTime extends StatelessWidget {
  final Professional professional;
  final Appointment appointment;

  ProfessionalSelectDateTime({@required this.professional, this.appointment});
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    Professional professional;
    String name;
    String phone;
    List<DateTime> timeSlots;
    Schedule schedule;
    int selectedIndex;
    TextEditingController nameTextController = new TextEditingController();
    TextEditingController phoneTextController = new TextEditingController();

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
                style: TextStyle(fontSize: deviceWidth < 360 ? 12 : 20),
              ),
              SizedBox(height: 15),
              CustomDateView(
                onTap: (DateTime dateTime) {
                  BlocProvider.of<SelectDateTimeBloc>(context).add(
                      ShowAvailableTimeEvent(
                          professional: professional, dateTime: dateTime,name:name,phone:phone));
                },
              ),
              BlocListener<SelectDateTimeBloc, SelectDateTimeState>(
                listener: (context, state) {
                  if (state is ProfessionalAppointmentIsBookedState) {
                    String message = "appointment booked successfully";
                    showSuccessfulDialog(context, message);
                  } else if (state is ProfessionalUpdateAppointmentState) {
                    String message = "appointment updated successfully";
                    showSuccessfulDialog(context, message);
                  }
                },
                child: BlocBuilder<SelectDateTimeBloc, SelectDateTimeState>(
                  builder: (context, state) {
                    if (state is SelectDateTimeInitial) {
                      professional = state.professional;
                      return loadingState(context, state.professional,name,phone);
                    } else if (state is ShowAvailableTimeState) {
                      name = state.name;
                      phone = state.phone;
                      professional = state.professional;
                      schedule = state.schedule;
                      timeSlots = state.timeSlots;
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Select time",
                          style: TextStyle(fontSize: deviceWidth < 360 ? 12 : 15),
                        ),
                      );
                    } else if (state is TimeSlotSelectedState) {
                      professional = state.professional;
                      name = state.name;
                      phone = state.phone;
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Select time",
                          style: TextStyle(fontSize: deviceWidth < 360 ? 12 : 15),
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
                        state.professional, state.schedule,state.name,state.phone);
                  } else if (state is NoScheduleAvailable) {
                    String text = "sorry no schedule available for this date";
                    if (state.dateTime == null ||
                        state.dateTime.day == DateTime.now().day) {
                      text = "sorry no schedule available today";
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  } else if (state is TimeSlotSelectedState) {
                    selectedIndex = state.selectedIndex;
                    timeSlots = state.timeSlots;
                    schedule = state.schedule;
                    return timeSlotBuilder(context, state.timeSlots,
                        state.selectedIndex, state.professional, state.schedule,state.name,state.phone);
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
                      Text(
                        "Enter Name",
                        style: TextStyle(fontSize: deviceWidth < 360 ? 10 : 15),
                      ),
                      SizedBox(height: 5),
                      BlocBuilder<SelectDateTimeBloc,SelectDateTimeState>(
                        builder: (context,state){
                          if(state is ShowAvailableTimeState){
                            nameTextController.text = state.name;
                            return Container(
                              height: deviceWidth < 360 ? 50 : 70,
                              child: customTextField(nameTextController, TextInputType.name, 'Name'),
                            );
                          }else if(state is TimeSlotSelectedState){
                            nameTextController.text = state.name;
                            return Container(
                              height: deviceWidth < 360 ? 50 : 70,
                              child: customTextField(nameTextController, TextInputType.name, 'Name'),
                            );
                          }else if(state is NoScheduleAvailable){
                            nameTextController.text = state.name;
                            return Container(
                              height: deviceWidth < 360 ? 50 : 70,
                              child: customTextField(nameTextController, TextInputType.name, 'Name'),
                            );
                          }
                          return Container();
                        },
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Enter Phone",
                        style: TextStyle(fontSize: deviceWidth < 360 ? 10 : 15),
                      ),
                      SizedBox(height: 5,),
                      BlocBuilder<SelectDateTimeBloc,SelectDateTimeState>(
                        builder: (context,state){
                          if(state is ShowAvailableTimeState){
                            phoneTextController.text = state.phone;
                            return Container(
                              height: deviceWidth < 360 ? 50 : 70,
                              child: customTextField(phoneTextController, TextInputType.phone, 'Phone'),
                            );
                          }else if(state is TimeSlotSelectedState){
                            phoneTextController.text = state.phone;
                            return Container(
                              height: deviceWidth < 360 ? 50 : 70,
                              child: customTextField(phoneTextController, TextInputType.phone, 'Phone'),
                            );
                          }else if(state is NoScheduleAvailable){
                            phoneTextController.text = state.phone;
                            return Container(
                                height: deviceWidth < 360 ? 50 : 70,
                                child: customTextField(phoneTextController, TextInputType.phone, 'Phone'),
                            );
                          }
                          return Container();
                        },
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  RoundedButton(
                    text: "Book appointment",
                    width: deviceWidth < 360 ? 200 : 300,
                    height: deviceWidth < 360 ? 40 : 55,
                    fontSize: deviceWidth < 360 ? 10 : 20,
                    color: Colors.blue,
                    textColor: Colors.white,
                    press: () {

                      String nameValidation = nameValidator(nameTextController.text);
                      String emptyPhoneValidation = emptyPhoneValidator(phoneTextController.text);
                      bool checkSelectedIndex = selectedIndex == null;
                      if (appointment == null) {
                        if (nameValidation != null) {
                          showErrorDialog(nameValidation, context);
                          return;
                        }
                        if (nameTextController.text.length <= 2) {
                          showErrorDialog(
                              "name length should be more than 2", context);
                          return;
                        }

                        if(emptyPhoneValidation !=null){
                          showErrorDialog(emptyPhoneValidation, context);
                          return;
                        }

                        String phoneValidation = phoneValidator(phoneTextController.text);
                        if (phoneValidation != null) {
                          showErrorDialog(phoneValidation, context);
                          return;
                        }

                        if (checkSelectedIndex) {
                          showErrorDialog("please select a time", context);
                          return;
                        }

                        BlocProvider.of<SelectDateTimeBloc>(context).add(
                            ProfessionalBookedTheAppointmentButtonEvent(
                                professional: professional,
                                dateTime: timeSlots[selectedIndex],
                                clientName: nameTextController.text,
                                clientPhone: phoneTextController.text));
                      } else {
                        bool phoneIsEmpty = false;
                        bool nameIsEmpty = false;
                        String oldName;
                        String oldPhone;

                        if(nameValidation != null){
                          nameIsEmpty = true;
                          oldName = appointment.getClientName();
                        }
                        if(!nameIsEmpty){
                          if (nameTextController.text.length <= 2) {
                            showErrorDialog(
                                "name length should be more than 2", context);
                            return;
                          }
                        }

                        if(emptyPhoneValidation != null){
                          phoneIsEmpty = true;
                          oldPhone = appointment.getClientPhone();
                        }
                        if(!phoneIsEmpty){
                          String phoneValidation = phoneValidator(phoneTextController.text);
                          if (phoneValidation != null) {
                            showErrorDialog(phoneValidation, context);
                            return;
                          }
                        }


                        if(phoneIsEmpty && nameIsEmpty && selectedIndex == null){
                          showErrorDialog("you have not update any thing", context);
                          return;
                        }

                        BlocProvider.of<SelectDateTimeBloc>(context).add(
                            ProfessionalUpdateAppointmentButtonEvent(
                                appointment: appointment,
                                dateTime: checkSelectedIndex ? appointment.getAppointmentDateTime().toDate():timeSlots[selectedIndex],
                                clientName: nameIsEmpty ? oldName:nameTextController.text,
                                clientPhone: phoneIsEmpty ? oldPhone:phoneTextController.text,
                                professional: professional));
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        )
      );
  }


  Widget loadingState(BuildContext context, Professional professional,String name,String phone) {
    BlocProvider.of<SelectDateTimeBloc>(context).add(
        ShowAvailableTimeEvent(professional: professional, dateTime: null,name: name,phone: phone));
    return Container();
  }

  Widget customTextField(TextEditingController textEditingController,TextInputType textInputType,String hint){
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder()),
    );
  }

  Widget timeSlotsUI(
      DateTime time,
      Color color,
      BuildContext context,
      int selectedIndex,
      Professional professional,
      List<DateTime> timeSlots,
      Schedule schedule,
      String name,
      String phone) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        BlocProvider.of<SelectDateTimeBloc>(context).add(TimeSlotSelectedEvent(
            professional: professional,
            scheduleIndex: selectedIndex,
            schedules: timeSlots,
            schedule: schedule,
            name: name,
            phone: phone));
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Row(
              children: [
                Text(
                  DateFormat.jm().format(time),
                  style: TextStyle(fontSize: deviceWidth < 360 ? 10 : 15),
                ),
                Text(
                  ' - ',
                  style: TextStyle(fontSize: deviceWidth < 360 ? 10 : 15),
                ),
                Text(
                  DateFormat.jm()
                      .format(time.add(Duration(minutes: schedule.getDuration()))),
                  style: TextStyle(fontSize: deviceWidth < 360 ? 10 : 15),
                ),
              ],
            )),
      ),
    );
  }

  Widget timeSlotBuilder(BuildContext context, List<DateTime> timeSlots,
      int selectedIndex, Professional professional, Schedule schedule,String name,String phone) {
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
              schedule,name,phone),
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

  showSuccessfulDialog(BuildContext context, String message) {
    showDialog(
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
                child: Text("Close"),
                onPressed: () => {
                  Navigator.of(context).pop(),
                  navigateToDashboardScreen(context)
                },
              )
            ],
          );
        });
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }

  String phoneValidator(String phone) {
    String pattern =
        r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(phone)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }


  String nameValidator(String name){
    if(name == null || name.isEmpty){
      return "please enter name";
    }
    return null;
  }
  String emptyPhoneValidator(String phone){
    if(phone == null || phone.isEmpty){
      return "please enter phone number";
    }
    return null;
  }

  }



