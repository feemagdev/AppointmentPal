import 'package:appointmentproject/bloc/ProfessionalBloc/AutomaticBusinessHoursBloc/automatic_business_hours_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AddAutomatedScheduleScreen/add_automtic_schedule_screen.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutomaticBusinessHoursBody extends StatefulWidget {
  @override
  _AutomaticBusinessHoursBodyState createState() =>
      _AutomaticBusinessHoursBodyState();
}

class _AutomaticBusinessHoursBodyState
    extends State<AutomaticBusinessHoursBody> {
  @override
  Widget build(BuildContext context) {
    final Professional _professional =
        BlocProvider.of<AutomaticBusinessHoursBloc>(context).professional;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Day"),
        leading: IconButton(
          onPressed: () {
            navigateToProfessionalSettingScreen(_professional, context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocListener<AutomaticBusinessHoursBloc,
                AutomaticBusinessHoursState>(
              listener: (context, state) {
                if (state is AutomaticBusinessHoursWeekdaySelectedState) {
                  naviagteToAddAutomaticScheduleScreen(
                      context, state.day, _professional);
                }
              },
              child: BlocBuilder<AutomaticBusinessHoursBloc,
                  AutomaticBusinessHoursState>(
                builder: (context, state) {
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        settingUI(
            text: "Monday",
            onTap: () {
              print("monday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForMondayEvent());
            }),
        Divider(),
        settingUI(
            text: "Tuesday",
            onTap: () {
              print("tuesday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForTuesdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Wednesday",
            onTap: () {
              print("wednesday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForWednesdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Thursday",
            onTap: () {
              print("thursday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForThursdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Friday",
            onTap: () {
              print("friday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForFridayEvent());
            }),
        Divider(),
        settingUI(
            text: "Saturday",
            onTap: () {
              print("saturday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForSaturdayEvent());
            }),
        Divider(),
        settingUI(
            text: "Sunday",
            onTap: () {
              print("sunday");
              BlocProvider.of<AutomaticBusinessHoursBloc>(context)
                  .add(AutomaticBusinessHoursForSundayEvent());
            }),
      ],
    );
  }

  Widget settingUI({text, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(text), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    );
  }

  void navigateToProfessionalSettingScreen(
      Professional professional, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen(professional: professional);
    }));
  }

  void naviagteToAddAutomaticScheduleScreen(
      BuildContext context, String day, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddAutomaticScheduleScreen(day: day, professional: professional);
    }));
  }
}
