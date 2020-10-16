import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/BLoC/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/professional_select_customer_screen.dart';
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
    List<DateTime> timeSlots;
    Schedule schedule;
    int selectedIndex;
    TextEditingController nameTextController = new TextEditingController();
    TextEditingController phoneTextController = new TextEditingController();

    return Padding(
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
                      professional: professional, dateTime: dateTime));
            },
          ),
          BlocListener<SelectDateTimeBloc, SelectDateTimeState>(
            listener: (context, state) {
              if (state is MoveToSelectCustomerScreenState) {
                navigateToSelectCustomerScreen(context,state.professional,state.selectedDateTime);
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
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      "Select time",
                      style: TextStyle(fontSize: deviceWidth < 360 ? 12 : 17),
                    ),
                  );
                } else if (state is TimeSlotSelectedState) {
                  professional = state.professional;
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      "Select time",
                      style: TextStyle(fontSize: deviceWidth < 360 ? 12 : 17),
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
                return Expanded(
                  child: timeSlotBuilder2(
                    context,
                    state.timeSlots,
                    null,
                    state.professional,
                    state.schedule,
                  ),
                );
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
                return buildTimeSlotsUI(context, state.timeSlots,
                    state.selectedIndex, state.professional, state.schedule);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget loadingState(BuildContext context, Professional professional) {
    BlocProvider.of<SelectDateTimeBloc>(context).add(
        ShowAvailableTimeEvent(professional: professional, dateTime: null));
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController textEditingController,
      TextInputType textInputType, String hint) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      decoration:
          InputDecoration(hintText: hint, enabledBorder: OutlineInputBorder()),
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
  ) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        BlocProvider.of<SelectDateTimeBloc>(context).add(TimeSlotSelectedEvent(
          professional: professional,
          scheduleIndex: selectedIndex,
          schedules: timeSlots,
          schedule: schedule,
        ));
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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

  /* Widget timeSlotBuilder(
      BuildContext context,
      List<DateTime> timeSlots,
      int selectedIndex,
      Professional professional,
      Schedule schedule,
      String name,
      String phone) {
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
              schedule,
              name,
              phone),
        ),
      ),
    );
  }
*/
  Widget timeSlotBuilder2(
    BuildContext context,
    List<DateTime> timeSlots,
    int selectedIndex,
    Professional professional,
    Schedule schedule,
  ) {
    return GridView.builder(
        itemCount: timeSlots.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20),
        itemBuilder: (BuildContext context, int index) => timeSlotsUI(
              timeSlots[index],
              selectedIndex == index ? Colors.blue : Colors.white,
              context,
              index,
              professional,
              timeSlots,
              schedule,
            ));
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



  String phoneValidator(String phone) {
    String pattern =
        r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(phone)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String nameValidator(String name) {
    if (name == null || name.isEmpty) {
      return "please enter name";
    }
    return null;
  }

  String emptyPhoneValidator(String phone) {
    if (phone == null || phone.isEmpty) {
      return "please enter phone number";
    }
    return null;
  }

  Widget buildTimeSlotsUI(BuildContext context, List<DateTime> timeSlots,
      int selectedIndex, Professional professional, Schedule schedule) {
    BlocProvider.of<SelectDateTimeBloc>(context).add(
        MoveToSelectCustomerScreenEvent(
            professional: professional,
            selectedDateTime: timeSlots[selectedIndex]));
    return Expanded(
        child: timeSlotBuilder2(
      context,
      timeSlots,
      selectedIndex,
      professional,
      schedule,
    ));
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }

  void navigateToSelectCustomerScreen(BuildContext context, Professional professional, DateTime selectedDateTime) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectCustomerScreen(
        professional: professional,
        selectedDateTime:selectedDateTime,
      );
    }));
  }
}
