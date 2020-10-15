import 'package:appointmentproject/BLoC/ClientBloc/ClientDashboardBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/Client/AddAppointmentScreen/add_appoinmtment_screen.dart';
import 'package:appointmentproject/ui/Client/ClientDashboard/components/category_card.dart';
import 'package:appointmentproject/ui/Client/ClientEditAppointmentScreen/client_edit_appointment_screen.dart';
import 'package:appointmentproject/ui/Client/SearchProfessioanl/search_professional_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class Body extends StatelessWidget {

  final FirebaseUser user;
  final Client client;
  Body({@required this.user,@required this.client});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    print(deviceWidth);
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<ClientDashboardBloc, ClientDashboardState>(
            listener: (context, state) {
              if (state is AddAppointmentScreenState) {
                List<Service> servicesList = state.serviceList;
                navigateToAddAppointmentScreen(context,servicesList,client,user);
              }
              if(state is EditAppointmentScreenState){
                navigateToEditAppointmentScreen(context, state.client);
              }
            },
            child: BlocBuilder<ClientDashboardBloc, ClientDashboardState>(
                builder: (context, state) {
                  if (state is InitialClientDashboardState) {
                    return Container();
                  } else if (state is AddAppointmentScreenState) {
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
                      "welcome "+ client.getName(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: deviceWidth < 400 ? 15:20,
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

  void navigateToSearchPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SearchProfessionalScreen();
    }));
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
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/today.svg",title: "today",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/setting.svg",title: "setting",)),
          ],
        ),
      ),
    );
  }


  void addAppointmentTap(BuildContext context){
    print("add appointment tap");
    BlocProvider.of<ClientDashboardBloc>(context).add(AddAppointmentEvent(client:client));
  }

  void editAppointmentTap(BuildContext context){
    BlocProvider.of<ClientDashboardBloc>(context).add(EditAppointmentEvent(client:client));
  }

  void navigateToAddAppointmentScreen(BuildContext context,List<Service> services,Client client,FirebaseUser user) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddAppointmentScreen(servicesList: services,client:client,user:user);
    }));
  }

  void navigateToEditAppointmentScreen(BuildContext context,Client client) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditAppointmentScreen(client:client);
    }));
  }








}