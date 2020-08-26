import 'package:flutter/material.dart';

import '../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final String text;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child:Text(
            text,
            style: TextStyle(color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
