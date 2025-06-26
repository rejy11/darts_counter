import 'package:flutter/material.dart';

class BackgroundGradientContainer extends StatelessWidget {
  const BackgroundGradientContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.blue[800]!,
            Colors.indigo,
            Colors.deepPurple,
          ],
        ),
      ),
      child: child,
    );
  }
}
