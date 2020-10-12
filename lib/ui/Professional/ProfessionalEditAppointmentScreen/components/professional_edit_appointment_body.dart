import 'package:appointmentproject/BLoC/ProfessionalBloc/ProfessionalEditAppointment/professional_edit_appointment_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Client/SelectDateTime/components/custom_date.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProfessionalEditAppointmentBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professional _professional;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("Select date"),
          SizedBox(
            height: 10,
          ),
          CustomDateView(
            onTap: (DateTime dateTime) {
              BlocProvider.of<ProfessionalEditAppointmentBloc>(context).add(
                  ProfessionalShowSelectedDayAppointmentsEvent(
                      professional: _professional, dateTime: dateTime));
            },
          ),
          SizedBox(
            height: 10,
          ),
          BlocListener<ProfessionalEditAppointmentBloc,
              ProfessionalEditAppointmentState>(
            listener: (context, state) {
              if (state is ProfessionalAppointmentIsSelectedState) {
                navigateToSelectNewTimeScreen(
                    context, state.appointment, state.professional);
              }
            },
            child: BlocBuilder<ProfessionalEditAppointmentBloc,
                ProfessionalEditAppointmentState>(
              builder: (context, state) {
                if (state is ProfessionalEditAppointmentInitial) {
                  _professional = state.professional;
                  return loadingState(context, state.professional);
                } else if (state
                    is ProfessionalShowSelectedDayAppointmentsState) {
                  return appointmentsBuilder(
                      context, state.appointments, state.professional);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingState(BuildContext context, Professional professional) {
    BlocProvider.of<ProfessionalEditAppointmentBloc>(context).add(
        ProfessionalShowSelectedDayAppointmentsEvent(
            professional: professional, dateTime: null));
    return Container();
  }

  Widget appointmentUI(BuildContext context, Appointment appointment,
      Professional professional) {
    return InkWell(
        onTap: () {
          BlocProvider.of<ProfessionalEditAppointmentBloc>(context).add(
              ProfessionalEditAppointmentSelectedEvent(
                  appointment: appointment, professional: professional));
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
                              appointment.getAppointmentDateTime().toDate())),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Client",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(appointment.getClientName()),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(DateFormat.jm().format(
                                appointment.getAppointmentDateTime().toDate())),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Client contact",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(appointment.getClientPhone()),
                          ])
                    ]))));
  }

  Widget appointmentsBuilder(BuildContext context,
      List<Appointment> appointments, Professional professional) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appointments.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 7, top: 10, left: 7),
        child: appointmentUI(context, appointments[index], professional),
      ),
    );
  }

  navigateToSelectNewTimeScreen(BuildContext context, Appointment appointment,
      Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(
          appointment: appointment, professional: professional);
    }));
  }
}
