
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class DatePicker extends StatelessWidget {
  final DateTime dateTime;
  static DateTime selectedDate;
  DatePicker({@required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Body(dateTime: dateTime,),
    );
  }
}

class Body extends StatefulWidget {
  final DateTime dateTime;
  Body({@required this.dateTime});
  @override
  _MyHomePageState createState() => _MyHomePageState(dateTime: dateTime);
}

class _MyHomePageState extends State<Body> {
  TextEditingController dobTextController = TextEditingController();
   DateTime dateTime;
  _MyHomePageState({@required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: TextField(
        controller: dobTextController,
        onChanged: (value) {

        },
        onTap: () {
          showDatePicker(
              context: context,
              initialDate: dateTime == null ? DateTime.now() : dateTime,
              firstDate: DateTime(1970),
              lastDate: DateTime(2100)).then((value) {
                setState(() {
                  print(value);
                  if(value == null){
                    dobTextController.text = DateTime.now().toString();
                    DatePicker.selectedDate = null;
                  }else{
                    dobTextController.text = value.toString();
                    dateTime = value;
                    DatePicker.selectedDate = value;
                  }


                });
          });
        },

        decoration: InputDecoration(
            icon: Icon(Icons.date_range),
            hintText: "Select date",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}
