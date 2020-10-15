import 'package:appointmentproject/BLoC/ClientBloc/EditAppointmentBloc/edit_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditAppointmentSelectDateTime/edit_appointment_select_date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Client _client;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("Select date"),
          SizedBox(height: 10,),
          CustomDateView(
            onTap: (DateTime dateTime) {
              BlocProvider.of<EditAppointmentBloc>(context).add(
                  ShowSelectedDayAppointmentsEvent(
                      client: _client, dateTime: dateTime));
            },
          ),
          SizedBox(height: 10,),
          BlocListener<EditAppointmentBloc, EditAppointmentState>(
            listener: (context, state) {
              if (state is AppointmentIsSelectedState) {
                navigateToSelectNewTimeScreen(context,state.appointment);
              }
            },
            child: BlocBuilder<EditAppointmentBloc, EditAppointmentState>(
              builder: (context, state) {
                if (state is EditAppointmentInitial) {
                  _client = state.client;
                  return loadingState(context, state.client);
                } else if (state is ShowSelectedDayAppointmentsState) {
                  return appointmentsBuilder(context, state.appointments);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingState(BuildContext context, Client client) {
    BlocProvider.of<EditAppointmentBloc>(context)
        .add(ShowSelectedDayAppointmentsEvent(client: client, dateTime: null));
    return Container();
  }

  Widget appointmentUI(BuildContext context,Appointment appointment) {
    return InkWell(
        onTap: () {
          BlocProvider.of<EditAppointmentBloc>(context).add(EditAppointmentSelectedEvent(appointment: appointment));
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date",
                            style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          Text(DateFormat.yMMMMd().format(appointment.getAppointmentDateTime().toDate())),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Service",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),),
                          Text(appointment.getServiceName()),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Professional",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          Text(appointment.getProfessionalName()),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("time",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                            Text(DateFormat.jm().format(appointment.getAppointmentDateTime().toDate())),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Sub Service",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                            Text(appointment.getSubServiceName()),
                            SizedBox(
                              height: 10,
                            ),
                            Text("professional contact",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                            Text(appointment.getProfessionalContact()),
                          ])
                    ]))));
  }

  Widget appointmentsBuilder(
      BuildContext context, List<Appointment> appointments) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: appointments.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 7, top: 10, left: 7),
          child: appointmentUI(
            context,
            appointments[index]
          ),
        ),
    );
  }

  navigateToSelectNewTimeScreen(BuildContext context,Appointment appointment){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalEditAppointmentNewDateTime(appointment:appointment);
    }));
  }


}
