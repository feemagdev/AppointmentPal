import 'package:appointmentproject/bloc/ProfessionalBloc/AddAutomaticSchedule/add_automatic_schedule_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/Professional/AutomaticBusinessHoursScreen/automatic_business_hours_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddAutomaticScheduleBody extends StatefulWidget {
  @override
  _AddAutomaticScheduleBodyState createState() =>
      _AddAutomaticScheduleBodyState();
}

class _AddAutomaticScheduleBodyState extends State<AddAutomaticScheduleBody> {
  bool buttonCheck = true;
  DateTime fromDateTime;
  DateTime toDateTime;
  DateTime duration;
  bool breakTimeEditCheck = false;
  bool firstTime = true;
  Schedule tempSchedule = Schedule.defaultConstructor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Professional professional =
                BlocProvider.of<AddAutomaticScheduleBloc>(context).professional;
            navigateToAutomaticBusinessHourSceeen(context, professional);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            BlocListener<AddAutomaticScheduleBloc, AddAutomaticScheduleState>(
              listener: (context, state) {
                if (state is NoScheduleAvailableState) {
                  return noScheduleAvailableAlert(
                      "No schedule available for this day");
                } else if (state is ScheduleUpdatedSuccessfullyState) {
                  return scheduleUpdatedSuccessfullyAlert(
                      "Your schedule is updated");
                }
              },
              child: BlocBuilder<AddAutomaticScheduleBloc,
                  AddAutomaticScheduleState>(
                builder: (context, state) {
                  if (state is AddAutomaticScheduleInitial) {
                    return loadingState(context);
                  } else if (state is GetAutomaticScheduleOfSelectedDayState) {
                    tempSchedule = state.schedule;
                    return addAutomaticScheduleUI(state.schedule);
                  } else if (state is NoScheduleAvailableState) {
                    tempSchedule.setStartTime(9);
                    tempSchedule.setStartTimeMinutes(0);
                    tempSchedule.setEndTime(17);
                    tempSchedule.setEndTimeMinutes(0);
                    tempSchedule.setBreakStartTime(-1);
                    tempSchedule.setBreakEndTime(-1);
                    tempSchedule.setBreakEndTimeMinutes(-1);
                    tempSchedule.setBreakStartTime(-1);
                    tempSchedule.setBreakStartTimeMinutes(-1);
                    tempSchedule.setDuration(60);
                    return addAutomaticScheduleUI(tempSchedule);
                  } else if (state is AddAutomaticScheduleLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget timeUI(Schedule schedule) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          print("tap on time ui");
          showDialog(
              context: this.context,
              builder: (context) {
                return showCustomDialog();
              });
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.timer)),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Schedule Time"),
                      Row(
                        children: [
                          Text(DateFormat.jm().format(DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              schedule.getStartTime(),
                              schedule.getStartTimeMinutes()))),
                          Icon(Icons.arrow_forward),
                          Text(DateFormat.jm().format(DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              schedule.getEndTime(),
                              schedule.getEndTimeMinutes()))),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Icon(Icons.edit)
            ],
          ),
        ),
      ),
    );
  }

  Widget breakTimeUi(Schedule schedule) {
    bool breakTimeCheck = false;
    if (schedule.getBreakStartTime() == -1 &&
        schedule.getBreakStartTimeMinutes() == -1) {
      breakTimeCheck = true;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          print("tap on break Time");
          breakTimeEditCheck = true;
          showDialog(
              context: this.context,
              builder: (context) {
                return showCustomDialog();
              });
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.timer)),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Break Time"),
                      breakTimeCheck == true
                          ? Text("No break time given")
                          : Row(
                              children: [
                                Text(DateFormat.jm().format(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    schedule.getBreakStartTime(),
                                    schedule.getBreakStartTimeMinutes()))),
                                Icon(Icons.arrow_forward),
                                Text(DateFormat.jm().format(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    schedule.getBreakEndTime(),
                                    schedule.getBreakEndTimeMinutes()))),
                              ],
                            )
                    ],
                  )
                ],
              ),
              Icon(Icons.edit)
            ],
          ),
        ),
      ),
    );
  }

  Widget durationUI(Schedule schedule) {
    int hours = 0;
    int minutes = schedule.getDuration();
    print(schedule.getDuration());
    if (schedule.getDuration() > 60) {
      hours = schedule.getDuration() ~/ 60;
      minutes = schedule.getDuration() % 60;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          print("tap on duration");
          showDialog(
              context: this.context,
              builder: (context) {
                return customTimePicker();
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.timelapse_rounded)),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Appointment Duration"),
                    SizedBox(height: 2),
                    Text("$hours:$minutes hour:minute")
                  ],
                )
              ],
            ),
            Icon(Icons.edit),
          ],
        ),
      ),
    );
  }

  Widget addAutomaticScheduleUI(Schedule schedule) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        timeUI(schedule),
        Divider(),
        durationUI(schedule),
        Divider(),
        breakTimeUi(schedule),
        SizedBox(
          height: 50,
        ),
        schedule.getProfessionalID() == null ||
                schedule.getProfessionalID().isEmpty
            ? addNewScheduleButton()
            : Text("")
      ],
    );
  }

  Widget loadingState(BuildContext context) {
    BlocProvider.of<AddAutomaticScheduleBloc>(context)
        .add(GetAutomaticScheduleOfSelectedDayEvent());
    return Center(child: CircularProgressIndicator());
  }

  Widget showCustomDialog() {
    if (firstTime) {
      if (breakTimeEditCheck) {
        fromDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            tempSchedule.getBreakStartTime(),
            tempSchedule.getBreakStartTimeMinutes());
        toDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            tempSchedule.getBreakEndTime(),
            tempSchedule.getBreakEndTimeMinutes());
      } else {
        fromDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            tempSchedule.getStartTime(),
            tempSchedule.getStartTimeMinutes());
        toDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            tempSchedule.getEndTime(),
            tempSchedule.getEndTimeMinutes());
      }
    }
    return AlertDialog(
      content: Container(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: RaisedButton(
                      child: Text("FROM"),
                      color: buttonCheck == true ? Colors.blue : Colors.white,
                      textColor:
                          buttonCheck == true ? Colors.white : Colors.blue,
                      onPressed: () {
                        setState(() {
                          Navigator.of(this.context).pop();
                          buttonCheck = !buttonCheck;
                          firstTime = false;
                          showDialog(
                              context: this.context,
                              builder: (context) {
                                return showCustomDialog();
                              });
                        });
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: RaisedButton(
                      child: Text("TO"),
                      color: buttonCheck == true ? Colors.white : Colors.blue,
                      textColor:
                          buttonCheck == true ? Colors.blue : Colors.white,
                      onPressed: () {
                        setState(() {
                          Navigator.of(this.context).pop();
                          buttonCheck = !buttonCheck;
                          firstTime = false;
                          showDialog(
                              context: this.context,
                              builder: (context) {
                                return showCustomDialog();
                              });
                        });
                      }),
                ),
              ],
            ),
            TimePickerSpinner(
                time: buttonCheck == true ? fromDateTime : toDateTime,
                spacing: MediaQuery.of(context).size.width * 0.12,
                is24HourMode: false,
                highlightedTextStyle: TextStyle(fontSize: 25),
                normalTextStyle: TextStyle(fontSize: 25, color: Colors.grey),
                onTimeChange: (dateTime) {
                  if (buttonCheck == true) {
                    fromDateTime = dateTime;
                  } else {
                    toDateTime = dateTime;
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text("Save"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width * 0.30,
                  onPressed: () {
                    firstTime = true;

                    Navigator.of(this.context).pop();
                    if (breakTimeEditCheck) {
                      int startTimeInMinutes =
                          tempSchedule.getStartTime() * 60 +
                              tempSchedule.getStartTimeMinutes();
                      int endTimeInMinutes = tempSchedule.getEndTime() * 60 +
                          tempSchedule.getEndTimeMinutes();
                      int breakStartTimeInMinutes =
                          fromDateTime.hour * 60 + fromDateTime.minute;
                      int breakEndTimeInMinutes =
                          toDateTime.hour * 60 + toDateTime.minute;
                      print(breakStartTimeInMinutes);
                      print(startTimeInMinutes);
                      if (breakStartTimeInMinutes <= startTimeInMinutes) {
                        noScheduleAvailableAlert(
                            "Break start time shoud be started after schedule start time");
                      } else if (breakEndTimeInMinutes >= endTimeInMinutes) {
                        print(breakEndTimeInMinutes);
                        print(endTimeInMinutes);
                        noScheduleAvailableAlert(
                            "Break end time sholud be ended before schedule end time");
                      } else if (breakStartTimeInMinutes >= endTimeInMinutes) {
                        noScheduleAvailableAlert(
                            "break time should be between schdule time");
                      } else if (breakStartTimeInMinutes >=
                          breakEndTimeInMinutes) {
                        noScheduleAvailableAlert(
                            "Break start time sholud be less than Break end time");
                      } else {
                        tempSchedule.setBreakStartTime(fromDateTime.hour);
                        tempSchedule
                            .setBreakStartTimeMinutes(fromDateTime.minute);
                        tempSchedule.setBreakEndTime(toDateTime.hour);
                        tempSchedule.setBreakEndTimeMinutes(toDateTime.minute);
                        BlocProvider.of<AddAutomaticScheduleBloc>(context).add(
                            UpdateAutomaticScheduleEvent(
                                schedule: tempSchedule));
                      }
                    } else {
                      tempSchedule.setStartTime(fromDateTime.hour);
                      tempSchedule.setStartTimeMinutes(fromDateTime.minute);
                      tempSchedule.setEndTime(toDateTime.hour);
                      tempSchedule.setEndTimeMinutes(toDateTime.minute);
                      BlocProvider.of<AddAutomaticScheduleBloc>(context).add(
                          UpdateAutomaticScheduleEvent(schedule: tempSchedule));
                    }
                    breakTimeEditCheck = false;
                  },
                ),
                FlatButton(
                    minWidth: MediaQuery.of(context).size.width * 0.30,
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                      firstTime = true;
                      breakTimeEditCheck = false;
                    },
                    child: Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customTimePicker() {
    int hours = 0;
    int minutes = tempSchedule.getDuration();
    print(tempSchedule.getDuration());
    if (tempSchedule.getDuration() > 60) {
      hours = tempSchedule.getDuration() ~/ 60;
      minutes = tempSchedule.getDuration() % 60;
    }
    if (firstTime) {
      duration = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, hours, minutes);
    }
    return AlertDialog(
      content: Container(
        height: 330,
        width: MediaQuery.of(context).size.width * 0.70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(),
            Text(
              "Appointment duration",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 365 ? 20 : 25),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hours",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.065,
                    ),
                    Text(
                      "Minutes",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                TimePickerSpinner(
                    time: duration,
                    alignment: Alignment.center,
                    spacing: MediaQuery.of(context).size.width * 0.12,
                    is24HourMode: true,
                    highlightedTextStyle: TextStyle(fontSize: 25),
                    normalTextStyle:
                        TextStyle(fontSize: 25, color: Colors.grey),
                    onTimeChange: (dateTime) {
                      duration = dateTime;
                      firstTime = false;
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text("Save"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  minWidth: MediaQuery.of(context).size.width * 0.30,
                  onPressed: () {
                    Navigator.of(this.context).pop();
                    int totalMinutes = tempSchedule.getEndTime() * 60 +
                        tempSchedule.getEndTimeMinutes();
                    int newDurationMinutes =
                        duration.hour * 60 + duration.minute;
                    if (newDurationMinutes > totalMinutes) {
                      noScheduleAvailableAlert("Invalid duration");
                    } else {
                      tempSchedule
                          .setDuration(duration.hour * 60 + duration.minute);
                      BlocProvider.of<AddAutomaticScheduleBloc>(context).add(
                          UpdateAutomaticScheduleEvent(schedule: tempSchedule));
                    }
                    firstTime = true;
                  },
                ),
                FlatButton(
                    minWidth: MediaQuery.of(context).size.width * 0.30,
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                      firstTime = true;
                    },
                    child: Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget addNewScheduleButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      child: RaisedButton(
          child: Text(
            "Add new schedule",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () {
            BlocProvider.of<AddAutomaticScheduleBloc>(context)
                .add(UpdateAutomaticScheduleEvent(schedule: tempSchedule));
          }),
    );
  }

  noScheduleAvailableAlert(String message) {
    breakTimeEditCheck = false;
    Alert(
      context: this.context,
      type: AlertType.info,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  scheduleUpdatedSuccessfullyAlert(String message) {
    Alert(
      context: this.context,
      type: AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  void navigateToAutomaticBusinessHourSceeen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AutomaticBusinessHoursScreen(professional: professional);
    }));
  }
}
