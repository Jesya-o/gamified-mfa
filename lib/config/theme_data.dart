import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mfa_gamification/config/config.dart';

import '../util/bubble_colors.dart';
import '../util/custom_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  indicatorColor: lightBlue,
  cardColor: marianBlue,
  fontFamily: GoogleFonts.figtree().fontFamily,
  extensions: <ThemeExtension<dynamic>>[
    const BubbleColors(
      bubbleColor1: Color(0xFF9e0142),
      bubbleColor2: Color(0xFFd53e4f),
      bubbleColor3: Color(0xFFf46d43),
      bubbleColor4: Color(0xFFfdae61),
      bubbleColor5: Color(0xFFfee08b),
      bubbleColor6: Color(0xFFe6f598),
      bubbleColor7: Color(0xFFabdda4),
      bubbleColor8: Color(0xFF66c2a5),
      bubbleColor9: Color(0xFF3288bd),
      bubbleColor0: Color(0xFF5e4fa2),
    ),
    const CustomColors(
        successColor: success,
        pointsBoxColor: greyBlue,
        pointsProgressLineColor: success,
        pointsProgressLineBackgroundColor: snow),
  ],
  appBarTheme: AppBarTheme(
    elevation: 0, // No separation
    titleTextStyle: TextStyle(
      color: veryDarkBlue,
      fontSize: 20,
      fontFamily: GoogleFonts.figtree().fontFamily,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: lightBlue),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: lightBlue),
    bodyLarge: TextStyle(fontSize: 18, color: lightBlue),
    bodyMedium: TextStyle(fontSize: 16, color: lightBlue),
    bodySmall: TextStyle(color: veryDarkBlue),
    labelLarge: TextStyle(fontSize: 16, color: snow),
    labelMedium: TextStyle(fontSize: 14, color: snow),
    displayLarge: TextStyle(
        color: snow,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    displayMedium: TextStyle(
        color: snow,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: snow)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkestBlue,
    foregroundColor: snow,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  indicatorColor: oxfordBlue,
  cardColor: maize,
  fontFamily: GoogleFonts.almendra().fontFamily,
  scaffoldBackgroundColor: pennRed,
  extensions: <ThemeExtension<dynamic>>[
    const BubbleColors(
      bubbleColor1: Color(0xFFBAA5FF),
      bubbleColor2: Color(0xFF63595C),
      bubbleColor3: Color(0xFF0E9797),
      bubbleColor4: Color(0xFFB3D89C),
      bubbleColor5: Color(0xFFFE5F55),
      bubbleColor6: Color(0xFFF34213),
      bubbleColor7: Color(0xFFFAF3DD),
      bubbleColor8: Color(0xFF481620),
      bubbleColor9: Color(0xFF050401),
      bubbleColor0: Color(0xFF2F4B26),
    ),
    const CustomColors(
        successColor: pigmentGreen,
        pointsBoxColor: oxfordBlue,
        pointsProgressLineColor: pigmentGreen,
        pointsProgressLineBackgroundColor: taupeGrey),
  ],
  appBarTheme: AppBarTheme(
    elevation: 0, // No separation
    titleTextStyle: TextStyle(
      color: maize,
      fontSize: 20,
      fontFamily: GoogleFonts.almendra().fontFamily,
    ),
    backgroundColor: pennRed,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: snow),
    titleMedium: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: maize),
    bodyLarge: TextStyle(fontSize: 18, color: maize),
    bodyMedium: TextStyle(fontSize: 16, color: maize),
    bodySmall: TextStyle(color: veryDarkBlue),
    labelLarge: TextStyle(fontSize: 16, color: snow),
    labelMedium: TextStyle(fontSize: 14, color: snow),
    displayLarge: TextStyle(
        color: pennRed,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
    displayMedium: TextStyle(
        color: pennRed,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: maize,
        backgroundColor: oxfordBlue,
        // textStyle: TextStyle(color: pennRed)
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: oxfordBlue,
    foregroundColor: snow,
  ),
);
