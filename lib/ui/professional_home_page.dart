

import 'package:appointmentproject/BLoC/homePageBloc/home_page_bloc.dart';
import 'package:appointmentproject/BLoC/homePageBloc/home_page_event.dart';
import 'package:appointmentproject/BLoC/homePageBloc/home_page_state.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class ProfessionalHomePageParent extends StatelessWidget{
  final FirebaseUser user;
  ProfessionalHomePageParent({@required this.user});
  @override
  Widget build(BuildContext context) {
    print("professional home page parent email check");
    print(this.user.email);
    // TODO: implement build
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: HomePage(user: this.user),
    );
  }

}


class HomePage extends StatelessWidget {
  HomePageBloc homePageBloc;
  final FirebaseUser user;
  HomePage({@required this.user});
  @override
  Widget build(BuildContext context) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(this.user.email),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Text("Signout"),
              onPressed: () {
                homePageBloc.add(LogOutButtonPressed());
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text("home page from login"),
            ),
            BlocListener<HomePageBloc,HomePageState>(
              listener: (context,state){
                if(state is LogOutSuccessState){
                  navigateToSignUpPage(context);
                }
              },
              child: BlocBuilder<HomePageBloc,HomePageState>(
                // ignore: missing_return
                builder: (context,state){
                  if(state is LogOutInitialState){
                    return Container();
                  }else if(state is LogOutSuccessState){
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToSignUpPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SignUpScreen();
    }));
  }

}
