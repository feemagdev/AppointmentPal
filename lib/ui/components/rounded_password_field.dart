import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
      ),
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none
        ),
      ),
    );
  }
}
