import 'package:flutter/material.dart';

// Colors
const Color optionNotAvailableColor = Colors.black26;
// light theme
const Color snow = Color(0xFFF2F2F8);
const Color success = Color(0xFF81AC5D);
const Color lightBlue = Color(0xFF2A2A50);
const Color greyBlue = Color(0xFF161627);
const Color darkestBlue = Color(0xFF151528);
const Color veryDarkBlue = Color(0xFF0F0E1B);
const Color marianBlue = Color(0xFF464686);
//dark theme
const Color pennRed = Color(0xFF970e0e);
const Color maize = Color(0xFFf3e760);
const Color oxfordBlue = Color(0xFF011936);
const Color taupeGrey = Color(0xFF897C80);
const Color pigmentGreen = Color(0xFF469B46);

// Sizes
const double edgeInsets = 16.0;

const double inputScreenTitleMT = 100.0;
const double inputScreenTitleMB = 40.0;
const double inputScreenCodeMB = 20.0;
const double inputScreenCodeTextSize = 32.0;
const double inputScreenCodeLetterSpacing = 2.0;

const double keypadWidth = 280.0;
const double colorKeypadWidth = 300.0;
const double keypadHeight = 380.0;
const double defaultSpaceBtwElements = 20.0;
const double colorBubbleSize = 60.0;

const double submitAndBackSpace = 40;
const double backspaceMR = 45;

const double qrSize = 200.0;

const double pointsMT = 10.0;
const double pointsMR = 10.0;
const double pointsEdgeInset = 10.0;
const double pointsBoxOpacity = 0.8;
const double progressLineHeight = 5;
const double progressLineWidth = 100;

const double pointsBadgeMT = 85;
double pointsBadgeML(Size screen) {return screen.width / 2 + 70;}
const double pointsBadgeOpacity = 0.9;
const double borderRadius = 15;

const int numberOfConnectedServices = 3;

// Animations
const int shakeDelay = 500;
const int shakeDuration = 400;
const int addedPointsDuration = 3;
const int successDuration = 5;

// Keys
const String themePreferenceKey = 'isDarkTheme';
