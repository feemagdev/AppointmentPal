import 'dart:ui';

import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/BLoC/SelectDateTime/select_date_time_bloc.dart';
import 'package:appointmentproject/model/schedule.dart';
import 'package:appointmentproject/ui/SelectDateTime/components/backgound.dart';
import 'package:appointmentproject/ui/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:appointmentproject/ui/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Professional professional;
    Schedule schedule;
    List<DateTime> timeSlots;
    int selectedIndex;
    String name;
    String phone;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                "Select date",
                style: TextStyle(fontSize: deviceWidth < 400 ? 15:20),
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
                listener: (context, state) {},
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
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    } else if (state is TimeSlotSelectedState) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Select time",
                          style: TextStyle(fontSize: 15),
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
                          fontSize: 15,
                        ),
                      ),
                    );
                  }else if(state is TimeSlotSelectedState){
                    return timeSlotBuilder(context, state.timeSlots, state.selectedIndex, state.professional, state.schedule);
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
                      Text("Enter Name"),
                      SizedBox(height: 5),
                      TextField(
                        decoration:InputDecoration(
                            hintText: "Name",
                            enabledBorder: OutlineInputBorder()
                        ) ,
                        onChanged: (text){
                          name = text;
                        },
                      ),
                      SizedBox(height: 15),
                      Text("Enter your phone number"),
                      SizedBox(height: 5),
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration:InputDecoration(
                            hintText: "Phone",
                            enabledBorder: OutlineInputBorder()
                        ) ,
                        onChanged: (text){
                          phone = text;
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),

                  RoundedButton(
                    text: "Book appointment",
                    width: 300,
                    height: 55,
                    fontSize: 20,
                    color: Colors.blue,
                    textColor: Colors.white,
                    press: (){
                    print("button pressed");
                    print(name);
                    print(phone);
                  },)
                ],
              ),


            ],
          ),
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
}
