import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/app_screen.dart';

void switchScreen(BuildContext context, Widget widget,
    {bool isFractionNeeded = true}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => AppScreen(
        isFractionNeeded: isFractionNeeded,
        child: widget,
      ),
    ),
  );
}
