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
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Color.fromRGBO(59, 193, 226, 1),
                Color.fromRGBO(95, 193, 231, 1),
                Color.fromRGBO(131, 206, 236, 1),
              ]
          )
      ),
      child: child,
    );
  }
}
