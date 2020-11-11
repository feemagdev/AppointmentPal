import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalEditAppointment/professional_edit_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/manager_select_professional_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/UpdateAppointmentScreen/update_appointment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfessionalEditAppointmentBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    Professional _professional =
        BlocProvider.of<ProfessionalEditAppointmentBloc>(context).professional;
    Manager _manager =
        BlocProvider.of<ProfessionalEditAppointmentBloc>(context).manager;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Appointment"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_manager == null) {
              BlocProvider.of<ProfessionalEditAppointmentBloc>(context)
                  .add(MoveToDashboardScreenFromEditAppointmentEvent());
            } else {
              navigateToManagerSelectProfessionalScreen(
                  context, _manager, "edit_appointment");
            }
          },
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Text(
                "Select date",
                style: TextStyle(fontSize: deviceWidth < 365 ? 12 : 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: CustomDateView(
                onTap: (DateTime dateTime) {
                  BlocProvider.of<ProfessionalEditAppointmentBloc>(context).add(
                      ProfessionalShowSelectedDayAppointmentsEvent(
                          dateTime: dateTime));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocListener<ProfessionalEditAppointmentBloc,
                ProfessionalEditAppointmentState>(
              listener: (context, state) {
                if (state is ProfessionalAppointmentIsSelectedState) {
                  navigateToUpdateAppointmentScreen(context, state.appointment,
                      _professional, state.customer, _manager);
                } else if (state
                    is MoveToDashboardScreenFromEditAppointmentState) {
                  navigateToDashboardScreen(context, _professional);
                }
              },
              child: BlocBuilder<ProfessionalEditAppointmentBloc,
                  ProfessionalEditAppointmentState>(
                builder: (context, state) {
                  if (state is ProfessionalEditAppointmentInitial) {
                    return loadingState(context);
                  } else if (state is ProfessionalEditAppointmentLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state
                      is ProfessionalShowSelectedDayAppointmentsState) {
                    if (state.appointments.isEmpty) {
                      return Text("No Appointment on this day");
                    }
                    return Expanded(
                      child: appointmentsBuilder(context, state.appointments,
                          _professional, state.customers),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingState(BuildContext context) {
    BlocProvider.of<ProfessionalEditAppointmentBloc>(context).add(
        ProfessionalShowSelectedDayAppointmentsEvent(dateTime: null));
    return Center(child: CircularProgressIndicator());
  }

  Widget appointmentUI(BuildContext context, Appointment appointment,
      Customer customer) {
    return InkWell(
        onTap: () {
          BlocProvider.of<ProfessionalEditAppointmentBloc>(context).add(
              ProfessionalEditAppointmentSelectedEvent(
                  appointment: appointment,
                  customer: customer));
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
                          ])
                    ]))));
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
        child: appointmentUI(
            context, appointments[index], customers[index]),
      ),
    );
  }

  navigateToUpdateAppointmentScreen(BuildContext context,
      Appointment appointment, Professional professional, Customer customer,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UpdateAppointmentScreen(
          appointment: appointment,
          professional: professional,
          customer: customer,
          manager: manager
      );
    }));
  }

  void navigateToDashboardScreen(BuildContext context,
      Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }

  void navigateToManagerSelectProfessionalScreen(BuildContext context,
      Manager manager, String route) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSelectProfessionalScreen(manager: manager, route: route);
    }));
  }
}
