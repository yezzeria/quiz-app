import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const buttonWhite = Color.fromRGBO(255, 255, 255, 1);

ThemeData get theme {
  final theme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 48, 47, 45),
    colorScheme: ColorScheme.fromSeed(
      seedColor: buttonWhite,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
  return theme.copyWith(
    textTheme: GoogleFonts.russoOneTextTheme(theme.textTheme),
    primaryTextTheme: GoogleFonts.russoOneTextTheme(theme.primaryTextTheme),
  );
}
