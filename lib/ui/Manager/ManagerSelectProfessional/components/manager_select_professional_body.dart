import 'package:appointmentproject/bloc/ManagerBloc/ManagerSelectProfessionalBloc/manager_select_professional_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerDashboard/manager_dashboard_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalAddAppointmentScreen/professional_select_date_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerSelectProfessionalBody extends StatefulWidget {
  @override
  _ManagerSelectProfessionalBodyState createState() =>
      _ManagerSelectProfessionalBodyState();
}

class _ManagerSelectProfessionalBodyState
    extends State<ManagerSelectProfessionalBody> {
  @override
  Widget build(BuildContext context) {
    List<Professional> professionals = List();
    List<Professional> filteredProfessionals = List();
    Manager manager =
        BlocProvider.of<ManagerSelectProfessionalBloc>(context).manager;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Professional"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToManagerDashboardScreen(context, manager);
          },
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          BlocListener<ManagerSelectProfessionalBloc,
              ManagerSelectProfessionalState>(
            listener: (context, state) {
              if (state is ManagerProfessionalSelectedState) {
                navigateToSelectDateTimeScreen(
                    context, state.professional, state.manager);
              }
            },
            child: BlocBuilder<ManagerSelectProfessionalBloc,
                ManagerSelectProfessionalState>(
              builder: (context, state) {
                if (state is ManagerAddAppointmentInitial) {
                  return getProfessionals(context);
                } else if (state is ManagerAddAppointmentLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
          ),
          BlocBuilder<ManagerSelectProfessionalBloc,
              ManagerSelectProfessionalState>(
            builder: (context, state) {
              if (state is GetProfessionalsListState) {
                professionals = state.professionals;
                filteredProfessionals = professionals;
                return Container(child: searchTextField(professionals));
              } else if (state is ProfessionalSearchingState) {
                professionals = state.professionalsList;
                filteredProfessionals = state.filteredList;
                return Container(child: searchTextField(professionals));
              }
              return Container();
            },
          ),
          BlocBuilder<ManagerSelectProfessionalBloc,
              ManagerSelectProfessionalState>(
            builder: (context, state) {
              if (state is GetProfessionalsListState) {
                return listOfProfessionals(filteredProfessionals);
              } else if (state is ProfessionalSearchingState) {
                return listOfProfessionals(filteredProfessionals);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget getProfessionals(context) {
    BlocProvider.of<ManagerSelectProfessionalBloc>(context)
        .add(GetProfessionalsListEvent());
    return Container();
  }

  Widget searchTextField(List<Professional> professionalsList) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by name or phone',
      ),
      onChanged: (string) {
        BlocProvider.of<ManagerSelectProfessionalBloc>(context).add(
            ProfessionalSearchingEvent(
                professionalsList: professionalsList, query: string));
        print("on change run");
      },
    );
  }

  Widget listOfProfessionals(List<Professional> filteredList) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              BlocProvider.of<ManagerSelectProfessionalBloc>(context).add(
                  ManagerProfessionalSelectedEvent(
                      professional: filteredList[index]));
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      filteredList[index].getName(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      filteredList[index].getPhone().toLowerCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToSelectDateTimeScreen(
      BuildContext context, Professional professional, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalSelectDateTimeScreen(
        professional: professional,
        manager: manager,
      );
    }));
  }

  void navigateToManagerDashboardScreen(BuildContext context, Manager manager) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerDashboardScreen(
        manager: manager,
      );
    }));
  }
}
