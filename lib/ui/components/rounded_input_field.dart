
import 'package:flutter/material.dart';



class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final Icon icon;
  final onPressed;
  final textController;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.onPressed,
    this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceWidth < 400 ? 50:70,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))
      ),
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        onTap: onPressed,
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
