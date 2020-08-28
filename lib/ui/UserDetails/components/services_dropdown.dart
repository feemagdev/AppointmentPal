import 'package:appointmentproject/model/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DropDownServices extends StatelessWidget {
  final List<Service> services;
  DropDownServices({@required this.services});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Body(services: services),
    );
  }
}

class Body extends StatefulWidget {
  final List<Service> services;

  Body({@required this.services});

  @override
  _BodyState createState() => _BodyState(services: services);
}

class _BodyState extends State<Body> {
  final List<Service> services;
  List<DropdownMenuItem<Service>> list;
  Service selectedService;
  _BodyState({@required this.services});

  @override
  void initState() {
    super.initState();
    list = buildDropDownMenuItems(services);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200]))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
    //        Text("select need"),
            DropdownButtonHideUnderline(
              child: DropdownButton<Service>(
                isExpanded: false,
                hint: Text("select need"),
                value: selectedService,
                items: list,
                onChanged: (value){
                  setState(() {
                    selectedService = value;
                  });
                },
              ),

            ),
          ],
        ));
  }

  List<DropdownMenuItem<Service>> buildDropDownMenuItems(List<Service> services) {
    List<DropdownMenuItem<Service>> items = List();
    for (Service listItem in services) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.getName()),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
