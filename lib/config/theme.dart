import 'package:flutter/material.dart';

// Colors

Color successColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFF81AC5D);
}
Color pointsBoxColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFF161627);
}
Color textColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFFF2F2F8);
}
Color pointsProgressLineColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFF81AC5D);
}
Color pointsProgressLineBackgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFFF2F2F8);
}

Color keypadBackgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFFF7F3F5);
}
Color keypadTextColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF161528)
      : const Color(0xFF2A2A50);
}

const Color optionNotAvailableColor = Colors.black26;

// Bubble colors
const Color bubbleColor1 = Color(0xFF9e0142); // #9e0142
const Color bubbleColor2 = Color(0xFFd53e4f); // #d53e4f
const Color bubbleColor3 = Color(0xFFf46d43); // #f46d43
const Color bubbleColor4 = Color(0xFFfdae61); // #fdae61
const Color bubbleColor5 = Color(0xFFfee08b); // #fee08b
const Color bubbleColor6 = Color(0xFFe6f598); // #e6f598
const Color bubbleColor7 = Color(0xFFabdda4); // #abdda4
const Color bubbleColor8 = Color(0xFF66c2a5); // #66c2a5
const Color bubbleColor9 = Color(0xFF3288bd); // #3288bd
const Color bubbleColor0 = Color(0xFF5e4fa2); // #5e4fa2

// Sizes
const double edgeInsets = 16.0;

const double titleTextSize = 18.0;
const double headingTextSize = 24.0;
const double regularTextSize = 16.0;
const double smallTextSize = 14.0;
const double badgeTextSize = 12.0;

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
const double pointsBoxOpacity = 0.7;
const double progressLineHeight = 5;
const double progressLineWidth = 100;

const double pointsBadgeMT = 85;
double pointsBadgeML(Size screen) {return screen.width / 2 + 70;}
const double pointsBadgeOpacity = 0.9;
const double borderRadius = 15;

// Animations
const int shakeDelay = 500;
const int shakeDuration = 400;
const int addedPointsDuration = 4;
const int successDuration = 5;

