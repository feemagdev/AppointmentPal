
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomTextField extends StatefulWidget{

  final String hintText;
  final Icon icon;
  final TextEditingController textEditingController;

  CustomTextField({@required this.hintText,@required this.icon, @required this.textEditingController});


  @override
  Body createState() => Body(hintText: hintText,icon: icon,textEditingController: textEditingController);

}


class Body extends State<CustomTextField> {
  final String hintText;
  final Icon icon;
  final TextEditingController textEditingController;

  Body({@required this.hintText,@required this.icon, @required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            icon: icon,
            hintText:hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none
        ),
      ),
    );
  }
}
