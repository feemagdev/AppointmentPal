import 'package:appointmentproject/BLoC/ClientDashboardBloc/bloc.dart';
import 'package:appointmentproject/model/client.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/add_appoinmtment_screen.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/background.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/category_card.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/search_bar.dart';
import 'package:appointmentproject/ui/SearchProfessioanl/search_professional_screen.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class Body extends StatelessWidget {

  final FirebaseUser user;
  final Client client;
  ClientDashboardBloc clientDashboardBloc;
  Body({@required this.user,@required this.client});

  @override
  Widget build(BuildContext context) {

    clientDashboardBloc = BlocProvider.of<ClientDashboardBloc>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocListener<ClientDashboardBloc, ClientDashboardState>(
            listener: (context, state) {
              if (state is AddAppointmentScreenState) {
                List<Service> servicesList = state.serviceList;
                navigateToAddAppointmentScreen(context,servicesList);
              }
            },
            child: BlocBuilder<ClientDashboardBloc, ClientDashboardState>(
              // ignore: missing_return
                builder: (context, state) {
                  if (state is InitialClientDashboardState) {
                    return Container();
                  } else if (state is AddAppointmentScreenState) {
                    return Container();
                  }
                }),
          ),
          SizedBox(height: height * 0.10,),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(1,
                  Text(
                      "welcome "+ client.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                FadeAnimation(1.2, SearchBar())
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

            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/add_appointment.svg",title: "add appointment",onTap: () {addAppointmentTap();})),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/edit_appointment.svg",title: "edit appointment",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/payment.svg",title: "payment",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/history.svg",title: "history",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/today.svg",title: "today",)),
            FadeAnimation(1.4, CategoryCard(svgSrc: "assets/icons/setting.svg",title: "setting",)),
          ],
        ),
      ),
    );
  }


  void addAppointmentTap(){
    print("add appointment tap");
    clientDashboardBloc.add(AddAppointmentEvent(client:client));
  }

  void navigateToAddAppointmentScreen(BuildContext context,List<Service> services) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddAppointmentScreen(servicesList: services);
    }));
  }








}
