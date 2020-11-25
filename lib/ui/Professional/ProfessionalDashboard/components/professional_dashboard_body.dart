import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalDashboardBloc/professional_dashboard_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/HistoryAppointmentScreen/history_appointment_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/components/category_card.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditAppointmentScreen/professional_edit_appointment_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfileScreen/professional_profile_screen.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:appointmentproject/ui/Professional/TodayAppointmentScreen/today_appointment_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalDashboardBody extends StatefulWidget {
  final Professional professional;
  ProfessionalDashboardBody({@required this.professional});

  @override
  _ProfessionalDashboardBodyState createState() =>
      _ProfessionalDashboardBodyState(professional: professional);
}

class _ProfessionalDashboardBodyState extends State<ProfessionalDashboardBody> {
  final Professional professional;
  _ProfessionalDashboardBodyState({@required this.professional});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                drawer: customDrawer(),
                body: Background(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BlocListener<ProfessionalDashboardBloc,
                        ProfessionalDashboardState>(
                      listener: (context, state) {
                        if (state is ProfessionalAddAppointmentState) {
                          navigateToAddAppointmentScreen(
                              context, state.professional);
                        } else if (state is ProfessionalEditAppointmentState) {
                          navigateToEditAppointmentScreen(
                              context, state.professional);
                        } else if (state is ProfessionalTodayAppointmentState) {
                          navigateToTodayAppointmentScreen(
                              context, state.professional);
                        } else if (state is ProfessionalSettingState) {
                          navigateToProfessionalSettingScreen(
                              context, state.professional);
                        } else if (state is ProfessionalHistoryState) {
                          navigateToProfessionalHistoryScreen(
                              context, state.professional);
                        }
                      },
                      child: BlocBuilder<ProfessionalDashboardBloc,
                              ProfessionalDashboardState>(
                          builder: (context, state) {
                        if (state is ProfessionalDashboardInitial) {
                          return Container();
                        }
                        return Container();
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            }),
                        GestureDetector(
                          onTap: () {
                            navigateToProfessionalProfileScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          professional.getImage()))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                            1,
                            Text(
                              "Hey, " + professional.getName(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: deviceWidth < 360 ? 12 : 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "What can we do\nfor you ?",
                          style: TextStyle(
                              fontSize: deviceWidth < 360 ? 20 : 30,
                              letterSpacing: 2),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(child: createGrid(context))
                  ],
                )))));
  }

  Widget createGrid(BuildContext context) {
    int count = 2;
    Size size = MediaQuery.of(context).size;
    if (size.width > 600) {
      count = 3;
    }

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(248, 249, 251, 1),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 0,
            mainAxisSpacing: 5,
            childAspectRatio: 1.0,
          ),
          children: <Widget>[
            FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(228, 229, 231, 1)),
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(228, 229, 231, 1)))),
                  child: CategoryCard(
                      svgSrc: "assets/icons/add.svg",
                      title: "Add\nAppointment",
                      onTap: () {
                        addAppointmentTap(context);
                      }),
                )),
            FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(228, 229, 231, 1)))),
                  child: CategoryCard(
                    svgSrc: "assets/icons/pencil_blue.svg",
                    title: "Edit\nAppointment",
                    onTap: () {
                      editAppointmentTap(context);
                    },
                  ),
                )),
            FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(228, 229, 231, 1)),
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(228, 229, 231, 1)))),
                  child: CategoryCard(
                    svgSrc: "assets/icons/client.svg",
                    title: "Client",
                  ),
                )),
            FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(228, 229, 231, 1)))),
                  child: CategoryCard(
                    svgSrc: "assets/icons/history2.svg",
                    title: "History",
                    onTap: () {
                      historyAppointmentTap(context);
                    },
                  ),
                )),
            FadeAnimation(
                1.4,
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    right: BorderSide(
                        width: 0.5, color: Color.fromRGBO(228, 229, 231, 1)),
                  )),
                  child: CategoryCard(
                    svgSrc: "assets/icons/check.svg",
                    title: "Today",
                    onTap: () {
                      todayAppointmentTap(context);
                    },
                  ),
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/setting2.svg",
                  title: "Setting",
                  onTap: () {
                    settingTap(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void addAppointmentTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context)
        .add(ProfessionalAddAppointmentEvent(professional: professional));
  }

  void editAppointmentTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context)
        .add(ProfessionalEditAppointmentEvent(professional: professional));
  }

  void todayAppointmentTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context)
        .add(ProfessionalTodayAppointmentEvent(professional: professional));
  }

  void settingTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context)
        .add(ProfessionalSettingEvent(professional: professional));
  }

  void historyAppointmentTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context)
        .add(ProfessionalHistoryEvent(professional: professional));
  }

  void navigateToAddAppointmentScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(professional: professional);
    }));
  }

  void navigateToEditAppointmentScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalEditAppointmentScreen(professional: professional);
    }));
  }

  void navigateToTodayAppointmentScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodayAppointmentScreen(professional: professional);
    }));
  }

  void navigateToProfessionalSettingScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen(professional: professional);
    }));
  }

  void navigateToProfessionalHistoryScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HistoryAppointmentScreen(professional: professional);
    }));
  }

  customDrawer() {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Container(
              padding: EdgeInsets.zero,
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(professional.getImage()))),
                    ),
                  ),
                  Text(
                    professional.getName(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
        ListTile(
          title: Text("Add Appointment"),
          onTap: () {
            navigateToAddAppointmentScreen(context, professional);
          },
        ),
        ListTile(
          title: Text("Edit Appointment"),
          onTap: () {
            navigateToEditAppointmentScreen(context, professional);
          },
        ),
        ListTile(
          title: Text("Appointment Status"),
          onTap: () {
            navigateToTodayAppointmentScreen(context, professional);
          },
        ),
        ListTile(
          title: Text("Client"),
          onTap: () {},
        ),
        ListTile(
          title: Text("History"),
          onTap: () {
            navigateToProfessionalHistoryScreen(context, professional);
          },
        ),
        ListTile(
          title: Text("Profile"),
          onTap: () {
            navigateToProfessionalProfileScreen(context);
          },
        ),
        ListTile(
          title: Text("Setting"),
          onTap: () {
            navigateToProfessionalSettingScreen(context, professional);
          },
        ),
        ListTile(
          title: Text("Log out"),
          onTap: () {},
        ),
      ],
    ));
  }

  void navigateToProfessionalProfileScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalProfileScreen(professional: professional);
    }));
  }
}
