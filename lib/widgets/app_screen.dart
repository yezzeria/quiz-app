import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  final Widget child;
  final bool isFractionNeeded;
  const AppScreen({Key? key, required this.child, this.isFractionNeeded = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (Navigator.canPop(context))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24.0,
                  ),
                ),
              ),
            Center(
              child: FractionallySizedBox(
                widthFactor: isFractionNeeded ? 0.8 : 1,
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
