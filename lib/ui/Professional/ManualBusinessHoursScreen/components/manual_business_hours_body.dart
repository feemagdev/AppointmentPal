import 'package:appointmentproject/bloc/ProfessionalBloc/ManualBusinessHoursWeekDayBloc/manual_business_hours_weekday_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AddCustomTimeSlotScreen/add_custom_time_slot_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Day"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
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
                }
              },
              child: BlocBuilder<ManualBusinessHoursWeekdayBloc,
                  ManualBusinessHoursWeekdayState>(
                builder: (context, state) {
                  if (state is ManualBusinessHoursWeekdayInitial) {
                    print("initial run");
                    return settingBuilder(context);
                  }
                  print("container run");
                  return settingBuilder(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingBuilder(context) {
    return Column(
      children: [
        settingUI(
            text: "Monday",
            check: monday,
            onChanged: (bool value) {
              setState(() {
                monday = value;
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
            check: tuesday,
            onChanged: (bool value) {
              setState(() {
                tuesday = value;
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
            check: wednesday,
            onChanged: (bool value) {
              setState(() {
                wednesday = value;
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
            check: thursday,
            onChanged: (bool value) {
              setState(() {
                thursday = value;
              });
            },
            onTap: () {
              print("thursday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForMondayEvent());
            }),
        Divider(),
        settingUI(
            text: "Friday",
            check: friday,
            onChanged: (bool value) {
              setState(() {
                friday = value;
              });
            },
            onTap: () {
              print("friday");
              BlocProvider.of<ManualBusinessHoursWeekdayBloc>(context)
                  .add(ManualBusinessHoursForMondayEvent());
            }),
        Divider(),
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

  void navigateToAddTimeSlotScreen(
      BuildContext context, Professional professional, String day) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return AddCustomTimeSlotScreen(professional:professional,day:day);
    }));
  }

  void navigateToAutomatedScheduleScreen(
      BuildContext context, Professional professional) {}

  void navigateToManualBusinessHoursState(
      BuildContext context, Professional professional) {}
}
