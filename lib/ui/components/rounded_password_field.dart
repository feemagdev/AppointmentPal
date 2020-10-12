import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceWidth < 365 ? 50:70,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
      ),
      child: TextField(
        obscureText: true,
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
