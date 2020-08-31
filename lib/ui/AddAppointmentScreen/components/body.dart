import 'package:appointmentproject/BLoC/AddAppointmentBloc/add_appointment_bloc.dart';
import 'package:appointmentproject/BLoC/AddAppointmentBloc/add_appointment_event.dart';
import 'package:appointmentproject/BLoC/AddAppointmentBloc/add_appointment_state.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/backgound.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/custom_professional_showcase.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/services.dart';
import 'package:appointmentproject/ui/SelectDateTime/select_date_time.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/sub_services_ui.dart';

class Body extends StatelessWidget {
  final List<Service> servicesList;

  Body({
    @required this.servicesList,
  });

  @override
  Widget build(BuildContext context) {
    List<Professional> listOfProfessionals = [];
    List<SubServices> listOfSubServices = [];
    Service selectedService;
    SubServices selectedSubService;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Background(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                BlocListener<AddAppointmentBloc, AddAppointmentState>(
                  listener: (context, state) {
                    if (state is NavigateToBookAppointmentState){
                      navigateToAppointmentDateTimeScreen(context, state.professional, state.selectedService, state.selectedSubServices);
                    }
                  },
                  child: BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                      builder: (context, state) {
                        return Container();
                      }),
                ),
                SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Add Appointment",
                      style: TextStyle(
                        fontSize: deviceWidth < 400 ? 20 : 25,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "select a service",
                        style: TextStyle(
                          fontSize: deviceWidth < 400 ? 12 : 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                serviceListBuilder(context, deviceHeight),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                    builder: (context, state) {
                  if (state is LocationPermissionDeniedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(
                          "please give location permission", context);
                    });
                  }
                  return Container();
                }),
                BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                    builder: (context, state) {
                  if (state is TapOnServiceState) {
                    selectedSubService = null;
                    return selectSubServiceText(deviceWidth);
                  } else if (state is TapOnSubServiceState) {
                    return selectSubServiceText(deviceWidth);
                  } else if (state is NearByProfessionalsState) {
                    return selectSubServiceText(deviceWidth);
                  } else if (state is AllProfessionalsState) {
                    return selectSubServiceText(deviceWidth);
                  } else if (state is LocationPermissionDeniedState) {
                    return selectSubServiceText(deviceWidth);
                  }
                  return Container();
                }),
                BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                  builder: (context, state) {
                    if (state is TapOnServiceState) {
                      selectedService = state.selectedService;
                      return subServiceListBuilder(
                          context,
                          state.subServicesList,
                          state.selectedService,
                          deviceHeight);
                    } else if (state is TapOnSubServiceState) {
                      selectedService = state.selectedService;
                      selectedSubService = state.selectedSubService;
                      return subServiceListBuilder(
                          context,
                          state.subServicesList,
                          state.selectedService,
                          deviceHeight);
                    } else if (state is NearByProfessionalsState) {
                      return subServiceListBuilder(context, state.subServices,
                          state.selectedService, deviceHeight);
                    } else if (state is AllProfessionalsState) {
                      return subServiceListBuilder(context, state.subServices,
                          state.selectedService, deviceHeight);
                    } else if (state is LocationPermissionDeniedState) {
                      return subServiceListBuilder(context, state.subServices,
                          selectedService, deviceHeight);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RoundedButton(
                        text: "all professionals",
                        color: Color.fromRGBO(234, 245, 245, 1),
                        textColor: Color.fromRGBO(56, 178, 227, 1),
                        fontSize: deviceWidth < 400 ? 10 : 15,
                        width: deviceWidth < 400
                            ? deviceWidth * 0.4
                            : deviceWidth * 0.4,
                        height: deviceWidth < 400
                            ? deviceHeight * 0.055
                            : deviceHeight * 0.055,
                        press: () {
                          if (selectedSubService == null) {
                            showErrorDialog(
                                "Please select a sub service", context);
                            return;
                          }
                          BlocProvider.of<AddAppointmentBloc>(context).add(
                              AllProfessionalsEvent(
                                  professionals: listOfProfessionals,
                                  subServices: listOfSubServices,
                                  selectedService: selectedService,
                                  selectedSubService: selectedSubService));
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RoundedButton(
                          text: "nearby professionals",
                          color: Color.fromRGBO(234, 245, 245, 1),
                          textColor: Color.fromRGBO(56, 178, 227, 1),
                          fontSize: deviceWidth < 400 ? 10 : 15,
                          width: deviceWidth < 400
                              ? deviceWidth * 0.35
                              : deviceWidth * 0.4,
                          height: deviceWidth < 400
                              ? deviceHeight * 0.055
                              : deviceHeight * 0.055,
                          press: () {
                            if (selectedSubService == null) {
                              showErrorDialog(
                                  "Please select a sub service", context);
                              return;
                            }
                            BlocProvider.of<AddAppointmentBloc>(context).add(
                                NearByProfessionalsEvent(
                                    professionals: listOfProfessionals,
                                    subServices: listOfSubServices,
                                    selectedService: selectedService,
                                    selectedSubService: selectedSubService));
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                    builder: (context, state) {
                      if (state is TapOnSubServiceState) {
                        listOfProfessionals = state.professionals;
                        listOfSubServices = state.subServicesList;
                        List<double> nullDistance =
                            new List(listOfProfessionals.length);
                        return professionalListBuilder(
                            context,
                            state.professionals,
                            nullDistance,
                            deviceHeight,
                            deviceWidth,
                        selectedService,
                        selectedSubService);
                      } else if (state is NearByProfessionalsState) {
                        return professionalListBuilder(
                            context,
                            state.professionals,
                            state.distances,
                            deviceHeight,
                            deviceWidth,
                            selectedService,
                            selectedSubService);
                      } else if (state is AllProfessionalsState) {
                        List<double> distances =
                            new List(state.professionals.length);
                        return professionalListBuilder(
                            context,
                            state.professionals,
                            distances,
                            deviceHeight,
                            deviceWidth,
                            selectedService,
                            selectedSubService);
                      } else if (state is LocationPermissionDeniedState) {
                        List<double> distances =
                            new List(state.professionals.length);
                        return professionalListBuilder(
                            context,
                            state.professionals,
                            distances,
                            deviceHeight,
                            deviceWidth,
                            selectedService,
                            selectedSubService);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget serviceListBuilder(BuildContext context, double deviceHeight) {
    return Container(
      height: deviceHeight * 0.14,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: servicesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Services(
            svgSrc: servicesList[index].getImage(),
            title: servicesList[index].getName(),
            onTap: () {
              BlocProvider.of<AddAppointmentBloc>(context)
                  .add(TapOnServiceEvent(selectedService: servicesList[index]));
            },
          ),
        ),
      ),
    );
  }

  Widget subServiceListBuilder(BuildContext context, List<SubServices> list,
      Service selectedService, double deviceHeight) {
    return Container(
      height: deviceHeight * 0.1,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: SubServicesUI(
            title: list[index].getName(),
            svgSrc: list[index].getImage(),
            onTap: () {
              BlocProvider.of<AddAppointmentBloc>(context).add(
                  TapOnSubServiceEvent(
                      selectedService: selectedService,
                      selectedSubService: list[index]));
            },
          ),
        ),
      ),
    );
  }

  Widget professionalListBuilder(
      BuildContext context,
      List<Professional> list,
      List<double> distance,
      double deviceHeight,
      double deviceWidth,
      Service selectedService,
      SubServices selectedSubService) {
    if (list.length == 0) {
      return Container(
        child: Center(
          child: Text("sorry no professionals found :( "),
        ),
      );
    } else {
      return Container(
        height: deviceHeight * 0.30,
        child: PageView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                  child: ProfessionalShowcase(
                    appointmentCharges: list[index].getAppointmentCharges(),
                    professionalName: list[index].getName(),
                    address: list[index].getAddress(),
                    subService: list[index].getSubServices().getName(),
                    experience: list[index].getExperience(),
                    professionalImage: list[index].getImage(),
                    distance: distance[index],
                    onTap: () {
                      print("tap on book appointment");
                      BlocProvider.of<AddAppointmentBloc>(context).add(
                          NavigateToBookAppointmentEvent(
                              professional: list[index],
                              selectedService: selectedService,
                              selectedSubServices: selectedSubService));
                    },
                  ),
                )),
      );
    }
  }

  showErrorDialog(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: () => {Navigator.of(context).pop()},
              )
            ],
          );
        });
  }

  Widget selectSubServiceText(double deviceWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "select a sub service",
        style: TextStyle(
          fontSize: deviceWidth < 400 ? 12 : 17,
          color: Colors.white,
        ),
      ),
    );
  }

  navigateToAppointmentDateTimeScreen(BuildContext context,Professional professional,Service service,SubServices subService) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SelectDateTime(professional: professional,service: service,subService: subService);
    }));
  }
}
