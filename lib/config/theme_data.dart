import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mfa_gamification/config/theme.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    fontFamily: GoogleFonts.figtree().fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0, // No separation
      titleTextStyle: TextStyle(
        color: Color(0xFF0F0E1B),
        fontSize: 20,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2A2A50)),
      titleMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2A2A50)),
      bodyLarge: TextStyle(fontSize: 18, color: Color(0xFF2A2A50)),
      bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF2A2A50)),
      bodySmall: TextStyle(color: Color(0xFF0F0E1B)),
      labelLarge: TextStyle(fontSize: 16, color: Color(0xFFF2F2F8)),
      labelMedium: TextStyle(fontSize: 14, color: Color(0xFFF2F2F8)),
      displayLarge: TextStyle(
          color: Color(0xFFF2F2F8),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none),
      displayMedium: TextStyle(
          color: Color(0xFFF2F2F8),
          fontSize: 14,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF7F3F5),
          textStyle: TextStyle(color: Color(0xFFF2F2F8))),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF161528),
      foregroundColor: Color(0xFFF2F2F8),
    ));

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[850],
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'OpenSans', // Alternate font
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
      bodySmall: TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[700],
        textStyle: TextStyle(color: Colors.white),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF161528),
      foregroundColor: Color(0xFFF2F2F8),
    ));
