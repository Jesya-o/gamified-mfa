import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(
      elevation: 0, // No separation
      titleTextStyle: TextStyle(
        color: Color(0xFF0F0E1B),
        fontSize: 20,
        fontFamily: GoogleFonts.figtree().fontFamily,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Color(0xFF0F0E1B), fontFamily: GoogleFonts.figtree().fontFamily),
      bodySmall: TextStyle(color: Color(0xFF0F0E1B)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF7F3F5),
          textStyle: TextStyle(color: Color(0xFFF2F2F8))),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      focusColor: Colors.blue.shade50,
      hoverColor: Colors.blue.shade100,
      splashColor: Colors.blue,
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
      focusColor: Colors.blue,
      hoverColor: Colors.blue,
      splashColor: Colors.blue,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.blue,
    ));
