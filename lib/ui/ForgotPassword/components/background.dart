import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, colors: [
        Color.fromRGBO(56, 178, 227, 1),
        Color.fromRGBO(56, 178, 227, 0.9),
        Color.fromRGBO(56, 178, 227, 0.8),
      ])),
      child: child,
    );
  }
}
