import 'package:appointmentproject/BLoC/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalEditAppointmentNewDateTimeBloc/professional_edit_appointment_new_date_time_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class ProfessionalEditAppointmentNewDateTime extends StatelessWidget {
  final Professional professional;
  final Appointment appointment;

  ProfessionalEditAppointmentNewDateTime({@required this.appointment,@required this.professional});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SelectDateTimeBloc(professional:professional,appointment: appointment),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit appointment"),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    Appointment _appointment;
    Schedule _schedule;
    List<DateTime> _timeSlots;
    int _selectedIndex;
    String _name;
    String _phone;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("Select date"),
          SizedBox(
            height: 10,
          ),
          CustomDateView(
            onTap: (DateTime dateTime) {},
          ),
          SizedBox(
            height: 10,
          ),
          BlocListener<ProfessionalEditAppointmentNewDateTimeBloc,
              ProfessionalEditAppointmentNewDateTimeState>(
            listener: (context, state) {},
            child: BlocBuilder<ProfessionalEditAppointmentNewDateTimeBloc,
                ProfessionalEditAppointmentNewDateTimeState>(
              builder: (context, state) {
                if (state is EditAppointmentNewDateTimeInitial) {
                  _appointment = state.appointment;
                  return loadingState(context, state.appointment);
                } else if (state
                    is EditAppointmentShowSelectedDayAvailableTimeState) {
                  _appointment = state.appointment;
                  _schedule = state.schedule;
                  _timeSlots = state.timeSlots;
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Select time",
                      style: TextStyle(fontSize: deviceWidth < 400 ? 12 : 15),
                    ),
                  );
                } else if (state is ProfessionalTimeSlotSelectedState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Select time",
                      style: TextStyle(fontSize: deviceWidth < 400 ? 12 : 15),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          BlocBuilder<ProfessionalEditAppointmentNewDateTimeBloc,
              ProfessionalEditAppointmentNewDateTimeState>(
            builder: (context, state) {
              if (state is EditAppointmentShowSelectedDayAvailableTimeState) {
                return timeSlotBuilder(context, state.timeSlots, null,
                    state.appointment, state.schedule);
              } else if (state
                  is EditAppointmentNewDateTimeNoAvailableTimeState) {
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
              } else if (state is ProfessionalTimeSlotSelectedState) {
                _selectedIndex = state.selectedIndex;
                _timeSlots = state.timeSlots;
                _schedule = state.schedule;
                return timeSlotBuilder(context, state.timeSlots,
                    state.selectedIndex, state.appointment, state.schedule);
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
                    style: TextStyle(fontSize: deviceWidth < 400 ? 10 : 15),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: deviceWidth < 400 ? 50 : 70,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Name",
                          enabledBorder: OutlineInputBorder()),
                      onChanged: (text) {
                        _name = text;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Enter your phone number",
                    style: TextStyle(fontSize: deviceWidth < 400 ? 10 : 15),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: deviceWidth < 400 ? 50 : 70,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Phone",
                          enabledBorder: OutlineInputBorder()),
                      onChanged: (text) {
                        _phone = text;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              RoundedButton(
                text: "Book appointment",
                width: deviceWidth < 400 ? 200 : 300,
                height: deviceWidth < 400 ? 40 : 55,
                fontSize: deviceWidth < 400 ? 10 : 20,
                color: Colors.blue,
                textColor: Colors.white,
                press: () {
                  if (_name == null || _name.isEmpty) {
                    showErrorDialog("please enter name", context);
                    return;
                  }
                  if (_name.length <= 2) {
                    showErrorDialog(
                        "name length should be more than 2", context);
                    return;
                  }

                  String phoneValidation = phoneValidator(_phone);
                  if (phoneValidation != null) {
                    showErrorDialog(phoneValidation, context);
                    return;
                  }
                  if (_selectedIndex == null) {
                    showErrorDialog("please select a time", context);
                    return;
                  }

                  BlocProvider.of<ProfessionalEditAppointmentNewDateTimeBloc>(
                          context)
                      .add(ProfessionalEditAppointmentBookedButtonEvent(
                          appointment: _appointment,
                          dateTime: _timeSlots[_selectedIndex],
                          clientName: _name,
                          clientPhone: _phone));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget loadingState(BuildContext context, Appointment appointment) {
    BlocProvider.of<ProfessionalEditAppointmentNewDateTimeBloc>(context).add(
        EditAppointmentShowSelectedDayTimeEvent(
            appointment: appointment, dateTime: null));
    return Container();
  }

  Widget timeSlotsUI(
      DateTime time,
      Color color,
      BuildContext context,
      int selectedIndex,
      Appointment appointment,
      List<DateTime> timeSlots,
      Schedule schedule) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        BlocProvider.of<ProfessionalEditAppointmentNewDateTimeBloc>(context)
            .add(ProfessionalTimeSlotSelectedEvent(
                appointment: appointment,
                scheduleIndex: selectedIndex,
                schedules: timeSlots,
                schedule: schedule));
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
              style: TextStyle(fontSize: deviceWidth < 400 ? 10 : 15),
            ),
            Text(
              ' - ',
              style: TextStyle(fontSize: deviceWidth < 400 ? 10 : 15),
            ),
            Text(
              DateFormat.jm()
                  .format(time.add(Duration(minutes: schedule.getDuration()))),
              style: TextStyle(fontSize: deviceWidth < 400 ? 10 : 15),
            ),
          ],
        )),
      ),
    );
  }

  Widget timeSlotBuilder(BuildContext context, List<DateTime> timeSlots,
      int selectedIndex, Appointment appointment, Schedule schedule) {
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
              appointment,
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
      return Container();
    }));
  }

  String phoneValidator(String phone) {
    String pattern =
        r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";
    RegExp regExp = new RegExp(pattern);
    if (phone.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(phone)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
