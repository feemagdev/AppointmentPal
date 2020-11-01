import 'package:flutter/material.dart';


class AddCustomTimeSlotBody extends StatefulWidget {
  @override
  _AddCustomTimeSlotBodyState createState() => _AddCustomTimeSlotBodyState();
}

class _AddCustomTimeSlotBodyState extends State<AddCustomTimeSlotBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Time Slot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10,),
                  Text("Add Time Slot"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
