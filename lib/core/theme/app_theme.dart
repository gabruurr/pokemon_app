import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      primary: const Color.fromARGB(255, 108, 158, 240),
    ),
    textTheme: GoogleFonts.pressStart2pTextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 4, 110, 87),
        foregroundColor: Colors.white),
    scaffoldBackgroundColor: const Color.fromARGB(255, 103, 179, 163),
    useMaterial3: true,
  );
}