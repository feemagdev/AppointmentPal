

import 'package:appointmentproject/BLoC/AuthBloc/auth_bloc.dart';
import 'package:appointmentproject/BLoC/AuthBloc/auth_event.dart';
import 'package:appointmentproject/ui/Welcome/components/background.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:appointmentproject/ui/helpers/login_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget{

  _Home createState() => _Home();
}


class _Home extends State<Body> {

  void initState (){
    super.initState();
    new Future.delayed(const Duration(seconds: 10),(){
      navigateToLoginHelper(context);
    });
  }
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    double titleSize = size.height*0.03;
    double subTitleSize = size.height*0.02;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: FadeAnimation(1,Image.asset("assets/images/logo2.png",height: size.height*.15,width:size.height*.15 ,))),
          FadeAnimation(
              1,
              Text(
                "Appointment Pal",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: titleSize,
                    color: Colors.white,
                    letterSpacing: 2
                ),
              )),
          SizedBox(height: size.height*0.01),
          FadeAnimation(
              1,
              Text(
                "Make your life easy !",
                style: TextStyle(color: Colors.white, fontSize: subTitleSize,fontWeight: FontWeight.w500),
              )),

        ],
      ),
    );
  }



  void navigateToLoginHelper(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return BlocProvider(
        create: (context)=>AuthBloc()..add(AppStartedEvent()),
        child: LoginHelper(),
      );
    }));
  }


}
