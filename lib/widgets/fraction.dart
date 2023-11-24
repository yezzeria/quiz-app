import 'package:flutter/material.dart';

class Fraction extends StatelessWidget {
  const Fraction({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: child,
      ),
    );
  }
}
