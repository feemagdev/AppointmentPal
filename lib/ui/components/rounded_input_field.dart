
import 'package:flutter/material.dart';



class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final Icon icon;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]))
      ),
      child: TextField(
        onChanged: onChanged,
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
