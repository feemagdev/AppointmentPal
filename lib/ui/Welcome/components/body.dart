
import 'package:appointmentproject/ui/Welcome/components/background.dart';
import 'package:appointmentproject/ui/components/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {


  @override
  Widget build(BuildContext context){
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: FadeAnimation(1,Image.asset("assets/images/test.png",width: 200,height: 200,))),
          FadeAnimation(
              1,
              Text(
                "Appointment Pal",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: 1
                ),
              )),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
              1,
              Text(
                "Make your life easy !",
                style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }


}
