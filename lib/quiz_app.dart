import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quiz_app/dependencies.dart';
import 'package:quiz_app/features/game/views/intro_screen.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/services.dart';
import 'package:quiz_app/theme/theme.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key, required this.dependencies});

  final Dependencies dependencies;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return Services(
      dependencies: widget.dependencies,
      child: MaterialApp(
        title: 'Quiz App',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: theme,
        home: IntroScreen(),
      ),
    );
  }
}
