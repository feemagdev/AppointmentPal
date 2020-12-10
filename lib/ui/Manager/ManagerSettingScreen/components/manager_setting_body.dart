import 'package:appointmentproject/bloc/ManagerBloc/ManagerSettingScreenBloc/manager_setting_screen_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Manager/ManagerProfile/manager_profile_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalPaymentScreen/professional_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManagerSettingScreenBody extends StatefulWidget {
  @override
  _ManagerSettingScreenBodyState createState() =>
      _ManagerSettingScreenBodyState();
}

class _ManagerSettingScreenBodyState extends State<ManagerSettingScreenBody> {
  @override
  Widget build(BuildContext context) {
    final Manager _manager =
        BlocProvider.of<ManagerSettingScreenBloc>(context).manager;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Setting"),
            leading: IconButton(
              onPressed: () {
                navigateToManagerDashboardScreen(_manager, context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Stack(
            children: [
              BlocListener<ManagerSettingScreenBloc, ManagerSettingScreenState>(
                listener: (context, state) {
                  if (state is ManagerResetPasswordSuccess) {
                    successDialogAlert(
                        "Password reset email sent\nPlease also check your spam folder");
                  } else if (state is ManagerResetPasswordFailure) {
                    errorDialogAlert("Error occured please try again later");
                  } else if (state is ManagerSmsPaymentState) {
                    navigateToManagerSmsPayment(context, _manager);
                  } else if (state is ManagerSettingScreenProfileState) {
                    navigateToManagerProfileScreen(context, _manager);
                  }
                },
                child: BlocBuilder<ManagerSettingScreenBloc,
                    ManagerSettingScreenState>(
                  builder: (context, state) {
                    if (state is ManagerSettingScreenInitial) {
                      return settingBuilder(context);
                    } else if (state is ManagerSettingScreenLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return settingBuilder(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingBuilder(context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Reset Password",
              onTap: () {
                BlocProvider.of<ManagerSettingScreenBloc>(context)
                    .add(ManagerResetPasswordEvent());
              }),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "SMS Payment",
              onTap: () {
                BlocProvider.of<ManagerSettingScreenBloc>(context)
                    .add(ManagerSmsPaymentEvent());
              }),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Edit Profile",
              onTap: () {
                BlocProvider.of<ManagerSettingScreenBloc>(context)
                    .add(ManagerSettingScreenProfileEvent());
              }),
        ),
      ],
    );
  }

  Widget settingUI({text, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(Icons.arrow_forward_ios)],
        ),
      ),
    );
  }

  errorDialogAlert(String message) {
    Alert(
      context: this.context,
      type: AlertType.error,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  successDialogAlert(String message) {
    Alert(
      context: this.context,
      type: AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(this.context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  void navigateToManagerDashboardScreen(Manager manager, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(manager: manager);
    }));
  }

  void navigateToManagerSmsPayment(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalPaymentScreen(manager: manager);
    }));
  }

  void navigateToManagerProfileScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerProfileScreen(manager: manager);
    }));
  }
}
