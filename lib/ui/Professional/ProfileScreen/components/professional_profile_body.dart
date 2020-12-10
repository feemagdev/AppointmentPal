import 'package:appointmentproject/bloc/ProfessionalBloc/ProfessionalProfileBloc/professional_profile_bloc.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/ui/Manager/ManagerSelectProfessional/manager_select_professional_screen.dart';
import 'package:appointmentproject/ui/Professional/ProfessionalDashboard/professional_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalProfileBody extends StatefulWidget {
  @override
  _ProfessionalProfileBodyState createState() =>
      _ProfessionalProfileBodyState();
}

class _ProfessionalProfileBodyState extends State<ProfessionalProfileBody> {
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Professional _professional =
        BlocProvider.of<ProfessionalProfileBloc>(context).professional;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(children: [
                BlocListener<ProfessionalProfileBloc, ProfessionalProfileState>(
                  listener: (context, state) {
                    if (state is GetAllDataForProfileState) {
                      _addressController.text = _professional.getAddress();
                      _phoneController.text = _professional.getPhone();
                      _cityController.text = _professional.getCity();
                    }
                  },
                  child: BlocBuilder<ProfessionalProfileBloc,
                      ProfessionalProfileState>(
                    builder: (context, state) {
                      if (state is ProfessionalProfileInitial) {
                        BlocProvider.of<ProfessionalProfileBloc>(context)
                            .add(GetAllDataForProfileEvent());
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProfessionalProfileLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetAllDataForProfileState) {
                        Manager manager =
                            BlocProvider.of<ProfessionalProfileBloc>(context)
                                .manager;
                        return profileUpperPartUI(
                            _professional, state.email, manager);
                      }
                      return Container();
                    },
                  ),
                ),
                BlocBuilder<ProfessionalProfileBloc, ProfessionalProfileState>(
                  builder: (context, state) {
                    if (state is GetAllDataForProfileState) {
                      return profileLowerPartUI();
                    }
                    return Container();
                  },
                ),
              ]),
              BlocBuilder<ProfessionalProfileBloc, ProfessionalProfileState>(
                builder: (context, state) {
                  if (state is GetAllDataForProfileState) {
                    return profileCountersUI(state.completedAppointments,
                        state.canceledAppointments);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileCountersUI(int completed, int canceled) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.50,
      left: 35,
      right: 35,
      child: Container(
        padding:
            EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: Colors.grey.withOpacity(0.40))
            ]),
        height: 90,
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Tooltip(
                      message: "Completed Appointments",
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      completed.toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('Appointments',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0)),
                ),
                Text(
                  "Completed",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            VerticalDivider(
              thickness: 3.0,
              color: Colors.blue,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Tooltip(
                      message: "Canceled Appointments",
                      child: Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      canceled.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Text('Appointments', style: TextStyle(fontSize: 15.0)),
                Text(
                  "Canceled",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileLowerPartUI() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: professionalDetailsUI(),
      ),
    );
  }

  Widget profileUpperPartUI(
      Professional professional, String email, Manager manager) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  String route = 'profile';
                  if (manager == null) {
                    navigateToProfessionalDashboard(context, professional);
                  } else {
                    navigateToSelectProfessionalScreen(manager, route, context);
                  }
                }),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: new BorderRadius.all(new Radius.circular(50)),
              border: new Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child:
                professional.getImage() == null || professional.getImage() == ""
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                    : ClipOval(
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.fill,
                            placeholder: 'assets/images/logo2.png',
                            image: professional.getImage())),
          ),
          Text(
            professional.getName(),
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.white,
            ),
          ),
          Text(
            manager != null ? "" : email,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          )
        ],
      ),
    );
  }

  Widget professionalDetailsUI() {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: deviceHeight * 0.10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    readOnly: true,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    readOnly: true,
                    controller: _addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0, color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: deviceWidth < 365 ? 80 : 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "City",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    readOnly: true,
                    controller: _cityController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void navigateToProfessionalDashboard(
      BuildContext context, Professional professional) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ProfessionalDashboard(professional: professional);
    }));
  }

  void navigateToSelectProfessionalScreen(
      Manager manager, String route, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ManagerSelectProfessionalScreen(manager: manager, route: route);
    }));
  }
}
