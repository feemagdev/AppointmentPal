import 'package:appointmentproject/bloc/ManagerBloc/ManagerDashboardBloc/manager_dashboard_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerAddProfessional/manager_add_professional_screen.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/manager_select_professional_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/components/category_card.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:appointmentproject/ui/Professional/TodayAppointmentScreen/today_appointment_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerDashboardBody extends StatelessWidget {
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
                    svgSrc: "assets/icons/add_appointment.svg",
                    title: "add appointment",
                    onTap: () {
                      addAppointmentTap(context);
                    })),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/edit_appointment.svg",
                  title: "edit appointment",
                  onTap: () {
                    editAppointmentTap(context);
                  },
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/today.svg",
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
                  svgSrc: "assets/icons/history.svg",
                  title: "view professional",
                )),
            FadeAnimation(
                1.4,
                CategoryCard(
                  svgSrc: "assets/icons/setting.svg",
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
        manager: manager, route: "edit_appointment",);
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

  void navigateToAddProfessionalScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerAddProfessionalScreen(manager: manager);
    }));
  }
}
