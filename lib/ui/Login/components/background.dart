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
                    Color.fromRGBO(21, 91, 111, 0.7),
                    Color.fromRGBO(21, 91, 111, 0.6),
                    Color.fromRGBO(21, 91, 111, 0.5),
                  ]
              )
          ),
      child: child,
    );
  }
}
