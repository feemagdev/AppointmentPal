import 'package:appointmentproject/bloc/ProfessionalBloc/AddCustomTimeSlotBloc/add_custom_time_slot_bloc.dart';
import 'package:appointmentproject/model/custom_time_slots.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ManualBusinessHoursScreen/manual_business_hours_weekday_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddCustomTimeSlotBody extends StatefulWidget {
  @override
  _AddCustomTimeSlotBodyState createState() => _AddCustomTimeSlotBodyState();
}

class _AddCustomTimeSlotBodyState extends State<AddCustomTimeSlotBody> {
  bool buttonCheck = true;
  DateTime fromDateTime;
  DateTime toDateTime;

  @override
  Widget build(BuildContext context) {
    final Professional professional =
        BlocProvider.of<AddCustomTimeSlotBloc>(context).professional;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text("Add Time Slot"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigateToManualBusinessHoursScreen(context, professional);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                addCustomTimeSlotButton(),
                SizedBox(
                  height: 20,
                ),
                BlocListener<AddCustomTimeSlotBloc, AddCustomTimeSlotState>(
                  listener: (context, state) {
                    if (state is CustomTimeSlotNotAdded) {
                      String message =
                          "This time slot has clash with already created time slot";
                      errorDialog(message);
                    } else if (state is WrongTimeSelectedState) {
                      String message =
                          "Start time cannot be less than End time";
                      errorDialog(message);
                    } else if (state is CustomTimeSlotDeletedSuccessfully) {
                      String message = "Time slot deleted successfully";
                      successDialog(message);
                    }
                  },
                  child: BlocBuilder<AddCustomTimeSlotBloc,
                      AddCustomTimeSlotState>(
                    builder: (context, state) {
                      if (state is AddCustomTimeSlotInitial) {
                        return loadingState(context);
                      } else if (state is GetCustomTimeSlotsState) {
                        return listOfCustomTimeSlots(state.customTimeSlots);
                      } else if (state
                          is CustomSlotTimeSlotAddedSuccessfullyState) {
                        return listOfCustomTimeSlots(state.customTimeSlots);
                      } else if (state is AddCustomSlotLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }
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

  Widget loadingState(BuildContext context) {
    BlocProvider.of<AddCustomTimeSlotBloc>(context)
        .add(GetCustomTimeSlotEvent());
    return Container();
  }

  Widget addCustomTimeSlotButton() {
    return InkWell(
      onTap: () {
        showDialog(
            context: this.context,
            builder: (context) {
              return showCustomDialog();
            });
      },
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(
            width: 10,
          ),
          Text("Add Time Slot"),
        ],
      ),
    );
  }

  Widget showCustomDialog() {
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
                RaisedButton(
                    child: Text("FROM"),
                    color: buttonCheck == true ? Colors.blue : Colors.white,
                    textColor: buttonCheck == true ? Colors.white : Colors.blue,
                    onPressed: () {
                      setState(() {
                        Navigator.of(this.context).pop();
                        buttonCheck = !buttonCheck;
                        showDialog(
                            context: this.context,
                            builder: (context) {
                              return showCustomDialog();
                            });
                      });
                    }),
                RaisedButton(
                    child: Text("To"),
                    color: buttonCheck == true ? Colors.white : Colors.blue,
                    textColor: buttonCheck == true ? Colors.blue : Colors.white,
                    onPressed: () {
                      setState(() {
                        Navigator.of(this.context).pop();
                        buttonCheck = !buttonCheck;

                        showDialog(
                            context: this.context,
                            builder: (context) {
                              return showCustomDialog();
                            });
                      });
                    }),
              ],
            ),
            TimePickerSpinner(
                time: buttonCheck == true ? fromDateTime : toDateTime,
                is24HourMode: false,
                onTimeChange: (dateTime) {
                  if (buttonCheck == true) {
                    fromDateTime = dateTime;
                  } else {
                    toDateTime = dateTime;
                  }
                }),
            FlatButton(
              child: Text("Save"),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 200,
              onPressed: () {
                Navigator.of(this.context).pop();
                BlocProvider.of<AddCustomTimeSlotBloc>(this.context).add(
                    ProfessionalAddCustomTimeSlotEvent(
                        from: fromDateTime, to: toDateTime));
                print(fromDateTime);
                print(toDateTime); //
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget listOfCustomTimeSlots(List<CustomTimeSlots> customTimeSlots) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: customTimeSlots.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(DateFormat.jm()
                            .format(customTimeSlots[index].getFromTime())),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.arrow_forward),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(DateFormat.jm()
                            .format(customTimeSlots[index].getToTime())),
                      ],
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[500],
                        ),
                        onPressed: () {
                          print('deleted');
                          BlocProvider.of<AddCustomTimeSlotBloc>(context).add(
                              DeleteCustomTimeSlotEvent(
                                  customTimeSlots: customTimeSlots[index]));
                        })
                  ],
                ),
              ),
            );
          }),
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
            BlocProvider.of<AddCustomTimeSlotBloc>(context)
                .add(GetCustomTimeSlotEvent());
          },
          width: 120,
        )
      ],
    ).show();
  }

  successDialog(String message) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<AddCustomTimeSlotBloc>(context)
                .add(GetCustomTimeSlotEvent());
          },
          width: 120,
        )
      ],
    ).show();
  }

  void navigateToManualBusinessHoursScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManualBusinessHoursWeekDayScreen(professional: professional);
    }));
  }
}
