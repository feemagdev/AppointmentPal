import 'package:appointmentproject/bloc/ProfessionalBloc/TodayAppointment/today_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodayAppointmentScreenBody extends StatefulWidget {
  @override
  _TodayAppointmentScreenBodyState createState() =>
      _TodayAppointmentScreenBodyState();
}

class _TodayAppointmentScreenBodyState
    extends State<TodayAppointmentScreenBody> {
  @override
  Widget build(BuildContext context) {
    Professional professional =
        BlocProvider.of<TodayAppointmentBloc>(context).professional;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Today Appointments"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                navigateToProfessionalDashboard(context, professional);
              },
            ),
          ),
          body: Container(
            child: Column(
              children: [
                BlocListener<TodayAppointmentBloc, TodayAppointmentState>(
                  listener: (context, state) {},
                  child:
                      BlocBuilder<TodayAppointmentBloc, TodayAppointmentState>(
                    builder: (context, state) {
                      if (state is TodayAppointmentInitial) {
                        return loadingState(context);
                      } else if (state is GetAllTodayAppointmentState) {
                        if (state.appointments.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "No appointments for today",
                              style: TextStyle(fontSize: 17),
                            ),
                          );
                        }
                        return appointmentsBuilder(context, state.appointments,
                            professional, state.customers);
                      } else if (state is TodayAppointmentLoadingState) {
                        return loadingCircularBar();
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _markAppointmentCompleteUI(
      BuildContext context,
      Appointment appointment,
      Professional professional,
      Customer customer,
      int index) {
    return Stack(
      children: [
        Container(
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
                          Text(
                            "Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(DateFormat.yMMMMd().format(
                              appointment.getAppointmentStartTime().toDate())),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Customer",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(customer.getName()),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(DateFormat.jm().format(appointment
                                .getAppointmentStartTime()
                                .toDate())),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Customer contact",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(customer.getPhone()),
                          ]),
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: Align(
                              child: FloatingActionButton(
                                onPressed: () {
                                  BlocProvider.of<TodayAppointmentBloc>(context)
                                      .add(MarkAppointmentComplete(
                                          appointment: appointment));
                                },
                                child: Icon(Icons.check),
                                backgroundColor: Colors.lightBlue,
                                heroTag: "completeButton" +
                                    appointment
                                        .getAppointmentStartTime()
                                        .toString(),
                              ),
                              alignment: Alignment.topRight,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            child: Align(
                              child: FloatingActionButton(
                                onPressed: () {
                                  BlocProvider.of<TodayAppointmentBloc>(context)
                                      .add(MarkAppointmentCancel(
                                          appointment: appointment));
                                },
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                                heroTag: "cancelButton" +
                                    appointment
                                        .getAppointmentStartTime()
                                        .toString(),
                              ),
                              alignment: Alignment.topRight,
                            ),
                          ),
                        ],
                      )
                    ]))),
      ],
    );
  }

  Widget loadingCircularBar() {
    return Center(child: CircularProgressIndicator());
  }

  Widget appointmentsBuilder(
      BuildContext context,
      List<Appointment> appointments,
      Professional professional,
      List<Customer> customers) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appointments.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 7, top: 10, left: 7),
        child: _markAppointmentCompleteUI(context, appointments[index],
            professional, customers[index], index),
      ),
    );
  }

  Widget loadingState(BuildContext context) {
    BlocProvider.of<TodayAppointmentBloc>(context)
        .add(GetAllTodayAppointments());
    return Container();
  }

  void navigateToProfessionalDashboard(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }
}
