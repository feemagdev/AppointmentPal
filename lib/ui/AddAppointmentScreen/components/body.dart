import 'package:appointmentproject/BLoC/AddAppointmentBloc/add_appointment_bloc.dart';
import 'package:appointmentproject/BLoC/AddAppointmentBloc/add_appointment_event.dart';
import 'package:appointmentproject/BLoC/AddAppointmentBloc/add_appointment_state.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/service.dart';
import 'package:appointmentproject/model/sub_services.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/backgound.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/custom_professional_showcase.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/services.dart';
import 'package:appointmentproject/ui/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:appointmentproject/ui/AddAppointmentScreen/components/sub_services_ui.dart';

class Body extends StatelessWidget {
  final List<Service> servicesList;
  double deviceHeight;
  double deviceWidth;
  AddAppointmentBloc addAppointmentBloc;

  Body({
    @required this.servicesList,
  });

  @override
  Widget build(BuildContext context) {
    addAppointmentBloc = BlocProvider.of<AddAppointmentBloc>(context);
    List<Professional> listOfProfessionals = [];
    List<SubServices> listOfSubServices = [];
    String selectedService;
    String selectedSubService;
    String selectedProfessional;
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Background(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                    height: 25
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Add Appointment",
                      style: TextStyle(
                        fontSize:deviceWidth < 400 ? 20:25,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "select a service",
                        style: TextStyle(
                          fontSize:  deviceWidth < 400 ? 12:17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                serviceListBuilder(context),
                SizedBox(
                  height: 10,
                ),

                BlocBuilder<AddAppointmentBloc,AddAppointmentState>(builder: (context,state){
                  if (state is TapOnServiceState) {
                    return selectSubServiceText();
                  }else if(state is TapOnSubServiceState){
                    return selectSubServiceText();
                  }else if(state is NearByProfessionalsState){
                    return selectSubServiceText();
                  }else if(state is AllProfessionalsState){
                    return selectSubServiceText();
                  }return Container();
                }),
                BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                    builder: (context, state) {
                      if (state is TapOnServiceState) {
                        selectedService = state.selectedService;
                        return subServiceListBuilder(
                            context, state.subServicesList,state.selectedService);
                      }
                      else if(state is TapOnSubServiceState){
                        selectedService = state.selectedService;
                        selectedSubService = state.selectedSubService;
                        return subServiceListBuilder(context, state.subServicesList, state.selectedService);
                      }else if(state is NearByProfessionalsState){
                        return subServiceListBuilder(context, state.subServices, state.selectedService);
                      }else if(state is AllProfessionalsState){
                        return subServiceListBuilder(context, state.subServices, state.selectedService);
                      }return Container();
                    },
                ),
              ],
            ),
          ),
          Expanded(
              child:Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                       RoundedButton(
                         text: "all professionals",
                         color: Color.fromRGBO(234, 245, 245, 1),
                         textColor: Color.fromRGBO(56, 178, 227, 1),
                         fontSize: deviceWidth < 400 ? 10:15,
                         width: deviceWidth < 400 ? deviceWidth * 0.4: deviceWidth * 0.4,
                         height: deviceWidth < 400 ? deviceHeight * 0.05: deviceHeight * 0.055,
                         press: (){
                           addAppointmentBloc.add(AllProfessionalsEvent(
                               professionals:listOfProfessionals,
                               subServices: listOfSubServices,
                               selectedService:selectedService,
                               selectedSubService: selectedSubService));
                         },
                       ),
                        SizedBox(width: 20,),
                        RoundedButton(
                          text: "nearby professionals",
                          color: Color.fromRGBO(234, 245, 245, 1),
                          textColor: Color.fromRGBO(56, 178, 227, 1),
                          fontSize: deviceWidth < 400 ? 10:15,
                          width: deviceWidth < 400 ? deviceWidth * 0.35: deviceWidth * 0.4,
                          height: deviceWidth < 400 ? deviceHeight * 0.055: deviceHeight * 0.055,
                          press: () async{
                            if(await checkLocationPermission(context)){
                              showErrorDialog("please turn on gps", context);
                            }
                            else{
                              print('near by clicked');
                              addAppointmentBloc.add(NearByProfessionalsEvent(
                                  professionals:listOfProfessionals,
                                  subServices: listOfSubServices,
                              selectedService:selectedService,
                              selectedSubService: selectedSubService));
                            }
                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 40,),
                    BlocBuilder<AddAppointmentBloc, AddAppointmentState>(
                      builder: (context, state) {
                        if (state is TapOnSubServiceState) {
                          listOfProfessionals = state.professionals;
                          listOfSubServices = state.subServicesList;
                          List<double> nullDistance = new List(listOfProfessionals.length);
                          return professionalListBuilder(context, state.professionals,nullDistance);
                        }
                        else if(state is NearByProfessionalsState){
                          return professionalListBuilder(context, state.professionals,state.distances);
                        }else if(state is AllProfessionalsState){
                          List<double> distances = new List(state.professionals.length);
                          return professionalListBuilder(context, state.professionals,distances);
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget serviceListBuilder(BuildContext context) {
    return Container(
      height: deviceHeight * 0.14,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: servicesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Services(
            svgSrc: servicesList[index].image,
            title: servicesList[index].name,
            onTap: () {
              addAppointmentBloc.add(
                  TapOnServiceEvent(serviceID: servicesList[index].serviceID));
            },
          ),
        ),
      ),
    );
  }

  Widget subServiceListBuilder(BuildContext context, List<SubServices> list, String selectedService) {
    return Container(
      height: deviceHeight * 0.1,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child:
              SubServicesUI(title: list[index].name,
                svgSrc: list[index].image,
              onTap: (){
                addAppointmentBloc.add(TapOnSubServiceEvent(serviceID:selectedService,subServiceID: list[index].subServicesID));
              },),
        ),
      ),
    );
  }


  Widget professionalListBuilder(BuildContext context, List<Professional> list,List<double> distance) {
   return  Container(
     height: deviceHeight * 0.30,
     child: PageView.builder(
       itemCount: list.length,
       scrollDirection: Axis.horizontal,
         itemBuilder: (context, index) => Padding(
           padding:  EdgeInsets.only(left:deviceWidth*0.05,right: deviceWidth*0.05),
           child: ProfessionalShowcase(
             appointmentCharges: list[index].appointmentCharges,
             professionalName: list[index].name,
             address: list[index].address,
             subService: list[index].subServices.name,
             experience: list[index].experience,
             professionalImage: list[index].image,
             distance: distance[index],
           ),
         )
     ),
   );
  }



  Future<bool> checkLocationPermission(context) async{
    return !(await Geolocator().isLocationServiceEnabled());
  }


  showErrorDialog(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("Close"),
                onPressed: () => {
                  Navigator.of(context).pop()
                },
              )
            ],
          );
        });
  }

  Widget selectSubServiceText(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "select a sub service",
        style: TextStyle(
          fontSize: deviceWidth < 400 ? 12:17,
          color: Colors.white,
        ),
      ),
    );
  }


}

