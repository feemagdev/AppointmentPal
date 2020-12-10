import 'package:appointmentproject/bloc/ProfessionalBloc/ManualBusinessHoursWeekDayBloc/manual_business_hours_weekday_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/week_days_availability.dart';
import 'package:appointmentproject/ui/Professional/AddCustomTimeSlotScreen/add_custom_time_slot_screen.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManualBusinessHoursWeekdayBody extends StatefulWidget {
  @override
  _ManualBusinessHoursWeekdayBodyState createState() =>
      _ManualBusinessHoursWeekdayBodyState();
}

class _ManualBusinessHoursWeekdayBodyState
    extends State<ManualBusinessHoursWeekdayBody> {
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;

  @override
  Widget build(BuildContext context) {
    final Professional _professional =
        BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context).professional;
    WeekDaysAvailability weekDaysAvailability;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Select Day"),
            leading: IconButton(
              onPressed: () {
                navigateToProfessionalSettingScreen(_professional, context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.save_outlined),
                onPressed: () {
                  BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context).add(
                      UpdateManualBusinessHoursWeekdaysEvent(
                          weekDaysAvailability: weekDaysAvailability));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                BlocListener<ManualBusinessHoursWeekdayBloc,
                    ManualBusinessHoursWeekdayState>(
                  listener: (context, state) {
                    if (state is ManualBusinessHoursWeekdaySelectedState) {
                      navigateToAddTimeSlotScreen(
                          context, _professional, state.day);
                    } else if (state
                        is UpdateManualBusinessHoursWeekdaysState) {
                      successfulDialog();
                    }
                  },
                  child: BlocBuilder<ManualBusinessHoursWeekdayBloc,
                      ManualBusinessHoursWeekdayState>(
                    builder: (context, state) {
                      if (state is ManualBusinessHoursWeekdayInitial) {
                        return loadingState(context);
                      } else if (state
                          is GetManualAvailableWeekDaysStatusState) {
                        weekDaysAvailability = state.weekDaysAvailability;
                        return settingBuilder(
                            context, state.weekDaysAvailability);
                      } else if (state
                          is ManualBusinessHoursWeekdayLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state
                          is UpdateManualBusinessHoursWeekdaysState) {
                        settingBuilder(context, state.updatedWeekDays);
                      }
                      print("container run");
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingBuilder(context, WeekDaysAvailability weekDaysAvailability) {
    return Column(
      children: [
        settingUI(
            text: "Monday",
            check: weekDaysAvailability.getMondayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setMondayAvailability(value);
              });
            },
            onTap: () {
              print("monday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForMondayEvent());
            }),
        Divider(),
        settingUI(
            text: "Tuesday",
            check: weekDaysAvailability.getTuesdayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setTuesdayAvailability(value);
              });
            },
            onTap: () {
              print("tuesday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForTuesdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Wednesday",
            check: weekDaysAvailability.getWednesdayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setWednesdayAvailability(value);
              });
            },
            onTap: () {
              print("wednesday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForWednesdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Thursday",
            check: weekDaysAvailability.getThursdayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setThursdayAvailability(value);
              });
            },
            onTap: () {
              print("thursday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForThursdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Friday",
            check: weekDaysAvailability.getFridayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setFridayAvailability(value);
              });
            },
            onTap: () {
              print("friday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForFridayEvent());
            }),
        Divider(),
        settingUI(
            text: "Saturday",
            check: weekDaysAvailability.getSaturdayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setSaturdayAvailability(value);
              });
            },
            onTap: () {
              print("saturday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForSaturdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Sunday",
            check: weekDaysAvailability.getSundayAvailability(),
            onChanged: (bool value) {
              setState(() {
                weekDaysAvailability.setSundayAvailability(value);
              });
            },
            onTap: () {
              print("sunday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForSundayEvent());
            }),
      ],
    );
  }

  Widget settingUI({text, onTap, check, onChanged}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            CupertinoSwitch(value: check, onChanged: onChanged),
          ],
        ),
      ),
    );
  }

  successfulDialog() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Business Hours",
      desc: "Business Hours Updated Successfully",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                .add(GetManualAvailableWeekDaysStatusEvent());
          },
          width: 120,
        )
      ],
    ).show();
  }

  void navigateToAddTimeSlotScreen(
      BuildContext context, Professional professional, String day) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddCustomTimeSlotScreen(professional: professional, day: day);
    }));
  }

  void navigateToAutomatedScheduleScreen(
      BuildContext context, Professional professional) {}

  void navigateToManualBusinessHoursState(
      BuildContext context, Professional professional) {}

  Widget loadingState(BuildContext context) {
    BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
        .add(GetManualAvailableWeekDaysStatusEvent());
    return Container();
  }

  void navigateToProfessionalSettingScreen(
      Professional professional, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen(professional: professional);
    }));
  }
}
