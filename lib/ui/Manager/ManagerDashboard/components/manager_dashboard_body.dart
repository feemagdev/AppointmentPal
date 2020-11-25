import 'package:appointmentproject/bloc/ManagerBloc/ManagerDashboardBloc/manager_dashboard_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerAddProfessional/manager_add_professional_screen.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/manager_select_professional_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/components/category_card.dart';

import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerDashboardBody extends StatefulWidget {
  @override
  _ManagerDashboardBodyState createState() => _ManagerDashboardBodyState();
}

class _ManagerDashboardBodyState extends State<ManagerDashboardBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Manager _manager = BlocProvider.of<ManagerDashboardBloc>(context).manager;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                drawer: customDrawer(_manager),
                body: Background(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BlocListener<ManagerDashboardBloc, ManagerDashboardState>(
                      listener: (context, state) {
                        if (state is ManagerDashboardAddProfessionalState) {
                          navigateToAddProfessionalScreen(context, _manager);
                        } else if (state
                            is ManagerDashboardAddAppointmentState) {
                          navigateToAddAppointmentScreen(context, _manager);
                        } else if (state
                            is ManagerDashboardEditAppointmentState) {
                          navigateToEditAppointmentScreen(context, _manager);
                        }
                      },
                      child: BlocBuilder<ManagerDashboardBloc,
                          ManagerDashboardState>(builder: (context, state) {
                        if (state is ManagerDashboardInitial) {
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
                            navigateToManagerProfileScreen(context);
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
                                      image:
                                          NetworkImage(_manager.getImage()))),
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
                              "Hey, " + _manager.getName(),
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
                    Expanded(child: createGrid(context, _manager))
                  ],
                )))));
  }

  Widget createGrid(BuildContext context, Manager manager) {
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
                    svgSrc: "assets/icons/check.svg",
                    title: "View\nAppointment",
                    onTap: () {
                      viewAppointment(context);
                    },
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
                    svgSrc: "assets/icons/person.svg",
                    title: "Add\nProfessional",
                    onTap: () {
                      addProfessionalTap(context);
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
                    svgSrc: "assets/icons/client.svg",
                    title: "View\nProfessional",
                    onTap: () {
                      navigateToSelectProfessionalScreen(context, manager);
                    },
                  ),
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/setting2.svg",
                  title: "setting",
                  onTap: () {
                    settingTap(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  customDrawer(Manager manager) {
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
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(manager.getImage()))),
                    ),
                  ),
                  Text(
                    manager.getName(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
        ListTile(
          title: Text("Add Appointment"),
          onTap: () {
            navigateToAddAppointmentScreen(context, manager);
          },
        ),
        ListTile(
          title: Text("Edit Appointment"),
          onTap: () {
            navigateToEditAppointmentScreen(context, manager);
          },
        ),
        ListTile(
          title: Text("View Appointment"),
          onTap: () {
            viewAppointment(context);
          },
        ),
        ListTile(
          title: Text("Add Professional"),
          onTap: () {
            addProfessionalTap(context);
          },
        ),
        ListTile(
          title: Text("View Professional"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Setting"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Log out"),
          onTap: () {},
        ),
      ],
    ));
  }

  void addAppointmentTap(BuildContext context) {
    BlocProvider.of<ManagerDashboardBloc>(context)
        .add(ManagerDashboardAddAppointmentEvent());
  }

  void editAppointmentTap(BuildContext context) {
    BlocProvider.of<ManagerDashboardBloc>(context)
        .add(ManagerDashboardEditAppointmentEvent());
  }

  void viewAppointment(BuildContext context) {
    // BlocProvider.of<ProfessionalDashboardBloc>(context)
    //     .add(ProfessionalTodayAppointmentEvent(professional: professional));
  }

  void settingTap(BuildContext context) {
    // BlocProvider.of<ProfessionalDashboardBloc>(context)
    //     .add(ProfessionalSettingEvent(professional: professional));
  }

  void addProfessionalTap(BuildContext context) {
    BlocProvider.of<ManagerDashboardBloc>(context)
        .add(ManagerDashboardAddProfessionalEvent());
  }

  void navigateToAddAppointmentScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSelectProfessionalScreen(
        manager: manager,
        route: "add_appointment",
      );
    }));
  }

  void navigateToEditAppointmentScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSelectProfessionalScreen(
        manager: manager,
        route: "edit_appointment",
      );
    }));
  }

  void navigateToAddProfessionalScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerAddProfessionalScreen(manager: manager);
    }));
  }

  void navigateToManagerProfileScreen(BuildContext context) {}

  void navigateToSelectProfessionalScreen(
      BuildContext context, Manager manager) {
    String route = 'profile';
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSelectProfessionalScreen(manager: manager, route: route);
    }));
  }
}

/* class ManagerDashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Manager _manager = BlocProvider.of<ManagerDashboardBloc>(context).manager;
    return Scaffold(
      body: Background(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<ManagerDashboardBloc, ManagerDashboardState>(
            listener: (context, state) {
              if (state is ManagerDashboardAddProfessionalState) {
                navigateToAddProfessionalScreen(context, _manager);
              } else if (state is ManagerDashboardAddAppointmentState) {
                navigateToAddAppointmentScreen(context, _manager);
              } else if (state is ManagerDashboardEditAppointmentState) {
                navigateToEditAppointmentScreen(context, _manager);
              }
            },
            child: BlocBuilder<ManagerDashboardBloc, ManagerDashboardState>(
                builder: (context, state) {
              if (state is ManagerDashboardInitial) {
                return Container();
              }
              return Container();
            }),
          ),
          SizedBox(
            height: deviceHeight * 0.10,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Text(
                    "welcome " + _manager.getName(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: deviceWidth < 360 ? 15 : 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Expanded(child: createGrid(context))
        ],
      )),
    );
  }

  Widget createGrid(BuildContext context) {
    int count = 2;
    Size size = MediaQuery.of(context).size;
    if (size.width > 600) {
      count = 3;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60))),
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: 1.0,
          ),
          children: <Widget>[
            FadeAnimation(
                1.4,
                CategoryCard(
                    svgSrc: "assets/icons/add.svg",
                    title: "add appointment",
                    onTap: () {
                      addAppointmentTap(context);
                    })),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/pencil_blue.svg",
                  title: "edit appointment",
                  onTap: () {
                    editAppointmentTap(context);
                  },
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/check.svg",
                  title: "view appointment",
                  onTap: () {
                    viewAppointment(context);
                  },
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/add_professional.svg",
                  title: "add professional",
                  onTap: () {
                    addProfessionalTap(context);
                  },
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/history2.svg",
                  title: "view professional",
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/setting2.svg",
                  title: "setting",
                  onTap: () {
                    settingTap(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}    */
