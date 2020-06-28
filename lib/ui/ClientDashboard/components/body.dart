import 'package:appointmentproject/BLoC/ClientDashboardBloc/bloc.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/bottom_nav_bar.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/category_card.dart';
import 'package:appointmentproject/ui/ClientDashboard/components/search_bar.dart';
import 'package:appointmentproject/ui/SearchProfessioanl/search_professional_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class Body extends StatelessWidget {

  final FirebaseUser user;
  const Body({@required this.user});

  @override
  Widget build(BuildContext context) {
    ClientDashboardBloc clientDashboardBloc;
    clientDashboardBloc = BlocProvider.of<ClientDashboardBloc>(context);
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF241352),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: size.height*.11),
                    child: Center(
                      child: Text(
                          "What services are you looking for ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFDCD3DE),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                      ),
                    ),
                  ),
              BlocListener<ClientDashboardBloc,ClientDashboardState>(
                // ignore: missing_return
                listener: (context,state){
                  if(state is MoveToSearchScreenState){
                    navigateToSearchPage(context);
                  }
                  else{
                    return Container();
                  }
                },
                child: BlocBuilder<ClientDashboardBloc,ClientDashboardState>(
                  // ignore: missing_return
                    builder: (context,state){
                      if(state is MoveToSearchScreenState){
                        return Container();
                      }
                      else{
                        return Container();
                      }
                    }
                ),
              ),
                  SearchBar(
                    onTap: (){
                      clientDashboardBloc.add(SearchBarOnTapEvent());
                    },
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                      children: <Widget>[
                        CategoryCard(
                          title: "Make Appointment",
                          svgSrc: "assets/icons/add_appointment.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Update Appointment",
                          svgSrc: "assets/icons/update_appointment.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Pay for Appointment",
                          svgSrc: "assets/icons/pay_date.svg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "History of Appointment",
                          svgSrc: "assets/icons/history_appointment.svg",
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void navigateToSearchPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SearchProfessionalScreen();
    }));
  }
}
