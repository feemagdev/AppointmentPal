
import 'package:appointmentproject/BLoC/UserRoleBloc/bloc.dart';
import 'package:appointmentproject/BLoC/ProfessionalBloc/bloc.dart';
import 'package:appointmentproject/BLoC/authBloc/auth_bloc.dart';
import 'package:appointmentproject/BLoC/authBloc/auth_event.dart';
import 'package:appointmentproject/BLoC/authBloc/auth_state.dart';
import 'package:appointmentproject/ui/Signup/signup_screen.dart';
import 'package:appointmentproject/ui/Welcome/welcome_screen.dart';
import 'package:appointmentproject/ui/helpers/check_user_role_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(SplashScreen());
  });

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc()..add(AppStartedEvent()),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context,state){
        if(state is UnAuthenticatedState){
          print("un-authenticated state");
          return SignUpScreen();
        } else if(state is AuthenticatedState){
          print("authenticated run");
          return BlocProvider(
            create: (context)=> UserRoleBloc()..add(CheckUserRoleEvent()),
            child: CheckUserRole(user: state.user),
          );
        }else{
          return Container();
        }
      },
    );
  }
}


class SplashScreen extends StatefulWidget{
  @override
  Splash createState() => Splash();
}
class Splash extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10),()=>{
      runMyApp()
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }

  runMyApp() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(new MyApp());
    });
  }

}

class Chawal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
      )
    );
  }

}