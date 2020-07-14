import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 2,
              colors: [
                Color.fromRGBO(56, 178, 227, 1),
                Color.fromRGBO(56, 178, 227, 0.8),
                Color.fromRGBO(56, 178, 227, 0.7),
              ]
          )
      ),
      child: child,
    );
  }
}
