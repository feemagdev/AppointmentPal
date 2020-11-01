
import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalDashboardBloc/professional_dashboard_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/components/category_card.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditAppointmentScreen/professional_edit_appointment_screen.dart';
import 'package:appointmentproject/ui/Professional/SettingScreen/setting_screen.dart';
import 'package:appointmentproject/ui/Professional/TodayAppointmentScreen/today_appointment_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalDashboardBody extends StatelessWidget {

  final Professional professional;
  ProfessionalDashboardBody({@required this.professional});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocListener<ProfessionalDashboardBloc, ProfessionalDashboardState>(
              listener: (context, state) {
                if(state is  ProfessionalAddAppointmentState){
                  navigateToAddAppointmentScreen(context, state.professional);
                }else if(state is ProfessionalEditAppointmentState){
                  navigateToEditAppointmentScreen(context, state.professional);
                }else if(state is ProfessionalTodayAppointmentState){
                  navigateToTodayAppointmentScreen(context,state.professional);
                }else if(state is ProfessionalSettingState){
                  navigateToProfessionalSettingScreen(context,state.professional);
                }
              },
              child: BlocBuilder<ProfessionalDashboardBloc, ProfessionalDashboardState>(
                  builder: (context, state) {
                    if (state is ProfessionalDashboardInitial) {
                      return Container();
                    }
                    return Container();
                  }),
            ),
            SizedBox(height: deviceHeight * 0.10,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1,
                    Text(
                      "welcome "+ professional.getName(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: deviceWidth < 360 ? 15:20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            Expanded(
                child: createGrid(context)

            )


          ],
        )


    );
  }



  Widget createGrid(BuildContext context){

    int count = 2;
    Size size = MediaQuery.of(context).size;
    if(size.width > 600){
      count = 3;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60))),
      child: Padding(
        padding: EdgeInsets.only(left: 30,right: 30,top: 10),

        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:count,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: 1.0,
          ),
          children: <Widget>[

            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/add_appointment.svg",title: "add appointment",onTap: () {addAppointmentTap(context);})),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/edit_appointment.svg",title: "edit appointment",onTap: (){editAppointmentTap(context);},)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/payment.svg",title: "payment",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/history.svg",title: "history",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/today.svg",title: "today",onTap: (){todayAppointmentTap(context);},)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/setting.svg",title: "setting",onTap: (){settingTap(context);},)),
          ],
        ),
      ),
    );
  }


  void addAppointmentTap(BuildContext context){
    BlocProvider.of<ProfessionalDashboardBloc>(context).add(ProfessionalAddAppointmentEvent(professional:professional));
  }

  void editAppointmentTap(BuildContext context){
    BlocProvider.of<ProfessionalDashboardBloc>(context).add(ProfessionalEditAppointmentEvent(professional:professional));
  }

  void todayAppointmentTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context).add(ProfessionalTodayAppointmentEvent(professional:professional));
  }

  void settingTap(BuildContext context) {
    BlocProvider.of<ProfessionalDashboardBloc>(context).add(ProfessionalSettingEvent(professional:professional));
  }



  void navigateToAddAppointmentScreen(BuildContext context,Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(professional: professional);
    }));
  }

  void navigateToEditAppointmentScreen(BuildContext context,Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalEditAppointmentScreen(professional: professional);
    }));
  }

  void navigateToTodayAppointmentScreen(BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodayAppointmentScreen(professional: professional);
    }));
  }

  void navigateToProfessionalSettingScreen(BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SettingScreen(professional: professional);
    }));
  }









}
