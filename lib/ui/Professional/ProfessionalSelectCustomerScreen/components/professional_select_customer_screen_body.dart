import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalSelectCustomerBloc/professional_select_customer_bloc.dart';
import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AppointmentBookingScreen/appointment_booking_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddNewCustomer/professional_add_new_customer_screen.dart';
import 'package:appointmentproject/ui/Professional/UpdateAppointmentScreen/update_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSelectCustomerScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final Professional professional =
        BlocProvider.of<ProfessionalSelectCustomerBloc>(context).professional;
    final DateTime appointmentStartTime =
        BlocProvider.of<ProfessionalSelectCustomerBloc>(context)
            .appointmentStartTime;
    final DateTime appointmentEndTime =
        BlocProvider.of<ProfessionalSelectCustomerBloc>(context)
            .appointmentEndTime;
    final Appointment appointment =
        BlocProvider.of<ProfessionalSelectCustomerBloc>(context).appointment;
    final Customer customer =
        BlocProvider.of<ProfessionalSelectCustomerBloc>(context).customer;
    final Manager manager =
        BlocProvider.of<ProfessionalSelectCustomerBloc>(context).manager;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Select Customer"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (appointment == null && manager == null) {
                  print("manager null");
                  BlocProvider.of<ProfessionalSelectCustomerBloc>(context).add(
                      MoveBackToSelectDateTimeScreenEvent(
                          professional: professional));
                } else if (appointment != null && manager == null) {
                  print("update appointment screen");
                  BlocProvider.of<ProfessionalSelectCustomerBloc>(context)
                      .add(MoveBackToUpdateAppointmentScreenEvent());
                } else if (appointment == null && manager != null) {
                  print("select date time");
                  navigateToSelectDateTimeScreen(
                      context, professional, manager);
                } else if (appointment != null && manager != null) {
                  navigateToUpdateAppointmentScreen(
                      context, professional, appointment, customer, manager);
                }
              },
            ),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        print("add customer button tapped");
                        BlocProvider.of<ProfessionalSelectCustomerBloc>(context)
                            .add(AddCustomerButtonPressedEvent());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: deviceWidth < 365 ? 15 : 25,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Customer",
                            style: TextStyle(
                                fontSize: deviceWidth < 365 ? 15 : 17,
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  BlocListener<ProfessionalSelectCustomerBloc,
                      ProfessionalSelectCustomerState>(
                    listener: (context, state) {
                      if (state is AddCustomerButtonPressedState) {
                        moveToAddNewCustomerScreen(
                            professional,
                            appointmentStartTime,
                            context,
                            appointmentEndTime,
                            appointment,
                            customer,
                            manager);
                      } else if (state is CustomerIsSelectedState) {
                        if (appointment == null) {
                          navigateToAppointmentBookingScreen(
                              professional,
                              manager,
                              state.customer,
                              appointmentStartTime,
                              appointmentEndTime,
                              context);
                        } else {
                          navigateToUpdateAppointmentScreen(
                              context,
                              professional,
                              appointment,
                              state.customer,
                              manager);
                        }
                      } else if (state is MoveBackToSelectDateTimeScreenState) {
                        navigateToAddAppointmentScreen(
                            context, state.professional);
                      }
                    },
                    child: BlocBuilder<ProfessionalSelectCustomerBloc,
                        ProfessionalSelectCustomerState>(
                      builder: (context, state) {
                        if (state is ProfessionalSelectCustomerInitial) {
                          return loadingState(context, professional,
                              appointmentStartTime, appointmentEndTime);
                        }
                        if (state
                            is ProfessionalSelectCustomerShowAllCustomerState) {
                          return customerUIBuilder(
                              state.customers,
                              context,
                              deviceWidth,
                              appointmentEndTime,
                              appointmentStartTime,
                              professional);
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
      ),
    );
  }

  Widget customerUIBuilder(
      List<Customer> customers,
      BuildContext context,
      double deviceWidth,
      DateTime appointmentEndTime,
      DateTime appointmentStartTime,
      Professional professional) {
    return ListView.builder(
        itemCount: customers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => customerUI(
            customers[index],
            deviceWidth,
            context,
            appointmentStartTime,
            appointmentEndTime,
            professional));
  }

  Widget customerUI(
      Customer customer,
      double deviceWidth,
      BuildContext context,
      DateTime appointmentStartTime,
      DateTime appointmentEndTime,
      Professional professional) {
    double fontSize = 12;
    double iconSize = 20;
    if (deviceWidth < 360) {
      fontSize = 17;
      iconSize = 25;
    }
    return Column(
      children: [
        InkWell(
          onTap: () {
            BlocProvider.of<ProfessionalSelectCustomerBloc>(context)
                .add(CustomerIsSelectedEvent(customer: customer));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  Text(
                    customer.getName(),
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  Text(
                    customer.getPhone(),
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey[500],
        )
      ],
    );
  }

  Widget loadingState(BuildContext context, Professional professional,
      DateTime appointmentStartTime, DateTime appointmentEndTime) {
    BlocProvider.of<ProfessionalSelectCustomerBloc>(context)
        .add(ProfessionalSelectCustomerShowAllCustomerEvent());
    return CircularProgressIndicator();
  }

  void moveToAddNewCustomerScreen(
      Professional professional,
      DateTime appointmentStartTime,
      BuildContext context,
      DateTime appointmentEndTime,
      Appointment appointment,
      Customer customer,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalAddNewCustomerScreen(
        professional: professional,
        appointmentStartTime: appointmentStartTime,
        appointmentEndTime: appointmentEndTime,
        appointment: appointment,
        customer: customer,
        manager: manager,
      );
    }));
  }

  void navigateToAppointmentBookingScreen(
      Professional professional,
      Manager manager,
      Customer customer,
      DateTime appointmentStartTime,
      DateTime appointmentEndTime,
      BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AppointmentBookingScreen(
          professional: professional,
          manager: manager,
          appointmentStartTime: appointmentStartTime,
          customer: customer,
          appointmentEndTime: appointmentEndTime);
    }));
  }

  void navigateToAddAppointmentScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(professional: professional);
    }));
  }

  void navigateToUpdateAppointmentScreen(
      BuildContext context,
      Professional professional,
      Appointment appointment,
      Customer customer,
      Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UpdateAppointmentScreen(
        professional: professional,
        appointment: appointment,
        customer: customer,
        manager: manager,
      );
    }));
  }

  void navigateToSelectDateTimeScreen(
      BuildContext context, Professional professional, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(
          professional: professional, manager: manager);
    }));
  }
}
