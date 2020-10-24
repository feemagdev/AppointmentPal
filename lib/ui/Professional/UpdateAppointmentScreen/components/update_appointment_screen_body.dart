import 'package:appointmentproject/bloc/ProfessionalBloc/UpdateAppointmentBloc/update_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditAppointmentScreen/professional_edit_appointment_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class UpdateAppointmentScreenBody extends StatefulWidget {
  @override
  _UpdateAppointmentScreenBodyState createState() =>
      _UpdateAppointmentScreenBodyState();
}

class _UpdateAppointmentScreenBodyState
    extends State<UpdateAppointmentScreenBody> {
  Professional professional;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Appointment"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            BlocProvider.of<UpdateAppointmentBloc>(context).add(MoveToEditAppointmentScreenEvent(professional:professional));
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            BlocListener<UpdateAppointmentBloc, UpdateAppointmentState>(
              listener: (context, state) {
                if (state is UpdateAppointmentDateTimeState) {
                  moveToSelectDateTimeScreen(
                      context, state.professional, state.appointment,
                      state.customer);
                }else if(state is MoveToEditAppointmentScreenState){
                  moveToEditAppointmentScreen(context,state.professional);
                }
              },
              child: BlocBuilder<UpdateAppointmentBloc, UpdateAppointmentState>(
                builder: (context, state) {
                  if (state is UpdateAppointmentInitial) {
                    professional = state.professional;
                    return appointmentBookingUI(
                        state.appointment, state.customer,
                        state.professional, deviceWidth);
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

  Widget appointmentBookingUI(Appointment appointment, Customer customer,
      Professional professional, double deviceWidth) {
    double fontSize = 12;
    double iconSize = 20;
    if (deviceWidth < 360) {
      fontSize = 17;
      iconSize = 25;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<UpdateAppointmentBloc>(context).add(
                  UpdateAppointmentDateTimeEvent(
                      professional: professional,
                      customer: customer,
                      appointment: appointment));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.access_time_outlined,
                          size: iconSize,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US').format(
                              appointment.getAppointmentStartTime().toDate()),
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat.jm().format(appointment
                                  .getAppointmentStartTime()
                                  .toDate()),
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: iconSize,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              DateFormat.jm().format(
                                  appointment.getAppointmentEndTime().toDate()),
                              style: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [Icon(Icons.arrow_forward_ios)],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Divider(),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person_outline,
                        size: iconSize,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer.getName()),
                      Text(customer.getPhone()),
                    ],
                  )
                ],
              ),
              Row(
                children: [Icon(Icons.arrow_forward_ios)],
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Divider(),
          SizedBox(
            height: 2,
          ),
          Center(
            child: RaisedButton(
              child: Text("Update Appointment"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void moveToSelectDateTimeScreen(BuildContext context,
      Professional professional, Appointment appointment, Customer customer) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (context){
        return ProfessionalSelectDateTimeScreen(professional: professional,appointment: appointment,customer:customer);
    }));
  }

  void moveToEditAppointmentScreen(BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ProfessionalEditAppointmentScreen(professional: professional);
    }));
  }
}