import 'package:appointmentproject/bloc/ProfessionalBloc/SettingScreenBloc/setting_screen_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AutomaticBusinessHoursScreen/automatic_business_hours_screen.dart';
import 'package:appointmentproject/ui/Professional/ManualBusinessHoursScreen/manual_business_hours_weekday_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddNewCustomer/professional_add_new_customer_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalEditProfileScreen/professional_edit_profile_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalPaymentScreen/professional_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingScreenBody extends StatefulWidget {
  @override
  _SettingScreenBodyState createState() => _SettingScreenBodyState();
}

class _SettingScreenBodyState extends State<SettingScreenBody> {
  @override
  Widget build(BuildContext context) {
    final Professional _professional =
        BlocProvider.of<SettingScreenBloc>(context).professional;
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
                navigateToProfessionalDashboardScreen(_professional, context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Stack(
            children: [
              BlocListener<SettingScreenBloc, SettingScreenState>(
                listener: (context, state) {
                  if (state is AddCustomerState) {
                    navigateToAddCustomerScreen(context, _professional);
                  } else if (state is AutomatedScheduleState) {
                    navigateToAutomatedScheduleScreen(context, _professional);
                  } else if (state is ManualBusinessHoursState) {
                    navigateToManualBusinessHoursState(context, _professional);
                  } else if (state is ProfessionalEditProfileState) {
                    navigateToProfessionalEditProfileScreen(
                        context, _professional);
                  } else if (state is ProfessionalResetPasswordSuccess) {
                    successDialogAlert(
                        "Password reset email sent\nPlease also check your spam folder");
                  } else if (state is ProfessionalResetPasswordFailure) {
                    errorDialogAlert("Error occured please try again later");
                  } else if (state is ProfessionalSmsPaymentState) {
                    navigateToProfessionalPaymentScreen(context, _professional);
                  }
                },
                child: BlocBuilder<SettingScreenBloc, SettingScreenState>(
                  builder: (context, state) {
                    if (state is SettingScreenInitial) {
                      return settingBuilder(context, _professional);
                    } else if (state is ProfessionalSettingScreenLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return settingBuilder(context, _professional);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingBuilder(context, Professional professional) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Add Customer",
              onTap: () {
                BlocProvider.of<SettingScreenBloc>(context)
                    .add(AddCustomerEvent());
              }),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Automated Schedule",
              onTap: () {
                BlocProvider.of<SettingScreenBloc>(context)
                    .add(AutomatedScheduleEvent());
              }),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Manual Business Hours",
              onTap: () {
                BlocProvider.of<SettingScreenBloc>(context)
                    .add(ManualBusinessHoursEvent());
              }),
        ),
        professional.getManagerID() == null || professional.getManagerID() == ""
            ? Divider()
            : Container(),
        professional.getManagerID() == null || professional.getManagerID() == ""
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: settingUI(
                    text: "SMS Payment",
                    onTap: () {
                      BlocProvider.of<SettingScreenBloc>(context)
                          .add(ProfessionalSmsPaymentEvent());
                    }),
              )
            : Container(),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Edit Profile",
              onTap: () {
                BlocProvider.of<SettingScreenBloc>(context)
                    .add(ProfessionalEditProfileEvent());
              }),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Reset Password",
              onTap: () {
                BlocProvider.of<SettingScreenBloc>(context)
                    .add(ProfessionalResetPasswordEvent());
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

  void navigateToAddCustomerScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalAddNewCustomerScreen(professional: professional);
    }));
  }

  void navigateToAutomatedScheduleScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AutomaticBusinessHoursScreen(professional: professional);
    }));
  }

  void navigateToManualBusinessHoursState(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManualBusinessHoursWeekDayScreen(professional: professional);
    }));
  }

  void navigateToProfessionalDashboardScreen(
      Professional professional, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }

  void navigateToProfessionalEditProfileScreen(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalEditProfileScreen(professional: professional);
    }));
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

  void navigateToProfessionalPaymentScreen(context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalPaymentScreen(professional: professional);
    }));
  }
}
