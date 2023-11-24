import 'package:flutter/material.dart';
import 'package:quiz_app/dependencies.dart';
import 'package:quiz_app/quiz_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await Dependencies.init;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(QuizApp(
    dependencies: dependencies,
  ));
}
