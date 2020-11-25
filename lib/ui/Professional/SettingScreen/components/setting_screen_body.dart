import 'package:appointmentproject/bloc/ProfessionalBloc/SettingScreenBloc/setting_screen_bloc.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Professional/AutomaticBusinessHoursScreen/automatic_business_hours_screen.dart';
import 'package:appointmentproject/ui/Professional/ManualBusinessHoursScreen/manual_business_hours_weekday_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddNewCustomer/professional_add_new_customer_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreenBody extends StatefulWidget {
  @override
  _SettingScreenBodyState createState() => _SettingScreenBodyState();
}

class _SettingScreenBodyState extends State<SettingScreenBody> {
  @override
  Widget build(BuildContext context) {
    final Professional _professional =
        BlocProvider.of<SettingScreenBloc>(context).professional;
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        leading: IconButton(
          onPressed: () {
            navigateToProfessionalDashboardScreen(_professional, context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              BlocListener<SettingScreenBloc, SettingScreenState>(
                listener: (context, state) {
                  if (state is AddCustomerState) {
                    navigateToAddCustomerScreen(context, _professional);
                  } else if (state is AutomatedScheduleState) {
                    navigateToAutomatedScheduleScreen(context, _professional);
                  } else if (state is ManualBusinessHoursState) {
                    navigateToManualBusinessHoursState(context, _professional);
                  }
                },
                child: BlocBuilder<SettingScreenBloc, SettingScreenState>(
                  builder: (context, state) {
                    if (state is SettingScreenInitial) {
                      return settingBuilder(context);
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: settingUI(
              text: "Add Customer",
              onTap: () {
                print("add customer");
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
                print("goto automated schedule page");
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
                print("goto to manual business hours");
                BlocProvider.of<SettingScreenBloc>(context)
                    .add(ManualBusinessHoursEvent());
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
}
