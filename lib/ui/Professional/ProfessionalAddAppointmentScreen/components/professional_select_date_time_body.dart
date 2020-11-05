import 'package:appointmentproject/bloc/ClientBloc/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/manager_select_professional_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalSelectCustomerScreen/professional_select_customer_screen.dart';
import 'package:appointmentproject/ui/Professional/UpdateAppointmentScreen/update_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class ProfessionalSelectDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final Professional professional =
        BlocProvider.of<SelectDateTimeBloc>(context).professional;
    final Appointment appointment =
        BlocProvider.of<SelectDateTimeBloc>(context).appointment;
    final Customer customer =
        BlocProvider.of<SelectDateTimeBloc>(context).customer;
    final Manager manager =
        BlocProvider.of<SelectDateTimeBloc>(context).manager;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Date and Time"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (appointment == null && manager == null) {
              print("select date time screen manager null");
              BlocProvider.of<SelectDateTimeBloc>(context)
                  .add(MoveToDashboardScreenEvent(professional: professional));
            } else if (appointment != null && manager == null) {
              print("appointment not null, manager null");
              BlocProvider.of<SelectDateTimeBloc>(context).add(
                  MoveToUpdateAppointmentScreenEvent(
                      professional: professional,
                      appointment: appointment,
                      customer: customer));
            } else if (appointment == null && manager != null) {
              print("appointment null and manager not null");
              navigateToManagerSelectProfessionalScreen(context, manager);
            }
          },
        ),
      ),
      body: Padding(
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
                        dateTime: dateTime));
              },
            ),
            BlocListener<SelectDateTimeBloc, SelectDateTimeState>(
              listener: (context, state) {
                if (state is MoveToSelectCustomerScreenState) {
                  navigateToSelectCustomerScreen(context, professional,
                      state.appointmentStartTime, state.appointmentEndTime,
                      manager);
                } else if (state is MoveToDashboardScreenState) {
                  navigateToDashboardScreen(context, professional);
                } else if (state is MoveToUpdateAppointmentScreenState) {
                  navigateToUpdateAppointmentScreen(context, professional,
                      state.appointment, state.customer);
                }
              },
              child: BlocBuilder<SelectDateTimeBloc, SelectDateTimeState>(
                builder: (context, state) {
                  if (state is SelectDateTimeInitial) {
                    return loadingState(context, state.professional,
                        state.appointment, state.customer);
                  } else if (state is ShowAvailableTimeState) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Text(
                        "Select time",
                        style: TextStyle(fontSize: deviceWidth < 360 ? 12 : 17),
                      ),
                    );
                  } else if (state is TimeSlotSelectedState) {
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
                      state.schedule,),
                  );
                } else if (state is NoScheduleAvailable) {
                  String text = "Sorry no schedule available for this date";
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
                  return buildTimeSlotsUI(
                    context,
                    state.timeSlots,
                    state.selectedIndex,
                    state.schedule,);
                } else if (state is SelectDateTimeLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingState(BuildContext context, Professional professional,
      Appointment appointment, Customer customer) {
    BlocProvider.of<SelectDateTimeBloc>(context).add(ShowAvailableTimeEvent(
        dateTime: null));
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
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

  Widget timeSlotsUI(DateTime time,
      Color color,
      BuildContext context,
      int selectedIndex,
      List<DateTime> timeSlots,
      Schedule schedule) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return InkWell(
      onTap: () {
        BlocProvider.of<SelectDateTimeBloc>(context).add(TimeSlotSelectedEvent(
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
  Widget timeSlotBuilder2(BuildContext context,
      List<DateTime> timeSlots,
      int selectedIndex,
      Schedule schedule) {
    return GridView.builder(
        itemCount: timeSlots.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20),
        itemBuilder: (BuildContext context, int index) =>
            timeSlotsUI(
                timeSlots[index],
                selectedIndex == index ? Colors.blue : Colors.white,
                context,
                index,
                timeSlots,
                schedule));
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

  showSuccessfulDialog(
      BuildContext context, String message, Professional professional) {
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
                  navigateToDashboardScreen(context, professional)
                },
              )
            ],
          );
        });
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

  Widget buildTimeSlotsUI(BuildContext context,
      List<DateTime> timeSlots,
      int selectedIndex,
      Schedule schedule) {
    BlocProvider.of<SelectDateTimeBloc>(context).add(TimeSlotIsSelectedEvent(
        appointmentStartTime: timeSlots[selectedIndex],
        appointmentEndTime: timeSlots[selectedIndex]
            .add(Duration(minutes: schedule.getDuration()))));
    return Expanded(
        child: timeSlotBuilder2(context, timeSlots, selectedIndex,
            schedule));
  }

  void navigateToDashboardScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(
        professional: professional,
      );
    }));
  }

  void navigateToSelectCustomerScreen(BuildContext context,
      Professional professional,
      DateTime appointmentStartTime,
      DateTime appointmentEndTime, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectCustomerScreen(
          professional: professional,
          appointmentStartTime: appointmentStartTime,
          appointmentEndTime: appointmentEndTime,
          manager: manager
      );
    }));
  }

  void navigateToUpdateAppointmentScreen(BuildContext context,
      Professional professional, Appointment appointment, Customer customer) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UpdateAppointmentScreen(
        professional: professional,
        appointment: appointment,
        customer: customer,
      );
    }));
  }

  void navigateToManagerSelectProfessionalScreen(BuildContext context,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSelectProfessionalScreen(manager: manager);
    }));
  }
}
